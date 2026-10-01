# HSBC Project — Open Questions

> **Classification:** PROJECT-SPECIFIC
> **Status:** Generated from repository audit 2026-09-30
> **Owner for resolution:** Implementation team / GCIT / HSBC

---

## Open Question Format

```markdown
### Q{NNN}: {Short title}

**Category:** [BUSINESS / FUNCTIONAL / TECHNICAL / DATA / INTEGRATION / SECURITY / REGULATORY / TESTING / DEPLOYMENT / OPERATIONS]
**Priority:** [BLOCKER / HIGH / MEDIUM / LOW]
**Status:** [OPEN / IN PROGRESS / RESOLVED]
**Owner:** [who must answer this]
**Source needed:** [which document or person can answer this]

**Question:** [Full question text]
**Context:** [Why this question matters]
**Impact if unresolved:** [What cannot proceed without this answer]
```

---

## Open Questions

### Q001: What M3 programs are used to generate the payment file?

**Category:** TECHNICAL
**Priority:** HIGH
**Status:** OPEN
**Owner:** FTD Technical Team
**Source needed:** `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx` (D01)

**Question:** Which specific M3 programs (AP payment programs) trigger the payment file generation process?
**Context:** The functional specification has not been read. Program names are unknown.
**Impact if unresolved:** Cannot fully populate the integration descriptor. Cannot answer technical questions about the M3 side of the integration.

---

### Q002: Is MEC, ION, IPA, or another tool used to generate the payment XML file?

**Category:** TECHNICAL
**Priority:** BLOCKER
**Status:** OPEN
**Owner:** FTD Technical Team
**Source needed:** D01 (Functional Specification)

**Question:** What is the technical tool chain for generating the ISO 20022 XML payment file from M3 data?
**Context:** Multiple Infor tools can generate file-based integrations (MEC, IPA, custom development). The specific tool determines configuration, maintenance, and troubleshooting approach.
**Impact if unresolved:** Cannot complete the integration architecture. Cannot provide accurate technical guidance for this integration.

---

### Q003: What is the acknowledgement mechanism from HSBC?

**Category:** INTEGRATION
**Priority:** HIGH
**Status:** OPEN
**Owner:** FTD Technical Team / HSBC
**Source needed:** D01 (Functional Specification), D02 (Business Requirements)

**Question:** Does HSBC send a payment status report (e.g. ISO 20022 pain.002) after processing the payment file? If so, what format, via what channel, and how is it processed in M3?
**Context:** No inbound acknowledgement files or processing mechanisms were observed in the project directory.
**Impact if unresolved:** Cannot assess ACKNOWLEDGEMENT-GAP. Cannot confirm if reconciliation is implemented.

---

### Q004: What happens in M3 when the bank rejects a payment?

**Category:** INTEGRATION / BUSINESS
**Priority:** HIGH
**Status:** OPEN
**Owner:** GCIT / FTD
**Source needed:** D01 (Functional Specification), D02 (Business Requirements)

**Question:** If HSBC rejects a payment (invalid BIC, insufficient funds, regulatory block), what process exists to notify M3, reverse or flag the payment, and manage resubmission?
**Context:** Error handling for rejected payments is a critical production operations concern.
**Impact if unresolved:** MONITORING-GAP and ACKNOWLEDGEMENT-GAP remain open. Production support process is undefined.

---

### Q005: What changes did GC-CR-26-021 make to the integration?

**Category:** FUNCTIONAL / TECHNICAL
**Priority:** HIGH
**Status:** OPEN
**Owner:** FTD / GCIT
**Source needed:** `GC-CR-26-021_Modification on Integration Payment File M3 XML file setup to HSBC.pdf` (D04)

**Question:** What specific changes to the payment file format or M3 XML setup were made by change request GC-CR-26-021? Has it been fully implemented?
**Context:** The change request document exists but was not read during audit. The current integration descriptor may not reflect post-CR-26-021 state.
**Impact if unresolved:** Integration descriptor may be incomplete or outdated.

---

### Q006: Is the Town/Country address requirement an ISO 20022 standard or HSBC-specific?

**Category:** REGULATORY / TECHNICAL
**Priority:** MEDIUM
**Status:** OPEN
**Owner:** FTD / Regulatory review
**Source needed:** `ISO20022_address_requirements (1).pdf` (D05)

**Question:** Does the ISO 20022 standard mandate Town and Country in postal addresses, or is this an HSBC-specific bank requirement?
**Context:** The data validation SQL requires Town and Country. The address requirements PDF exists but was not read. This classification affects whether the validation applies to other banks and countries.
**Impact if unresolved:** Knowledge classification remains UNKNOWN. Cannot generalise the address validation rule to other implementations.

---

### Q007: What is the SFTP server and directory structure?

**Category:** TECHNICAL / SECURITY
**Priority:** HIGH
**Status:** OPEN
**Owner:** FTD / GCIT / HSBC
**Source needed:** D01 (Functional Specification) or HSBC H2H technical guide

**Question:** What are the SFTP server details (host, port, directory structure, naming convention, schedule) for outbound payment file delivery to HSBC?
**Context:** SFTP details are not available from the files read during audit. The `.ionapi` file suggests ION API is used for M3 data access — the SFTP delivery may be a separate mechanism.
**Impact if unresolved:** Cannot complete the delivery section of the integration descriptor. Cannot validate operational procedures.

---

### Q008: What is the UAT status of this integration?

**Category:** TESTING
**Priority:** MEDIUM
**Status:** OPEN
**Owner:** GCIT / Project Manager
**Source needed:** Project status update or UAT sign-off document

**Question:** Was formal UAT completed and signed off? If so, when and by whom?
**Context:** No UAT sign-off document was found in the project directory. XML files with 2026 dates suggest production is active.
**Impact if unresolved:** Cannot confirm UAT-GAP is closed.

---

### Q009: What is the full scope of Indonesia (ID) implementation?

**Category:** FUNCTIONAL / TECHNICAL
**Priority:** MEDIUM
**Status:** OPEN
**Owner:** FTD
**Source needed:** D01 (Functional Specification), D06 (Indonesia BI FAST spec)

**Question:** What is the exact scope and format for Indonesia payments? The XML Files\ID directory exists but no Indonesia XML samples were in the Sample Payment files directory. Is Indonesia live or still in development?
**Context:** The Indonesia BI FAST specification document suggests specific format requirements that may differ from standard ISO 20022.
**Impact if unresolved:** Cannot complete the scope section of the HSBC project. Cannot advise on Indonesia-specific requirements.

---

### Q010: Is the BIC 'XXX' branch code rejection rule correct for all countries?

**Category:** REGULATORY / TECHNICAL
**Priority:** LOW
**Status:** OPEN
**Owner:** FTD / GCIT
**Source needed:** HSBC bank specification or formal decision record

**Question:** Is the rejection of BIC branch code 'XXX' a universal requirement for this integration, or does it apply only to specific countries or payment types? Was this a formal project decision?
**Context:** The validation SQL rejects 'XXX' branch codes. This was implemented but no decision record exists confirming the rationale.
**Impact if unresolved:** Data validation may incorrectly flag valid BICs in some scenarios. Decision should be documented.

---

## Resolved Questions

*None yet. Move questions here with resolution details when answered.*

```markdown
### Q{NNN}: {Title} — RESOLVED

**Resolved by:** [person / document]
**Resolution date:** [date]
**Resolution:** [answer]
**Classification:** [updated classification]
```
