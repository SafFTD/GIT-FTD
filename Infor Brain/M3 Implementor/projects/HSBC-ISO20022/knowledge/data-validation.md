# HSBC Project — Data Validation Rules

> **Classification:** PROJECT-SPECIFIC (validation SQL and results); Some rules INTEGRATION-GENERAL (ISO 9362 BIC format)
> **Source:** D08 — `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql`
> **Read status:** ✅ READ (full SQL reviewed during audit)

---

## Purpose of Validation

Before the ISO 20022 payment integration can be used reliably, supplier master data must meet the quality requirements imposed by the payment file format. The data validation SQL was created to identify suppliers that cannot be included in payment files due to missing or invalid data.

---

## Scope of Validation

| Attribute | Value | Classification |
|---|---|---|
| M3 Company | 100 | PROJECT-SPECIFIC |
| M3 Division | 001 | PROJECT-SPECIFIC |
| AP activity window | Last 3 years (YEA4 >= 2023) | PROJECT-SPECIFIC (scope decision) |
| Bank account indicator | BKIN = 'INTG' | PROJECT-SPECIFIC (filter) |
| Bank account status | STAT = '20' | PROJECT-SPECIFIC (filter) |

---

## BIC / SWIFT Validation Rules

**Source field in M3:** `CBANAC.BAF4` (primary BIC field in this project)
**Reference field:** `CBANAC.SWBI` (alternate SWIFT field — also extracted for reference)

| Rule ID | Rule | Error label | Classification |
|---|---|---|---|
| BIC-01 | BIC must not be null or empty | `INVALID - BIC Missing` | INTEGRATION-GENERAL |
| BIC-02 | BIC must not contain spaces | `INVALID - Contains Spaces` | INTEGRATION-GENERAL |
| BIC-03 | BIC length must be 8 or 11 characters | `INVALID - Incorrect Length` | INTEGRATION-GENERAL (ISO 9362) |
| BIC-04 | BIC must be uppercase (BIC raw = BIC clean) | `INVALID - Lowercase Characters` | INTEGRATION-GENERAL |
| BIC-05 | Positions 1–6 must be A–Z | `INVALID - Invalid Characters/Format` | INTEGRATION-GENERAL (ISO 9362) |
| BIC-06 | Positions 7–8 must be A–Z or 0–9 | `INVALID - Invalid Characters/Format` | INTEGRATION-GENERAL (ISO 9362) |
| BIC-07 | Positions 9–11 (if 11-char) must be A–Z or 0–9 | `INVALID - Invalid Branch Code` | INTEGRATION-GENERAL (ISO 9362) |
| BIC-08 | Branch code 'XXX' is not acceptable | `INVALID - Dummy Branch Code (XXX)` | PROJECT-SPECIFIC / BANK-SPECIFIC — see note |

> **BIC-08 classification note:** The rejection of 'XXX' branch code is implemented in this project's SQL. Whether 'XXX' is universally rejected by all banks and ISO 20022 implementations requires verification. Do not promote to INTEGRATION-GENERAL without confirmation.

**Overall BIC result:** `VALID` or `REVIEW`

---

## Address Validation Rules

**Source tables:** `CIDADR` (preferred: ADTE=10 Bank Address, fallback: ADTE=1 Postal Address)

| Rule ID | Rule | Error label | Classification |
|---|---|---|---|
| ADR-01 | Supplier must have at least one address record (ADTE in 1, 10) | `INVALID - No Address Found` | PROJECT-SPECIFIC (validation scope) |
| ADR-02 | Town/City (TOWN) must be populated | `INVALID - Town/City Missing` | REGULATORY (ISO 20022 requirement — pending verification vs D05) |
| ADR-03 | Country (CSCD) must be populated | `INVALID - Country Missing` | REGULATORY (ISO 20022 requirement — pending verification vs D05) |
| ADR-04 | Both TOWN and CSCD missing | `INVALID - Town/City and Country Missing` | REGULATORY |

