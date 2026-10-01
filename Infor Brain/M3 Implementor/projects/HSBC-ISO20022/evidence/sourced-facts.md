# HSBC Project — Sourced Facts (Evidence Chain)

> **Purpose:** Every significant implementation fact recorded with explicit attribution.
> **Classification:** PROJECT-SPECIFIC
> **Source of sources:** Repository audit conducted 2026-09-30

---

## How to read this file

Each entry follows the SOURCE → OBSERVATION → INFERENCE → RECOMMENDATION chain.
The type labels are:

| Type | Meaning |
|---|---|
| `SOURCE` | Directly stated in a named document |
| `OBSERVATION` | What was observed/measured from evidence |
| `INFERENCE` | What follows logically from observations |
| `RECOMMENDATION` | What M3 Implementor suggests |
| `DECISION` | What the project team has agreed |

---

## FACT-001: Payment file format is ISO 20022 pain.001.001.03

**SOURCE:** Sample XML files (D19–D24)
`xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"` appears in all 6 sample files.

**OBSERVATION:** All outbound payment files use the Customer Credit Transfer Initiation message (pain.001.001.03).

**INFERENCE:** The HSBC bank H2H channel requires ISO 20022 pain.001.001.03 format for payment instructions from Gold Coin.

**CLASSIFICATION:** Integration format: INTEGRATION-GENERAL; HSBC requirement: BANK-SPECIFIC

---

## FACT-002: Gold Coin group organisation identifier is ABCA0946001

**SOURCE:** D19–D24 — `InitgPty/OrgId/Othr/Id` = `ABCA0946001` present in all 6 XML samples.

**OBSERVATION:** The same organisation ID (ABCA0946001) is used across all Gold Coin legal entities and all countries (MY, VN, SG).

**INFERENCE:** ABCA0946001 is the Gold Coin group-level identifier used to identify the initiating party in all HSBC payment files, regardless of which legal entity is paying.

**CLASSIFICATION:** CUSTOMER-SPECIFIC

---

## FACT-003: BIC validation requires 8 or 11 character uppercase BIC without spaces

**SOURCE:** D08 — `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` (BIC validation logic)

**OBSERVATION:** The SQL explicitly checks length (must be 8 or 11), case (must be uppercase), spaces (must have none), character positions (A–Z in positions 1–6, A–Z or 0–9 in 7–11).

**INFERENCE:** These are the minimum BIC format requirements for this integration.

**CLASSIFICATION:** INTEGRATION-GENERAL (ISO 9362 format rules); PROJECT-SPECIFIC (specific implementation in this SQL)

**RECOMMENDATION:** Apply the same BIC validation to all future payment integrations requiring BIC/SWIFT codes.

---

## FACT-004: Supplier Town and Country are required for payment file generation

**SOURCE:** D08 — `ISO20022_Swift_BIC Master Data Validation_SQL V1.sql` — Address validation section flags missing TOWN and CSCD as INVALID.

**OBSERVATION:** The validation SQL marks records as REVIEW (overall) whenever TOWN is null/empty or CSCD is null/empty.

**OBSERVATION (XML):** D21 (VN file, Dbtr) and D22 (SG file, Dbtr) show `<TwnNm/>` (empty town) — confirming this data gap exists in production data.

**INFERENCE:** The ISO 20022 pain.001.001.03 message requires Town and Country to be populated in postal addresses. Payments cannot be generated cleanly for suppliers with missing address data.

**CLASSIFICATION of Town/Country requirement:** REGULATORY (likely ISO 20022 standard) — pending confirmation from D05 (ISO20022_address_requirements.pdf)

**RECOMMENDATION:** D05 must be read to confirm whether Town + Country are ISO 20022 mandated (REGULATORY) or HSBC-specific (BANK-SPECIFIC).

---

## FACT-005: M3 Company 100, Division 001 is the implementation scope

**SOURCE:** D08 SQL — `WHERE CONO = 100 AND DIVI IN ('001')`

**OBSERVATION:** All validation SQL queries are scoped to Company 100, Division 001.

**INFERENCE:** The HSBC payment integration is configured for Company 100, Division 001 in M3.

**CLASSIFICATION:** PROJECT-SPECIFIC (Gold Coin M3 company/division configuration)

---

## FACT-006: Bank accounts must have BKIN = 'INTG' to be included in integration

**SOURCE:** D08 SQL — `WHERE BKIN = 'INTG'`

**OBSERVATION:** The integration only includes bank accounts with the indicator value 'INTG'.

**INFERENCE:** M3 CBANAC uses the BKIN field to flag which bank accounts are enabled for integration processing. Accounts without BKIN = 'INTG' are excluded from the payment file.

