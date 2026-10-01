# HSBC H2H ISO 20022 — Outbound Payment Integration

> **Integration ID:** HSBC-OUTBOUND-PAYMENT-001
> **Classification:** PROJECT-SPECIFIC
> **Last updated from evidence:** 2026-09-30 (repository audit)
> **Source documents read:** D08 (SQL), D19–D24 (XML sample files), D17 (ionapi)
> **Primary source NOT yet read:** D01 (Functional Specification)

---

## Integration Summary

| Attribute | Value | Classification | Source |
|---|---|---|---|
| Name | HSBC H2H Outbound Payment | PROJECT-SPECIFIC | Document titles |
| Direction | OUTBOUND (M3 → HSBC Bank) | PROJECT-SPECIFIC | XML file evidence |
| Source system | Infor M3 CE | PROJECT-SPECIFIC | Context |
| Target system | HSBC Bank (H2H channel) | PROJECT-SPECIFIC / BANK-SPECIFIC | Document titles |
| Message format | ISO 20022 pain.001.001.03 | INTEGRATION-GENERAL | XML file evidence |
| File delivery | SFTP (inferred) | PROJECT-SPECIFIC (mechanism assumed H2H standard) | Standard H2H practice |
| Countries | MY, VN, SG, ID | PROJECT-SPECIFIC | XML samples, directory structure |
| Currencies | MYR, VND, USD, IDR | PROJECT-SPECIFIC | XML samples |
| M3 module | Finance — Accounts Payable | PROJECT-SPECIFIC | SQL evidence, business context |
| M3 Company | 100 | PROJECT-SPECIFIC | D08 SQL |
| M3 Division | 001 | PROJECT-SPECIFIC | D08 SQL |

---

## Payment Types Observed (PROJECT-SPECIFIC)

| Code | Type | Country | Currency | Service Level |
|---|---|---|---|---|
| DTN | Domestic Transfer Normal | MY | MYR | — |
| HVP | High Value Payment | MY | MYR | — |
| LVP | Low Value Payment | MY | MYR | NURG |
| FTR | Foreign Transfer | VN | VND | URGP |
| FST | Foreign Swift Transfer | SG, ID | USD, IDR | URNS, URGP |

**Classification:** All payment type codes are PROJECT-SPECIFIC / BANK-SPECIFIC. Do not treat as universal M3 or ISO 20022 codes.

---

## Message ID Naming Convention (PROJECT-SPECIFIC)

**Observed pattern:** `XMLV3{TYPE}-{SEQ}-{BANK_ACCOUNT}-{CCY}-{PAYMENT_NO} {BATCH}`

| Component | Description | Example |
|---|---|---|
| XMLV3 | File format version prefix | XMLV3 |
| {TYPE} | Payment type (DTN/HVP/LVP/FTR/FST) | LVP |
| {SEQ} | Sequence number | 002 |
| {BANK_ACCOUNT} | HSBC bank account reference | HSBC2 |
| {CCY} | Currency code | MYR |
| {PAYMENT_NO} | M3 payment number | 8000001338 |
| {BATCH} | Batch number | 1 |

**Full example:** `XMLV3LVP-002-HSBC2-MYR-8000001338 1`

**Source:** D19–D24 (MsgId elements in XML sample files)
**Classification:** PROJECT-SPECIFIC (Gold Coin / HSBC naming convention)

---

## Company Identifiers (PROJECT-SPECIFIC)

| Company | Country | OrgId in XML | Evidence |
|---|---|---|---|
| Gold Coin Group (all entities) | Various | ABCA0946001 | D19–D24 — InitgPty/OrgId/Othr/Id |

**Scheme name for Debtor ID:** `PSET` (observed in D20, D21 — Dbtr/Id/OrgId/Othr/SchmeNm)

---

## HSBC Bank Identifiers (BANK-SPECIFIC)

| Bank Account Ref | BIC | Country | Evidence |
|---|---|---|---|
| HSBC1 (VN) | HSBCVNVXXXX | Vietnam | D21 — DbtrAgt/FinInstnId/BIC |
| HSBC2 (SG) | HSBCSGSG | Singapore | D22 — DbtrAgt/FinInstnId/BIC |
| HSBC2 (MY) | HBMBMYKL | Malaysia | D20 — DbtrAgt/FinInstnId/BIC |

> **Note:** BIC codes are bank-specific. Do not apply HSBC BIC codes to other banks.

---

## Authorisation Code (PROJECT-SPECIFIC / BANK-SPECIFIC)

| Element | Value | Observed in |
|---|---|---|
| Authstn/Cd | ILEV | All D19–D24 XML samples |

**Classification:** BANK-SPECIFIC — consistently observed in all HSBC files. Whether `ILEV` is required by HSBC specifically or by the ISO 20022 standard for this context is UNKNOWN pending review of D01 or D02.

---

## Data Sources (M3 Tables)

| Table | Purpose | Evidence |
|---|---|---|
| FPLEDG | AP sub-ledger — identifies which suppliers to include in scope | D08 SQL |
| CBANAC | Supplier bank account — BIC, account number, IBAN, currency | D08 SQL |
| CIDADR | Supplier address — debtor and creditor postal addresses | D08 SQL |
| CIDMAS | Supplier master | D08 SQL (referenced in directory listing) |

