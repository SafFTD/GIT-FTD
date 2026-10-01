# M3 Implementation — Gotchas

> **Classification:** INTEGRATION-GENERAL / M3-GENERAL
> "We hit this once. Don't again."
> Specific traps, surprises, and technical gotchas in M3 CE implementations.
> Promoted here via the `remember` workflow.
>
> **Do NOT add PROJECT-SPECIFIC gotchas here.**
> Project-specific observations belong in `projects/{code}/knowledge/`.

---

## Format

```markdown
## G{N}: {Short title}

**Classification:** [M3-GENERAL / INTEGRATION-GENERAL]
**Evidence:** [Project / document where this was encountered]

**Symptom:** [What you observe — be specific]
**Cause:** [Why it actually happens]
**How to avoid:**
- [Concrete rule / check]

**Related:** [Anti-pattern reference if applicable]
```

---

## Entries

### G1: BIC lowercase characters cause silent failure

**Classification:** INTEGRATION-GENERAL
**Evidence:** HSBC project — data validation SQL explicitly checks for lowercase BIC characters.

**Symptom:** Payment file is generated but the bank rejects it. The BIC in M3 appears correct visually but fails bank-side validation.
**Cause:** M3 CBANAC.BAF4 may have been entered in lowercase (e.g. `hsbcvnvxxxx` instead of `HSBCVNVXXXX`). The field accepts lowercase input but ISO 9362 requires uppercase. The bank rejects the file.
**How to avoid:**
- Include BIC case validation (`bic_raw <> bic_clean`) in master data validation before SIT.
- Train data entry users to enter BIC in uppercase.
- Consider adding an M3 validation rule or interface-level normalisation (with team agreement).

---

### G2: Empty address tags (`<TwnNm/>`) are generated for suppliers with missing address data

**Classification:** INTEGRATION-GENERAL
**Evidence:** HSBC project XML samples (VN file, SG file) — `<TwnNm/>` and `<PstCd/>` present as empty tags.

**Symptom:** Payment file is generated successfully in M3 but certain suppliers have empty address tags in the XML. The bank may reject these payments.
**Cause:** When CIDADR.TOWN is null or empty, the integration still generates the XML element but with no content. The ISO 20022 standard (or bank requirement) requires a populated Town.
**How to avoid:**
- Run address validation before SIT to identify suppliers with missing TOWN.
- Do NOT allow the integration to generate files for suppliers with missing mandatory address fields without a defined error handling approach.
- Define the expected behaviour: skip the supplier, generate an error, or halt the file.

---

### G3: BAF4 and SWBI may differ — only one is used by the integration

**Classification:** INTEGRATION-GENERAL (specific to projects using M3 CBANAC)
**Evidence:** HSBC project data validation SQL reads BAF4 as primary, SWBI as reference.

**Symptom:** A supplier's BIC appears correct in one M3 screen but the integration uses a different field that has incorrect or empty data.
**Cause:** M3 CBANAC has multiple BIC-related fields. If the project uses BAF4 as the source and a user populates SWBI (or vice versa), the data appears entered but the integration cannot find it.
**How to avoid:**
- Clearly document which field the integration reads (BAF4 or SWBI) in the data entry guide for business users.
- Include both fields in the data validation output for comparison.
- If both fields are populated with different values, flag for review.

---

### G4: ION API `.ionapi` credentials are environment-specific and must not cross environments

**Classification:** INTEGRATION-GENERAL
**Evidence:** HSBC project — `GC_TST_DataPulse.ionapi` exists only for TST environment.

**Symptom:** Integration works in TST but fails in PRD, or PRD data is accidentally accessed during testing.
**Cause:** ION API credential files (`.ionapi`) contain environment-specific tenant IDs, client credentials, and service account keys. Using a TST credential against the PRD ION endpoint will fail or (worse) if the same tenant has both environments, may cross-contaminate.
**How to avoid:**
- Maintain separate `.ionapi` files per environment, clearly labelled (e.g. `{tenant}_TST.ionapi`, `{tenant}_PRD.ionapi`).
- Never commit `.ionapi` files to version control — they contain secrets.
- Verify the environment name in the `.ionapi` file before use.
