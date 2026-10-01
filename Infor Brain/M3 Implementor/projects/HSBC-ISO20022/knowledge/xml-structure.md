# HSBC Project — XML Structure

> **Classification:** PROJECT-SPECIFIC (HSBC implementation structure)
> Some elements are INTEGRATION-GENERAL (ISO 20022 standard) — classified per element.
> **Source:** D19–D24 (6 sample payment XML files read during audit 2026-09-30)
> **Primary source not yet read:** D01 (Functional Specification)

---

## Message Type

All payment files use:
```
xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
```
**Classification:** INTEGRATION-GENERAL (ISO 20022 standard namespace)

---

## Group Header (GrpHdr) — Key Elements

| Element | Description | Example value | Classification |
|---|---|---|---|
| `MsgId` | Unique message ID | `XMLV3LVP-002-HSBC2-MYR-8000001338 1` | PROJECT-SPECIFIC (naming convention) |
| `CreDtTm` | ISO 8601 datetime | `2026-09-30T15:05:06` | INTEGRATION-GENERAL |
| `Authstn/Cd` | Authorisation code | `ILEV` | BANK-SPECIFIC / PROJECT-SPECIFIC |
| `NbOfTxs` | Transaction count | `1` | INTEGRATION-GENERAL |
| `CtrlSum` | Control sum | `1500.0` | INTEGRATION-GENERAL |
| `InitgPty/Nm` | Initiating party name | `GOLD COIN FEEDMILLS (M) SDN BHD - BW` | CUSTOMER-SPECIFIC |
| `InitgPty/Id/OrgId/Othr/Id` | Organisation identifier | `ABCA0946001` | CUSTOMER-SPECIFIC |

**Note:** `InitgPty/Nm` is present in some files and absent (no Nm element) in others. The VN file does not include a company name in InitgPty — only the OrgId. Consistency of this pattern requires confirmation from D01.

---

## Payment Information (PmtInf) — Key Elements

| Element | Description | Example value | Classification |
|---|---|---|---|
| `PmtInfId` | Payment info ID | `00280000013381` | PROJECT-SPECIFIC (M3 reference) |
| `PmtMtd` | Payment method | `TRF` | INTEGRATION-GENERAL (ISO standard) |
| `BtchBookg` | Batch booking | `false` (observed in USD file only) | INTEGRATION-GENERAL (optional flag) |
| `PmtTpInf/SvcLvl/Cd` | Service level | `NURG` / `URGP` / `URNS` | BANK-SPECIFIC (country/payment-type specific) |
| `PmtTpInf/InstrPrty` | Priority | `NORM` (observed in USD file) | BANK-SPECIFIC |
| `ReqdExctnDt` | Requested execution date | `2026-09-30` | INTEGRATION-GENERAL |
| `Dbtr/Nm` | Debtor name | `GOLD COIN FEEDMILLS (M) SDN BHD - BW` | CUSTOMER-SPECIFIC |
| `Dbtr/PstlAdr` | Debtor postal address | See address elements | PROJECT-SPECIFIC |
| `Dbtr/Id/OrgId/Othr/Id` | Debtor org ID | `C07` (company division code) | PROJECT-SPECIFIC |
| `Dbtr/Id/OrgId/Othr/SchmeNm/Prtry` | Scheme name | `PSET` | PROJECT-SPECIFIC / BANK-SPECIFIC |
| `DbtrAcct/Id/Othr/Id` | Debtor account number | `373203439002` | CUSTOMER-SPECIFIC |
| `DbtrAgt/FinInstnId/BIC` | HSBC BIC (debtor bank) | `HBMBMYKL` | BANK-SPECIFIC |
| `DbtrAgt/FinInstnId/PstlAdr/Ctry` | Debtor bank country | `MY` | BANK-SPECIFIC |
| `ChrgBr` | Charge bearer | `DEBT` / `SHAR` | BANK-SPECIFIC (varies by payment type) |

---

## Credit Transfer Transaction (CdtTrfTxInf) — Key Elements

| Element | Description | Example | Classification |
|---|---|---|---|
| `PmtId/InstrId` | Instruction ID | `00280133811` | PROJECT-SPECIFIC |
| `PmtId/EndToEndId` | End-to-end reference | `00280133811` | INTEGRATION-GENERAL (unique reference concept) |
| `Amt/InstdAmt Ccy="{CCY}"` | Amount with currency | `1500.00` with `Ccy="MYR"` | INTEGRATION-GENERAL |
| `CdtrAgt/FinInstnId/BIC` | Creditor bank BIC | `CIBBMYKL` | PROJECT-SPECIFIC (supplier's bank) |
| `CdtrAgt/FinInstnId/ClrSysMmbId/MmbId` | Clearing member ID | `35` | BANK-SPECIFIC / REGULATORY |
| `CdtrAgt/FinInstnId/Nm` | Creditor bank name | `AJENSI VIJI` | PROJECT-SPECIFIC |
| `CdtrAgt/FinInstnId/PstlAdr` | Creditor bank address | See address elements | PROJECT-SPECIFIC |
| `Cdtr/Nm` | Creditor (supplier) name | `AJENSI VIJI` | PROJECT-SPECIFIC |
| `Cdtr/PstlAdr` | Supplier postal address | See address elements | PROJECT-SPECIFIC |
| `CdtrAcct/Id/Othr/Id` | Creditor account number | `8003788830` | PROJECT-SPECIFIC |
| `Purp/Cd` | Purpose code | `OTHR` (observed in SG/USD file) | BANK-SPECIFIC / REGULATORY |
| `RmtInf/Ustrd` | Remittance info | `IV 20554` or `INVOICE PAYMENT / 852,` | PROJECT-SPECIFIC (format varies) |

---

## Address Elements Observed

Both debtor and creditor addresses use structured (not unstructured) address in all files.

| XML Element | Meaning | Observed patterns |
|---|---|---|
| `StrtNm` | Street name | Full address line or partial |
| `BldgNb` | Building number | Used when address has separate building number |
| `PstCd` | Postal code | Sometimes empty (`<PstCd/>`) |
| `TwnNm` | Town/City | **Required** — empty tags observed (data quality issue) |
| `CtrySubDvsn` | State/Province | Used in MY (e.g. `PG` = Penang) |
| `Ctry` | Country code | ISO 3166-1 alpha-2 (MY, VN, SG) |

---

## Remittance Information (RmtInf/Ustrd) Patterns Observed

| Pattern | Example | Classification |
|---|---|---|
| Invoice number | `IV 20554` | PROJECT-SPECIFIC |
| Invoice payment with reference | `INVOICE PAYMENT / 852,` | PROJECT-SPECIFIC |
| Lease reference | `LEASE_PL_2024-2026` | PROJECT-SPECIFIC |

**Observation:** The Ustrd field format varies by payment type or entity. No standard format is enforced across all files observed. The formal Ustrd format rules should be documented in D01.

---

## Variation by Country

| Country | Notable variation |
|---|---|
| MY | `CtrySubDvsn` (state code) present; both DEBT and SHAR ChrgBr observed |
| VN | No `InitgPty/Nm`; `ChrgBr = SHAR`; `SvcLvl = URGP`; VND large amounts |
| SG | `BtchBookg = false`; `InstrPrty = NORM`; `SvcLvl = URNS`; `Purp/Cd = OTHR` |
| ID | XML samples in XML Files\ID not read — variation unknown |
