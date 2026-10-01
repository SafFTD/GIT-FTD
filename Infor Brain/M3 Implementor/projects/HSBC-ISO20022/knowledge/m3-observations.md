# HSBC Project — M3 Observations

> **Classification:** PROJECT-SPECIFIC (unless individually promoted to M3-GENERAL)
> **Source:** Repository audit 2026-09-30. Primary source = D08 (SQL), D19–D24 (XML), D17 (ionapi).
> **Do NOT promote to knowledge/m3/ without verification across multiple projects.**

---

## M3 Tables Observed

All tables below observed from D08 (`ISO20022_Swift_BIC Master Data Validation_SQL V1.sql`).

### FPLEDG (AP Sub-ledger)

**Observed use:** Identifies suppliers with AP transaction history to determine which suppliers are in scope for payment integration master data validation.

**Filter applied in this project:**
```sql
WHERE CONO = 100        -- Company 100 (PROJECT-SPECIFIC)
  AND DIVI IN ('001')   -- Division 001 (PROJECT-SPECIFIC)
  AND YEA4 >= 2023      -- Last 3 years (PROJECT-SPECIFIC scope decision)
  AND SPYN IS NOT NULL
  AND TRIM(SPYN) <> ''
```

**Fields observed:**

| Field | Description | Classification |
|---|---|---|
| CONO | Company number | M3-GENERAL (standard field) |
| DIVI | Division | M3-GENERAL (standard field) |
| SPYN | Supplier number (payee) | M3-GENERAL (AP-specific) |
| YEA4 | Fiscal year (4-digit) | M3-GENERAL |
| ACDT | Accounting date | M3-GENERAL |

---

### CBANAC (Supplier Bank Account Master)

**Observed use:** Source of BIC/SWIFT code, bank account number, and account status for payment file generation and validation.

**Filter applied in this project:**
```sql
WHERE CONO = 100        -- Company 100 (PROJECT-SPECIFIC)
  AND BKIN = 'INTG'     -- Integration-enabled bank accounts only
  AND STAT = '20'       -- Active/approved status only
```

**Fields observed:**

| Field | Description | Classification |
|---|---|---|
| CONO | Company number | M3-GENERAL |
| DIVI | Division | M3-GENERAL |
| ACHO | Account holder (supplier number) | M3-GENERAL |
| BKID | Bank account ID | M3-GENERAL |
| BKTP | Bank account type code | M3-GENERAL |
| BKIN | Bank account indicator (`INTG` = integration) | M3-GENERAL (indicator exists) / UNKNOWN (all valid values) |
| BKNO | Bank number | M3-GENERAL |
| BANA | Bank account name | M3-GENERAL |
| BACN | Bank account number | M3-GENERAL |
| IBAN | IBAN | M3-GENERAL |
| CUCD | Account currency | M3-GENERAL |
| STAT | Status (`20` = active) | M3-GENERAL (status field exists) / UNKNOWN (all valid values) |
| BAF4 | BIC/SWIFT code (primary field used in this project) | M3-GENERAL (field exists) / PROJECT-SPECIFIC (BAF4 as primary BIC field — verify if universal) |
| SWBI | SWIFT/BIC (alternate field) | M3-GENERAL (field exists) |

---

### CIDADR (Customer/Supplier Address)

**Observed use:** Source of supplier postal address for payment file generation. Both debtor and creditor postal addresses in the XML file.

**Filter applied in this project:**
```sql
WHERE CONO = 100
  AND CAST(ADTE AS INTEGER) IN (1, 10)  -- Postal (1) and Bank (10) address types
```

**Address type priority (observed):** Type 10 (Bank Address) > Type 1 (Postal Address). When multiple addresses exist, type 10 is preferred.

**Fields observed:**

| Field | Description | Classification |
|---|---|---|
| CONO | Company number | M3-GENERAL |
| SUNO | Supplier number | M3-GENERAL |
| ADTE | Address type (1=Postal, 10=Bank) | M3-GENERAL (field exists) / UNKNOWN (all type values) |
| ADID | Address ID | M3-GENERAL |
| SUNM | Supplier name | M3-GENERAL |
| ADR1 | Address line 1 | M3-GENERAL |
| ADR2 | Address line 2 | M3-GENERAL |
| ADR3 | Address line 3 | M3-GENERAL |
| ADR4 | Address line 4 | M3-GENERAL |
| PONO | Postal code | M3-GENERAL |
| TOWN | Town/City | M3-GENERAL — **required for ISO 20022** (validation classifies missing TOWN as INVALID) |
| ECAR | State/Region | M3-GENERAL |
| CSCD | Country code (ISO 3166-1 alpha-2) | M3-GENERAL — **required for ISO 20022** (validation classifies missing CSCD as INVALID) |
| STDT | Start date (used for record ordering) | M3-GENERAL |

---

## ION Environment Observed

**Source:** D17 (`GC_TST_DataPulse.ionapi`)

| Attribute | Value | Classification |
|---|---|---|
| Tenant ID | LCCGLNLPSVGTXCNE_TST | PROJECT-SPECIFIC |
| ION API URL | https://mingle-ionapi.se2.inforcloudsuite.com | PROJECT-SPECIFIC (SE2 data centre) |
| SSO URL | https://mingle-sso.se2.inforcloudsuite.com/LCCGLNLPSVGTXCNE_TST/as/ | PROJECT-SPECIFIC |
| Data centre | SE2 | PROJECT-SPECIFIC |
| Tool | DataPulse | M3-GENERAL (standard Infor tool) |

> [!CAUTION]
> The `.ionapi` file also contains OAuth2 credentials (client ID, client secret, service account access key and secret key). These credentials are NOT recorded here. The `.ionapi` file must remain in its source location and must never be distributed, committed to version control, or shared.

---

## XML Structure Observations

**Source:** D19–D24 (6 sample payment XML files read during audit)

Confirmed XML elements and their values — see `knowledge/integrations/iso20022.md` for the classified standard vs project-specific breakdown.

**Key project-specific XML observations:**
- Authorisation code `ILEV` present in all files
- Payment type embedded in MsgId (DTN, HVP, LVP, FTR, FST)
- Bank account reference embedded in MsgId (HSBC1, HSBC2, HSBC3, HSBC5)
- Organisation ID `ABCA0946001` used as Gold Coin group identifier
- Scheme name `PSET` used for Debtor organisation identification
- `ClrSysMmbId` (Clearing System Member ID) present in creditor agent for some payment types

**Address patterns observed:**
- Debtor (Gold Coin entity): structured address with StrtNm, BldgNb, PstCd, TwnNm, CtrySubDvsn, Ctry
- Creditor (supplier): structured address with StrtNm, PstCd, TwnNm, Ctry
- Some files have empty TwnNm (`<TwnNm/>`) — these correspond to suppliers with missing TOWN data (known data quality issue)
