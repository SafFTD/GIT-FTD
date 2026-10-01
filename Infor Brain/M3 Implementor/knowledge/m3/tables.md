# M3 CE — Database Tables Reference

> **Classification:** Entries in this file must be individually classified.
> **Source policy:** Only add tables and fields that are confirmed from official Infor M3
> documentation, Infor M3 table reference, or from direct evidence in implementation work.
> Always cite the source (document, SQL, implementation observation).
>
> **Do NOT add project-specific filter values (company codes, division codes, etc.) here.**
> Those belong in `projects/{code}/knowledge/m3-observations.md`.

---

## How to read this file

Each table entry has:
- **Table name** — M3 table identifier
- **Description** — what the table stores
- **Key fields** — most important fields with M3 field code and description
- **Classification** — M3-GENERAL (confirmed standard table) or UNKNOWN
- **Evidence source** — where this was confirmed

---

## Finance

### FPLEDG — AP Sub-ledger (Accounts Payable Ledger)

**Description:** Stores individual AP transactions (invoices, payments, adjustments) per company and division.

**Classification:** M3-GENERAL (observed in HSBC project SQL — table name confirms standard M3 Finance table)

**Evidence:** `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` — HSBC project (observed, not from official Infor documentation)

**Key fields observed:**

| Field | Description | Notes |
|---|---|---|
| CONO | Company number | Standard M3 field |
| DIVI | Division | Standard M3 field |
| SPYN | Supplier number (payee) | AP-specific |
| YEA4 | Fiscal year (4-digit) | |
| ACDT | Accounting date | |

**Usage in integrations:** Used to identify which suppliers have had AP activity within a scope period (e.g. last 3 years) for payment integration master data validation.

---

### FPLBAL — AP Balance

**Description:** Stores AP balance information.

**Classification:** M3-GENERAL (observed in HSBC project — standard Finance table)

**Evidence:** Data Validation template directory listing — HSBC project

**Key fields:** Not fully documented from available evidence. Add as confirmed.

---

## Supplier / Customer Master

### CIDMAS — Supplier/Customer Master

**Description:** Core supplier and customer master record.

**Classification:** M3-GENERAL (confirmed standard M3 master data table)

**Evidence:** Data Validation template directory listing — HSBC project

**Key fields:** Not fully documented from available evidence. Add as confirmed.

---

### CIDADR — Customer/Supplier Address

**Description:** Stores postal and bank addresses for suppliers and customers. Multiple address records per entity, differentiated by address type (ADTE).

**Classification:** M3-GENERAL

**Evidence:** `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` — HSBC project

**Key fields observed:**

| Field | Description | Values/Notes |
|---|---|---|
| CONO | Company number | |
| SUNO | Supplier number | |
| ADTE | Address type | 1 = Postal Address, 10 = Bank Address (observed in HSBC SQL) |
| ADID | Address ID | Identifier for multiple addresses of same type |
| SUNM | Supplier name | |
| ADR1 | Address line 1 | |
| ADR2 | Address line 2 | |
| ADR3 | Address line 3 | |
| ADR4 | Address line 4 | |
| PONO | Postal code | |
| TOWN | Town/City | **Required for ISO 20022 payments** (project observation) |
| ECAR | State/Region | |
| CSCD | Country code | **Required for ISO 20022 payments** (project observation); ISO 3166-1 alpha-2 |
| STDT | Start date | Used for ordering multiple addresses |

**Address type priority (observed):** When multiple addresses exist, type 10 (Bank Address) takes priority over type 1 (Postal Address) for payment integration purposes.

> [!NOTE]
> TOWN and CSCD mandatory requirement for ISO 20022: Observed in HSBC project SQL and ISO20022_address_requirements PDF (not read — pending). Classification: REGULATORY / BANK-SPECIFIC — requires verification against ISO 20022 standard documentation.

---

### CBANAC — Supplier Bank Account Master

**Description:** Stores bank account details for suppliers (and potentially customers). Each record represents one bank account for one supplier entity.

**Classification:** M3-GENERAL

**Evidence:** `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` — HSBC project

**Key fields observed:**

| Field | Description | Values/Notes |
|---|---|---|
| CONO | Company number | |
| DIVI | Division | |
| ACHO | Account holder (supplier number) | |
| BKID | Bank account ID | Identifier for multiple bank accounts per supplier |
| BKTP | Bank account type code | |
| BKIN | Bank account indicator | `INTG` = integration-enabled (observed) |
| BKNO | Bank number | |
| BANA | Bank account name | |
| BACN | Bank account number | |
| IBAN | IBAN | International Bank Account Number |
| CUCD | Account currency | ISO 4217 currency code |
| STAT | Status | `20` = active/approved (observed in HSBC SQL) |
| BAF4 | BIC/SWIFT code (field 4) | Used for SWIFT/BIC in payment integration |
| SWBI | SWIFT/BIC (alternate field) | |

**Bank account indicator (BKIN):**
- `INTG` = Bank account is enabled for integration (observed in HSBC SQL filter)
- Other values exist but are not documented from available evidence

**Status (STAT):**
- `20` = Active/approved (observed in HSBC SQL filter `STAT = '20'`)
- Other status codes exist but are not documented from available evidence

> [!WARNING]
> The classification of BKIN values and STAT values as M3-GENERAL is based on single-project observation. Verify against official Infor M3 documentation before treating as universal.

**BIC/SWIFT field selection (observed):**
In the HSBC project SQL, `BAF4` is used as the primary BIC field (with `SWBI` as an additional reference). Whether `BAF4` is the universal M3 standard field for BIC is UNKNOWN — this may be project/configuration-specific. Classification: UNKNOWN — requires verification.

---

## Adding new table entries

When a new M3 table is observed in project work:

1. Add it here with classification `UNKNOWN` initially.
2. Record the evidence source (project, document, SQL).
3. Document only the fields that were observed and their apparent purpose.
4. Do not infer field names or values that were not directly observed.
5. Promote to `M3-GENERAL` only when confirmed from official Infor documentation or from multiple independent implementations.
