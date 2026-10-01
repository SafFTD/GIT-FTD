# Workflow: new-integration

> **M3 Implementor workflow — source of truth.**
> Use this workflow when a new integration requirement is identified and needs to be
> analysed, designed, specified, developed, tested, and deployed.

---

## When to use this workflow

- A new interface between M3 and an external system is required.
- A new payment integration, EDI connection, or API-based exchange needs to be implemented.
- A business requirement has been raised that cannot be satisfied by standard M3 configuration alone.

---

## Step 1 — Understand the business requirement

**Agent:** m3-business-analyst (run in parallel with Step 2 if context is sufficient)

**Activities:**
- Frame the business problem. What is the customer trying to achieve?
- Identify the business process affected.
- Identify stakeholders.
- Define scope boundaries (in / out).
- Identify regulatory factors.
- Raise open questions.

**Output:** Business analysis section in the integration working document.
**Checkpoint:** Confirm business need with the user before proceeding.

---

## Step 2 — Assess standard M3 capability (standard-first)

**Agent:** m3-functional-consultant

**Activities:**
- Identify the M3 process area.
- Assess what standard M3 CE already provides.
- Identify the gap (what standard M3 does not cover).
- Propose solution options in standard-first order: Configuration → Extension → Integration.
- Identify whether integration is actually necessary.

**Output:** Functional analysis with standard M3 assessment and gap identification.
**Checkpoint:** Confirm that integration is the right approach before proceeding to Step 3.
**Stop condition:** If standard M3 configuration or extension can solve the requirement, STOP here and follow a configuration/extension path instead.

---

## Step 3 — Design integration architecture

**Agent:** m3-integration-specialist

**Activities:**
- Define source and target systems.
- Select integration technology (ION / MEC / IPA / SFTP / API / other).
- Define direction (outbound / inbound / bidirectional).
- Define format (ISO 20022 / EDI / CSV / XML / JSON / other).
- Define trigger mechanism (event-driven / scheduled / manual).
- Define delivery method (SFTP / API / ION connection point).
- Identify M3 interface point (MI program / API / program).
- Identify data dependencies (M3 tables, master data).
- Design acknowledgement and reconciliation approach.
- Design error handling and retry approach.
- Run gap detection on the integration architecture.

**Output:** Integration architecture document.
**Checkpoint:** Confirm architecture with the user.

---

## Step 4 — Identify master data requirements

**Agent:** m3-data-analyst (run in parallel with Step 5)

**Activities:**
- Identify which M3 master data fields the integration depends on.
- Define field population requirements (mandatory for integration).
- Define validation rules for each field.
- Identify potential data gaps.
- Recommend validation queries.
- Define data ownership and cleansing timeline.

**Output:** Master data requirements and validation approach.

---

## Step 5 — Design technical solution

**Agent:** m3-technical-architect (run in parallel with Step 4)

**Activities:**
- Select M3 programs and APIs (only from confirmed evidence — never invented).
- Design data flow in detail.
- Design field mapping (source → target).
- Design transformation and derivation logic.
- Design validation rules.
- Design error handling (each error scenario).
- Design acknowledgement processing.
- Design monitoring approach.

**Output:** Technical specification and interface specification sections.

---

## Step 6 — Review and identify gaps

**Agent:** m3-reviewer

**Activities:**
- Apply full gap detection checklist.
- Verify source attribution.
- Identify missing documents.
- Identify unrecorded decisions.
- Identify open questions.
- Flag must-address vs should-address findings.

**Output:** Review findings and gap assessment.
**Checkpoint:** Resolve all must-address findings before proceeding.

---

## Step 7 — Design test strategy

**Agent:** m3-test-planner

**Activities:**
- Map requirements to test scenarios.
- Design SIT test cases (happy path + negative tests).
- Define test data requirements.
- Define entry and exit criteria.
- Design UAT acceptance criteria.

**Output:** Test strategy and SIT/UAT test cases.

---

## Step 8 — Design deployment approach

**Agent:** m3-technical-architect

**Activities:**
- Define deployment steps.
- Identify deployment dependencies (master data, environment readiness, security).
- Define rollback approach.
- Define cutover approach.
- Define monitoring setup.

**Output:** Deployment plan and cutover checklist.

---

## Step 9 — Register the integration

Create or update:
- `projects/{project-code}/integrations/{integration-name}.md` — integration descriptor
- `projects/{project-code}/documents.md` — add all new documents to the index
- `projects/{project-code}/decisions/decisions.md` — record any decisions made
- `projects/{project-code}/open-questions/questions.md` — record open questions

---

## Step 10 — Memory review

Aggregate all agent memory candidates. For each:
- Determine the target memory file.
- Check for existing entries covering the same fact.
- Promote approved entries.

**Classification check:** Before promoting to global knowledge (`knowledge/`), verify the entry is M3-GENERAL or INTEGRATION-GENERAL — not project-specific.

---

## End with

"New integration workflow complete. Integration: [{name}]. Next step: proceed to build or flag open questions for resolution."

---

## Constraints

- Do not skip Step 2 (standard-first assessment). Every integration must be justified.
- Do not proceed past Step 6 until must-address review findings are resolved.
- Do not invent M3 program names or API names — if unknown, record as UNKNOWN and identify the source needed.
- Do not mix project-specific knowledge with global knowledge.