**Filter criteria applied in D08 SQL:**
- Company: `CONO = 100`
- Division: `DIVI IN ('001')`
- AP activity: `YEA4 >= 2023` (last 3 years)
- Bank account indicator: `BKIN = 'INTG'`
- Bank account status: `STAT = '20'`

**Classification:** All filter values are PROJECT-SPECIFIC. The table names and field names are classified as M3-GENERAL (see `knowledge/m3/tables.md`).

---

## Integration Technology (UNKNOWN — source not read)

**Status:** NOT ESTABLISHED from available evidence.

The functional specification (D01) must be read to confirm:
- Whether MEC generates the XML file
- Whether ION or IPA is involved
- What the trigger mechanism is (scheduled job, M3 event, manual trigger)
- What the SFTP server configuration is
- What the acknowledgement mechanism is

**Do not assume a technology until confirmed from D01.**

---

## Validation Rules (from D08 SQL)

See `knowledge/data-validation.md` for the full validation rule set derived from D08.

**Summary:**
- BIC: must be 8 or 11 chars, uppercase, correct character format, no spaces, no XXX branch code
- Address: Town (`TOWN`) and Country (`CSCD`) must be populated
- Combined status: PASS only when BIC is VALID and address is VALID

---

## Field Mapping (PARTIAL — from XML observation only)

> This is an OBSERVATION-level mapping derived from reading XML samples. It is NOT a formal mapping specification. The formal mapping specification is in D01 (not yet read).

| XML Element | M3 Source (inferred) | Table | Field | Classification |
|---|---|---|---|---|
| MsgId | Constructed (convention) | — | — | PROJECT-SPECIFIC |
| CreDtTm | System datetime | — | — | INTEGRATION-GENERAL |
| Authstn/Cd | ILEV (hardcoded?) | — | — | BANK-SPECIFIC |
| NbOfTxs | Count of payment lines | — | — | INTEGRATION-GENERAL |
| CtrlSum | Sum of payment amounts | — | — | INTEGRATION-GENERAL |
| InitgPty/Nm | Company name | — | — | UNKNOWN (M3 source not confirmed) |
| InitgPty/OrgId/Othr/Id | ABCA0946001 (company ID) | — | — | CUSTOMER-SPECIFIC |
| Dbtr/Nm | Paying entity name | — | — | UNKNOWN (M3 source not confirmed) |
| Dbtr/PstlAdr | Paying entity address | CIDADR | ADR1-4, TOWN, CSCD | PROJECT-SPECIFIC |
| DbtrAcct/Id/Othr/Id | Company bank account number | CBANAC | BACN | PROJECT-SPECIFIC (field confirmed from SQL) |
| DbtrAgt/FinInstnId/BIC | HSBC BIC code | CBANAC? | BAF4 | PROJECT-SPECIFIC |
| InstdAmt + Ccy | Payment amount + currency | FPLEDG? | — | UNKNOWN (M3 source not confirmed) |
| ChrgBr | Charge bearer | — | — | BANK-SPECIFIC (DEBT or SHAR — country dependent) |
| CdtrAgt/FinInstnId/BIC | Supplier bank BIC | CBANAC | BAF4 | PROJECT-SPECIFIC |
| Cdtr/Nm | Supplier name | CIDMAS | SUNM | PROJECT-SPECIFIC (inferred) |
| Cdtr/PstlAdr | Supplier address | CIDADR | ADR1-4, TOWN, CSCD, PONO | PROJECT-SPECIFIC |
| CdtrAcct/Id/Othr/Id | Supplier bank account | CBANAC | BACN | PROJECT-SPECIFIC |
| RmtInf/Ustrd | Invoice reference / payment description | — | — | UNKNOWN (format is project-specific) |

**Classification of this mapping:** OBSERVATION only. Formal mapping must be sourced from D01.

---

## Known Open Questions

See `open-questions/questions.md` for the full open question log.

**Key unknowns specific to this integration:**
- Q01: What M3 programs trigger the payment file generation?
- Q02: Is MEC, ION, or IPA used for file generation?
- Q03: What is the SFTP server and directory structure?
- Q04: How does the bank send acknowledgement?
- Q05: How does M3 process the bank acknowledgement?
- Q06: What happens when a payment is rejected by the bank?
- Q07: Is GC-CR-26-021 fully implemented or still in progress?

---

## Gap Assessment

| Gap Type | Status | Detail |
|---|---|---|
| REQUIREMENT-GAP | PRESENT | D02 (BRD) exists — not read yet |
| DESIGN-GAP | PARTIAL | D01 (FNS) exists — not read; TNS/IFS not found |
| MAPPING-GAP | PARTIAL | Observation mapping only; formal MAP not found |
| DEVELOPMENT-GAP | INFERRED PRESENT | XML samples suggest deployed |
| TEST-GAP | PARTIAL | TCS Excel exists (D18) but not read; UAT status unknown |
| DEPLOYMENT-GAP | UNKNOWN | DPL not found in directory |
| MONITORING-GAP | UNKNOWN | RNB not found in directory |
| DATA-GAP | PARTIAL | Data validation SQL exists and has been used (D08–D11) |
| ACKNOWLEDGEMENT-GAP | UNKNOWN | ACK mechanism not documented in available evidence |
| OWNERSHIP-GAP | UNKNOWN | Owners not confirmed from audit evidence |
