# Integration Anti-patterns

> **Classification:** INTEGRATION-GENERAL (unless marked PROJECT-SPECIFIC)
> Anti-patterns learned from M3 CE integration implementations.
> Entries promoted from implementation reviews and project retrospectives.

---

## Format

```markdown
## AP{N}: {Short name}

**Observed in:** [project or general observation]
**Symptom:** [What goes wrong — be specific]
**Root cause:** [Why it happens]
**How to avoid:**
- [Concrete rule / check]

**Classification:** [INTEGRATION-GENERAL / PROJECT-SPECIFIC / etc.]
```

---

## Entries

### AP1: Assuming master data is complete without validation

**Observed in:** HSBC ISO 20022 project (master data validation SQL created as remediation)
**Symptom:** Integration fails at go-live because supplier BIC codes are missing, invalid, or contain spaces/lowercase characters.
**Root cause:** Master data is maintained by business users without awareness of integration requirements. BIC/SWIFT fields that are optional in the M3 UI become mandatory for the integration.
**How to avoid:**
- Run master data validation queries before SIT, not after UAT.
- Define data validation as a milestone with an owner (business, not IT).
- Include data validation results as an entry criterion for UAT.
- Re-validate after any data cleansing before go-live.

**Classification:** INTEGRATION-GENERAL

---

### AP2: Designing only the happy path

**Symptom:** Integration works in testing but fails in production when a supplier has a missing field, an unexpected character in an address, or a network timeout.
**Root cause:** Error handling, retry, and monitoring are not designed alongside the happy path.
**How to avoid:**
- Define error handling before technical design is approved (not as an afterthought).
- Include negative test cases in the test plan: missing BIC, invalid BIC, missing address, empty amount, duplicate payment reference.
- Define monitoring and alerting as part of the deployment scope.

**Classification:** INTEGRATION-GENERAL

---

### AP3: Treating bank-specific requirements as universal ISO 20022

**Symptom:** An ISO 20022 field requirement learned from one bank is applied to all banks, causing rejection by banks with different requirements.
**Root cause:** Bank-specific format specifications are not read. Assumptions are made based on the standard.
**How to avoid:**
- Always read the bank's file format specification before designing.
- Classify every requirement as ISO-STANDARD, BANK-SPECIFIC, or COUNTRY-REGULATORY.
- Store bank-specific requirements in project knowledge, not global knowledge.

**Classification:** INTEGRATION-GENERAL

---

### AP4: Skipping acknowledgement and reconciliation design

**Symptom:** Payment files are delivered to the bank but the system has no way to confirm whether payments were processed, rejected, or need resubmission.
**Root cause:** Outbound delivery is designed but the response handling loop is not.
**How to avoid:**
- Always ask: "What does the bank send back after receiving the file?"
- Design the full round-trip: outbound → acknowledgement → reconciliation.
- Include acknowledgement handling in the interface specification.
- Test acknowledgement processing as part of SIT.

**Classification:** INTEGRATION-GENERAL

---

### AP5: Not separating Global M3 knowledge from project-specific observations

**Symptom:** A field name, program name, or validation rule observed in one project is applied incorrectly to another project, causing confusion or defects.
**Root cause:** Implementation knowledge is stored without classification.
**How to avoid:**
- Always classify observations as M3-GENERAL, PROJECT-SPECIFIC, BANK-SPECIFIC, REGULATORY, or UNKNOWN.
- Store project-specific observations in `projects/{code}/knowledge/`, not in `knowledge/`.
- Verify before promoting any observation to M3-GENERAL status.

**Classification:** INTEGRATION-GENERAL

---

### AP6: Using ION API credentials from one environment in another

**Observed in:** HSBC project — a `.ionapi` file exists for TST environment.
**Symptom:** Integration fails because TST credentials are used in PRD, or PRD data is accessed during testing.
**Root cause:** Environment-specific credential files are not carefully managed.
**How to avoid:**
- Maintain separate `.ionapi` credential files per environment (TST, PRE, PRD).
- Never commit `.ionapi` files to version control.
- Label credential files clearly with environment suffix.
- Do not share credentials between environments or team members without rotation.

**Classification:** PROJECT-SPECIFIC (observed) / INTEGRATION-GENERAL (applies broadly)