**Address type priority:**
1. ADTE = 10 (Bank Address) — preferred
2. ADTE = 1 (Postal Address) — fallback when no Bank Address exists

**Address validation result:** `VALID` or `INVALID - {reason}`

---

## Combined Validation Status

| Result | Conditions |
|---|---|
| `PASS` | BIC is VALID AND address record exists AND TOWN is populated AND CSCD is populated |
| `REVIEW` | Any one of the BIC or address rules fails |

**Column name in output:** `Overall Review Status`

---

## SQL Output Columns Reference

The validation SQL produces the following columns:

| Column | Source | Purpose |
|---|---|---|
| Company | FPLEDG.CONO | M3 company |
| Division | FPLEDG.DIVI | M3 division |
| Supplier Number | CBANAC.ACHO | Supplier identifier |
| Supplier Name | CIDADR.SUNM | Supplier display name |
| Divisions Used (In Scope) | COUNT OVER partition | How many divisions use this supplier |
| Last AP Activity Year | MAX(FPLEDG.YEA4) | Most recent AP year |
| Last AP Accounting Date | MAX(FPLEDG.ACDT) | Most recent AP date |
| AP Transaction Count | COUNT(*) from FPLEDG | Transaction volume |
| Bank Account ID | CBANAC.BKID | Bank account identifier |
| Bank Account Indicator | CBANAC.BKIN | INTG for integration accounts |
| Bank Account Type Code | CBANAC.BKTP | Account type |
| Bank Account Name | CBANAC.BANA | Account description |
| Bank Number | CBANAC.BKNO | Bank identifier |
| Bank Account Number | CBANAC.BACN | Account number |
| IBAN | CBANAC.IBAN | IBAN if applicable |
| Account Currency | CBANAC.CUCD | Currency |
| Bank Master Division | CBANAC.DIVI | Division on bank master |
| SWIFT/BIC (BAF4) | CBANAC.BAF4 (raw) | Primary BIC field |
| SWIFT/BIC (SWBI field) | CBANAC.SWBI | Alternate SWIFT field |
| BIC Length | LENGTH(BAF4) | For validation review |
| BIC Validation Status | Derived | VALID or INVALID reason |
| Address Source | CIDADR.ADTE | Which address type was selected |
| Address Line 1–4 | CIDADR.ADR1–ADR4 | Address lines |
| Postal Code | CIDADR.PONO | Postal code |
| Town/City | CIDADR.TOWN | Town (required for ISO 20022) |
| State | CIDADR.ECAR | State/province |
| Country | CIDADR.CSCD | Country code (required for ISO 20022) |
| Address Validation Status | Derived | VALID or INVALID reason |
| Overall Review Status | Derived | PASS or REVIEW |

---

## Validation Process Recommendation

**Source:** OBSERVATION from SQL existence; RECOMMENDATION from M3 Implementor

1. **Pre-SIT:** Run D08 SQL against TST environment. Review all REVIEW-status records.
2. **Pre-UAT:** All critical suppliers must be PASS status.
3. **Pre-production:** Re-run validation in PRD environment before go-live cutover.
4. **Post-data-cleansing:** Re-run after any data cleansing to confirm improvement.
5. **Ongoing:** Consider running validation monthly or before each payment run as a data quality check.

**Data cleansing ownership:** Must be assigned to a business/data owner. Not an IT task.

---

## Related Artefacts

- D08: `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` — source SQL (READ-ONLY)
- D09: `ISO20022_Swift_BIC Master Data Validation_SQL V1.xlsx` — Excel version
- D10: `Swift_BIC Master Data Validation_GC_V0.1 Working.xlsx` — validation results workbook
- D11: `Bank Accounts BIC-SWIFT codes check.csv` — BIC check output
- D12–D16: Master data extracts (CBANAC, CIDADR, CIDMAS, FPLBAL, FPLEDG)
