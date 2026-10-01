# HSBC ISO 20022 — Document Index

> **Classification:** PROJECT-SPECIFIC
> **Purpose:** Index of all documents in the HSBC project with role classification and read status.
> Documents are NOT copied here — only referenced. Source location is READ-ONLY.
> **Source location:** `D:\GIT-FTD\Projects\GC-CR-26-014_HSBC H2H ISO 20022\`

---

## Document Registry

| # | Filename | Role Code | Role Name | Classification | Read | Key content |
|---|---|---|---|---|---|---|
| D01 | `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx` | FNS | Functional Specification | PROJECT-SPECIFIC | ❌ NOT READ | PRIMARY document — M3 programs, MEC/ION, mapping, validation rules |
| D02 | `GC-CR-26-014_HSBC H2H ISO 20022 Requirements.pdf` | BRD | Business Requirement | PROJECT-SPECIFIC | ❌ NOT READ | Business requirements, scope |
| D03 | `GC-CR-26-014_HSBC H2H ISO 20022_FTD_MS_EST 0475.xlsx` | EST | Estimate | PROJECT-SPECIFIC | ❌ NOT READ | Effort, timeline |
| D04 | `GC-CR-26-021_Modification on Integration Payment File M3 XML file setup to HSBC.pdf` | CHG | Change Request | PROJECT-SPECIFIC | ❌ NOT READ | Post-deployment modification scope |
| D05 | `ISO20022_address_requirements (1).pdf` | REG/VDR | Address Requirements | REGULATORY or BANK-SPECIFIC (TBD) | ❌ NOT READ | Address field requirements for ISO 20022 |
| D06 | `PP & ACH BI FAST XML V3-File Spec, Sample & Regulatory Reporting for Indonesia - Last Update 20260204.docx` | VDR | Bank/Regulatory Spec | BANK-SPECIFIC / REGULATORY | ❌ NOT READ | Indonesia payment format (BI FAST, PP, ACH) |
| D07 | `vn_ffs_DynamicCSV_PP (1).pdf` | VDR | Bank Spec | BANK-SPECIFIC | ❌ NOT READ | Vietnam bank payment format (DynamicCSV) |
| D08 | `Data Validation template\ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` | CFG/Tool | Data Validation Script | PROJECT-SPECIFIC | ✅ READ | BIC/address validation SQL, M3 tables and fields |
| D09 | `Data Validation template\ISO20022_Swift_BIC Master Data Validation_SQL V1.xlsx` | CFG/Tool | Data Validation Workbook | PROJECT-SPECIFIC | ❌ NOT READ | Excel version of validation |
| D10 | `Data Validation template\Swift_BIC Master Data Validation_GC_V0.1 Working.xlsx` | SIT/Tool | Validation Results | PROJECT-SPECIFIC | ❌ NOT READ | Working validation results |
| D11 | `Data Validation template\Bank Accounts BIC-SWIFT codes check.csv` | SIT/Tool | BIC Check Results | PROJECT-SPECIFIC | ❌ NOT READ | BIC validation results |
| D12 | `Data Validation template\CBANAC.xlsx` | DATA | Master Data Extract | PROJECT-SPECIFIC | ❌ NOT READ | Supplier bank account data extract |
| D13 | `Data Validation template\CIDADR.xlsx` | DATA | Master Data Extract | PROJECT-SPECIFIC | ❌ NOT READ | Supplier address data extract |
| D14 | `Data Validation template\CIDMAS.xlsx` | DATA | Master Data Extract | PROJECT-SPECIFIC | ❌ NOT READ | Supplier master data extract |
| D15 | `Data Validation template\FPLBAL.xlsx` | DATA | Master Data Extract | PROJECT-SPECIFIC | ❌ NOT READ | AP balance data extract |
| D16 | `Data Validation template\FPLEDG.xlsx` | DATA | Master Data Extract | PROJECT-SPECIFIC | ❌ NOT READ | AP ledger data extract |
| D17 | `DataPulse\GC_TST_DataPulse.ionapi` | CFG | ION API Credentials | PROJECT-SPECIFIC ⚠️ SENSITIVE | ✅ READ (structure only) | ION API connection for TST environment |
| D18 | `TCD\5. MY- Finance -MT Upgrade Main Scenarios (29th Sep 2025).xlsx` | TCS/SIT | Test Scenarios | PROJECT-SPECIFIC | ❌ NOT READ | Malaysia MT upgrade test scenarios |
| D19–D24 | `Sample Payment files\*.xml` (6 files) | SIT | Sample Payment Files | PROJECT-SPECIFIC | ✅ READ | Real pain.001.001.03 XML files — MY, VN, SG currencies |
| D25–D27 | `XML Files\MY\*.xml` (3 files) | SIT | Country XML Files | PROJECT-SPECIFIC | ❌ NOT READ | Malaysia XML files |
| D28 | `XML Files\ID\*.xml` | SIT | Country XML Files | PROJECT-SPECIFIC | ❌ NOT READ | Indonesia XML files |
| D29 | `XML Files\SG\*.xml` | SIT | Country XML Files | PROJECT-SPECIFIC | ❌ NOT READ | Singapore XML files |
| D30 | `XML Files\VN\*.xml` | SIT | Country XML Files | PROJECT-SPECIFIC | ❌ NOT READ | Vietnam XML files |

---

## Priority Reading List

These documents should be read next to fill the most critical knowledge gaps:

| Priority | Document | Gap it fills |
|---|---|---|
| 1 | D01 — Functional Specification (FNS) | M3 programs, MEC/ION tool chain, mapping rules, validation, acknowledgement mechanism |
| 2 | D02 — Business Requirements (BRD) | Business scope, specific requirements, decisions |
| 3 | D04 — Change Request GC-CR-26-021 | What changed after initial deployment |
| 4 | D05 — ISO20022 Address Requirements | Whether Town/Country requirement is ISO standard or HSBC-specific |
| 5 | D11 — BIC Check Results CSV | Current BIC validation status for in-scope suppliers |

---

## Document Relationship Graph (Current Knowledge)

```
D02 (BRD) ──→ [D01 (FNS) — NOT READ]
                    │
                    ├──→ [TNS — NOT FOUND]
                    │         └──→ [IFS — NOT FOUND]
                    │                   └──→ [MAP — NOT FOUND]
                    │                               └──→ [TCS — partially: D18]
                    │
                    └──→ D08 (Data Validation SQL — read)
                               └──→ D10–D16 (validation results + data extracts)

D04 (CHG) — NOT READ — post-deployment modification

D06, D07 — Vendor specs (country-specific format requirements — not read)
```

### Gap assessment from document graph

| Gap type | Detail |
|---|---|
| DESIGN-GAP | TNS (Technical Specification) — not found in project directory |
| DESIGN-GAP | IFS (Interface Specification) — not found in project directory |
| MAPPING-GAP | MAP (Mapping Specification) — not found in project directory |
| TEST-GAP | TCS in depth — only TCD Excel found, not read |
| DEPLOYMENT-GAP | DPL (Deployment Plan) — not found in project directory |
| MONITORING-GAP | RNB (Runbook) — not found in project directory |

> **Note:** Technical specification, interface specification, mapping specification, deployment plan, and runbook may be embedded in the Functional Specification (D01) or may exist outside the scanned directory. This gap assessment is based on directory inspection only. Read D01 to confirm.