**CLASSIFICATION:** M3-GENERAL (BKIN field and indicator concept appear to be standard M3); UNKNOWN (whether 'INTG' is the universal value for all M3 integrations or project-specific — requires verification)

---

## FACT-007: Bank account status STAT = '20' means active/approved

**SOURCE:** D08 SQL — `WHERE STAT = '20'`

**OBSERVATION:** The integration filters to bank accounts with STAT = '20'.

**INFERENCE:** Status 20 represents an active, approved bank account in M3 CBANAC.

**CLASSIFICATION:** UNKNOWN — whether '20' is the universal M3 active status for CBANAC or project-specific requires verification against M3 documentation.

---

## FACT-008: Authorisation code ILEV is used in all payment files

**SOURCE:** D19–D24 — `Authstn/Cd = ILEV` in all 6 sample files.

**OBSERVATION:** Every payment file in the sample set contains `<Authstn><Cd>ILEV</Cd></Authstn>` in the Group Header.

**INFERENCE:** ILEV is the required authorisation code for HSBC H2H payment files in this project.

**CLASSIFICATION:** BANK-SPECIFIC (HSBC requirement) or CUSTOMER-SPECIFIC (Gold Coin approval level) — requires confirmation from D01 or D02.

---

## FACT-009: Branch code 'XXX' is rejected as dummy/invalid

**SOURCE:** D08 SQL — `WHEN LENGTH(B.bic_clean) = 11 AND SUBSTR(B.bic_clean, 9, 3) = 'XXX' THEN 'INVALID - Dummy Branch Code (XXX)'`

**OBSERVATION:** The validation SQL explicitly rejects 11-character BICs with 'XXX' as branch code.

**INFERENCE:** HSBC or the project team determined that BICs with 'XXX' branch code indicate incomplete or placeholder data.

**CLASSIFICATION:** PROJECT-SPECIFIC / BANK-SPECIFIC — whether XXX is universally rejected or is a project decision requires verification.

**DECISION status:** UNKNOWN — no decision record found confirming this choice. Should be recorded in decisions.md.

---

## FACT-010: DataPulse tool is used for ION API access in TST environment

**SOURCE:** D17 — `GC_TST_DataPulse.ionapi` exists in DataPulse directory.

**OBSERVATION:** A DataPulse ION API credential file exists for the LCCGLNLPSVGTXCNE TST tenant.

**INFERENCE:** DataPulse is used by the implementation team to query M3 data via ION API during the HSBC project implementation (specifically for TST environment).

**CLASSIFICATION:** M3-GENERAL (DataPulse tool); PROJECT-SPECIFIC (this specific ionapi credential and tenant)

---

## FACT-011: Change request GC-CR-26-021 modifies the payment file setup

**SOURCE:** Document filename `GC-CR-26-021_Modification on Integration Payment File M3 XML file setup to HSBC.pdf`

**OBSERVATION:** A change request document exists that specifically modifies the payment file integration.

**INFERENCE:** The original integration (GC-CR-26-014) was subsequently modified. The current state of the integration reflects both the original design and the GC-CR-26-021 changes.

**CLASSIFICATION:** PROJECT-SPECIFIC

**RECOMMENDATION:** Read GC-CR-26-021 to understand what changed and ensure the integration descriptor reflects the current state.

**DECISION status:** UNKNOWN — current implementation reflects GC-CR-26-021 or not is unconfirmed from audit evidence.

---

## FACT-012: Indonesia uses BI FAST payment format

**SOURCE:** Document filename `PP & ACH BI FAST XML V3-File Spec, Sample & Regulatory Reporting for Indonesia - Last Update 20260204.docx`

**OBSERVATION:** A vendor specification document for Indonesia BI FAST exists in the project.

**INFERENCE:** Indonesia payments in this project require compliance with the BI FAST payment scheme, which is a local Indonesian payment system in addition to (or instead of) ISO 20022.

**CLASSIFICATION:** REGULATORY (Bank Indonesia requirement) / BANK-SPECIFIC

**RECOMMENDATION:** Read the BI FAST specification document to understand Indonesia-specific format requirements before implementing or changing Indonesia payments.

---

## FACT-013: Vietnam uses DynamicCSV format variant

**SOURCE:** Document filename `vn_ffs_DynamicCSV_PP (1).pdf`

**OBSERVATION:** A Vietnam-specific format specification document exists.

**INFERENCE:** Vietnam payments in this project may use a DynamicCSV format variant in addition to or instead of the standard ISO 20022 XML.

**CLASSIFICATION:** BANK-SPECIFIC / REGULATORY (Vietnam banking authority requirement)

**RECOMMENDATION:** Read the Vietnam format spec before implementing or modifying Vietnam payments.
