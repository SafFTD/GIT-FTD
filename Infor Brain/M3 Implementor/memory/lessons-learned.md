# M3 Implementation — Lessons Learned

> **Classification:** INTEGRATION-GENERAL / M3-GENERAL
> Cross-project learnings that apply broadly to M3 CE implementations.
> Entries promoted here via the `remember` workflow.
>
> **Do NOT add PROJECT-SPECIFIC observations here.**
> Project-specific learnings belong in `projects/{code}/knowledge/`.

---

## Format

```markdown
## L{N}: {Short title}

**Context:** [Which project or general implementation work this came from]
**Classification:** [M3-GENERAL / INTEGRATION-GENERAL]
**Evidence:** [Source project / document]

**What we learned:** [The insight in plain language]
**Why it matters:** [How this changes future decisions or approaches]
**Applies to:** [Future situations where this lesson is relevant]
```

---

## Entries

### L1: Master data validation must happen before SIT, not after UAT

**Context:** HSBC ISO 20022 project (GC-CR-26-014) — BIC/address validation SQL created.
**Classification:** INTEGRATION-GENERAL
**Evidence:** Data validation SQL script and master data extracts created as part of the project.

**What we learned:** Payment integrations that depend on BIC/SWIFT codes and supplier addresses will fail at runtime if master data is incomplete. Running data validation after UAT is too late — defects found after UAT sign-off are costly to resolve.

**Why it matters:** Master data cleansing must be treated as a project deliverable with an owner and a deadline, not as an afterthought. It should be validated before SIT.

**Applies to:** Any integration that reads supplier/customer master data for file generation (payment files, EDI, ASN, etc.).

---

### L2: Always read the bank's technical specification before designing

**Context:** HSBC ISO 20022 project — country-specific format specs (ID, VN) exist and vary.
**Classification:** INTEGRATION-GENERAL
**Evidence:** `PP & ACH BI FAST XML V3-File Spec...Indonesia.docx` and `vn_ffs_DynamicCSV_PP (1).pdf` in HSBC project.

**What we learned:** Banks may require country-specific format variations that differ significantly from the base ISO 20022 standard. Indonesia requires BI FAST compliance; Vietnam has DynamicCSV requirements. Designing without reading these specs will lead to rejection.

**Why it matters:** Bank-specific and country-specific requirements cannot be assumed or guessed. Each variant must be explicitly sourced from the bank's technical specification before design begins.

**Applies to:** Any multi-country bank integration; any integration where the bank provides a file format specification.

---

### L3: Change requests must be tracked in the decision log — current-state confusion is a project risk

**Context:** HSBC ISO 20022 project — GC-CR-26-021 exists as a post-deployment modification.
**Classification:** INTEGRATION-GENERAL
**Evidence:** GC-CR-26-021 change request PDF in project directory.

**What we learned:** After a change request, the integration specification may no longer match the implementation. If the change request is not tracked and its impact is not recorded in the integration descriptor, future team members will work from incorrect assumptions.

**Why it matters:** Every change request must update: the integration descriptor, the decision log, the field mapping, the test cases, and the deployment plan. A change request that only updates the code leaves a documentation gap.

**Applies to:** Any implemented integration that receives a post-deployment change request.
