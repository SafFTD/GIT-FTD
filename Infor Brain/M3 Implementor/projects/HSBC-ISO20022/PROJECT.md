# HSBC H2H ISO 20022 — Project Context

> **Project code:** GC-CR-26-014
> **Classification:** PROJECT-SPECIFIC
> **Source documents:** `D:\GIT-FTD\Projects\GC-CR-26-014_HSBC H2H ISO 20022\` (READ-ONLY)
> **This file:** Derived knowledge only — do not copy source document content here.

---

## Project Identity

| Attribute | Value | Source | Classification |
|---|---|---|---|
| Project code | GC-CR-26-014 | Document filenames | PROJECT-SPECIFIC |
| Change request | GC-CR-26-021 (follow-on modification) | Document filename | PROJECT-SPECIFIC |
| Project name | HSBC H2H ISO 20022 Payment Integration | Document filenames | PROJECT-SPECIFIC |
| Customer | Gold Coin Group | XML payment files (InitgPty/OrgId) | CUSTOMER-SPECIFIC |
| Bank | HSBC | Document filenames, XML BIC codes | BANK-SPECIFIC |
| Implementation partner | FTD (from document prefix FTD_M3_FS) | Document filename | PROJECT-SPECIFIC |
| ION tenant | LCCGLNLPSVGTXCNE | GC_TST_DataPulse.ionapi | PROJECT-SPECIFIC |
| M3 environment (TST) | mingle-ionapi.se2.inforcloudsuite.com | GC_TST_DataPulse.ionapi | PROJECT-SPECIFIC |
| M3 data centre | SE2 | GC_TST_DataPulse.ionapi | PROJECT-SPECIFIC |

---

## Scope

### Business scope

| Dimension | Value | Classification |
|---|---|---|
| Integration type | Supplier payments via H2H (Host-to-Host) bank channel | INTEGRATION-GENERAL |
| Direction | M3 → HSBC (outbound payment file) | PROJECT-SPECIFIC |
| File protocol | SFTP | PROJECT-SPECIFIC / INTEGRATION-GENERAL |
| Message standard | ISO 20022 pain.001.001.03 | INTEGRATION-GENERAL |

### Countries in scope

| Country | Currency | Legal Entity | Evidence |
|---|---|---|---|
| Malaysia (MY) | MYR | Gold Coin Feedmills (M) Sdn Bhd – BW | XML samples — HSBC1, HSBC2, HSBC3 bank accounts |
| Vietnam (VN) | VND | Gold Coin Services Singapore Pte Ltd | XML samples — HSBC1 account, VN division |
| Singapore (SG) | USD | ABAQA International / Gold Coin Services | XML samples — HSBC2 account |
| Indonesia (ID) | IDR | Not confirmed from available files | XML Files\ID\ directory exists |

> Indonesia is in scope based on directory existence but entity name is not confirmed from the files read during audit.

### M3 scope

| Attribute | Value | Evidence | Classification |
|---|---|---|---|
| M3 company | 100 | ISO20022_Swift_BIC Master Data Validation_SQL V1.sql | PROJECT-SPECIFIC |
| M3 division | 001 | ISO20022_Swift_BIC Master Data Validation_SQL V1.sql | PROJECT-SPECIFIC |
| M3 module | Finance — Accounts Payable | Data validation SQL references FPLEDG, CBANAC, CIDADR | PROJECT-SPECIFIC |

---

## Key Stakeholders (from document evidence)

| Stakeholder | Role | Evidence |
|---|---|---|
| GCIT | Gold Coin IT team | Mentioned in `Swift_BIC Master Data Validation_GC_V0.1 Working.xlsx` |
| FTD | Implementation partner | Document prefix FTD_M3_FS |
| HSBC | Bank | Document titles, XML BIC codes |

---

## Implementation Status

| Stage | Status | Evidence |
|---|---|---|
| SCOPING | COMPLETE | Requirements PDF exists |
| DESIGN | COMPLETE | Functional Specification V2.0 exists |
| BUILD | COMPLETE (inferred) | Sample payment XML files exist — production-like content |
| SIT | COMPLETE (inferred) | TCD test scenario file exists |
| UAT | UNKNOWN | No UAT evidence found in audit |
| DEPLOYMENT | ACTIVE (inferred) | XML files dated 2026 — production dates |
| POST-GO-LIVE | ACTIVE | Change request GC-CR-26-021 exists (modification) |

> **Classification of status:** OBSERVATION (inferred from file evidence) — not from a formal status report.

---

## Document Index

See `documents.md` for the full classified document index.

---

## Key Source Documents (NOT to be modified)

| Filename | Estimated Role | Must read for |
|---|---|---|
| `FTD_M3_FS 1947_...V2.0.docx` | FNS (Functional Specification) — PRIMARY | M3 programs, MEC/ION details, mapping rules, validation |
| `GC-CR-26-014_HSBC H2H ISO 20022 Requirements.pdf` | BRD (Business Requirements) | Business scope, requirements |
| `GC-CR-26-021_Modification on Integration Payment File M3 XML file setup to HSBC.pdf` | CHG (Change Request) | Scope changes after initial deployment |
| `ISO20022_address_requirements (1).pdf` | REG or VDR | Address field requirements (regulatory or bank-specific) |
| `PP & ACH BI FAST XML V3-File Spec...Indonesia.docx` | VDR (Vendor/Bank Spec) | Indonesia payment format requirements |
| `vn_ffs_DynamicCSV_PP (1).pdf` | VDR (Vendor/Bank Spec) | Vietnam payment format requirements |
| `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` | CFG or validation artefact | BIC validation rules, M3 tables/fields used |
| `GC-CR-26-014_HSBC H2H ISO 20022_FTD_MS_EST 0475.xlsx` | EST (Estimate) | Effort and timeline |
| `5. MY- Finance -MT Upgrade Main Scenarios (29th Sep 2025).xlsx` | TCD/SIT (Test) | Malaysia test scenarios |

---

## Critical Gaps Identified

| Gap | Type | Detail | Action |
|---|---|---|---|
| M3 programs not confirmed | UNKNOWN | The functional specification has not been read — program names are unknown | Read FTD_M3_FS 1947 |
| MEC/ION tool chain not confirmed | UNKNOWN | Whether MEC, ION, or IPA generates the payment file is not established | Read FTD_M3_FS 1947 |
| Acknowledgement mechanism | UNKNOWN | Bank ACK handling not observed in available files | Read FTD_M3_FS 1947 |
| Inbound flow not documented | UNKNOWN | Only outbound XML observed — no inbound ACK file examples | Seek from team |
| UAT status | UNKNOWN | No UAT evidence found | Seek from team |
| Indonesia entity name | UNKNOWN | ID directory exists but no XML samples read fully | Read ID XML files |
| GC-CR-26-021 scope | UNKNOWN | Change request PDF not read | Read GC-CR-26-021 |
| address_requirements content | UNKNOWN | ISO20022_address_requirements.pdf not read | Read PDF |
