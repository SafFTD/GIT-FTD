# Integration Patterns

> **Classification:** INTEGRATION-GENERAL (unless marked otherwise)
> **Source policy:** Entries must be verified across implementations or from official
> Infor documentation before being classified as INTEGRATION-GENERAL.
> Project-specific implementation details belong in `projects/{code}/integrations/`.

---

## Outbound Integration Pattern (M3 → External System)

### Pattern: Outbound Payment File

**Description:** M3 generates a payment file based on a payment proposal, which is transmitted to a bank or financial institution.

**Classification:** INTEGRATION-GENERAL

**Standard flow:**

```
[Business Trigger]
    Approved payment proposal in M3
        ↓
[M3 Data Extraction]
    Payment transaction data from M3 AP sub-ledger
    Supplier master data (CIDMAS, CIDADR, CBANAC)
        ↓
[File/Message Generation]
    Tool: MEC or IPA (confirmed mechanism UNKNOWN — project-specific)
    Format: Determined by bank/regulatory requirement (ISO 20022, SWIFT MT, domestic formats)
        ↓
[Delivery]
    Protocol: SFTP (most common for H2H bank integration)
    Timing: Scheduled (e.g. daily batch) or event-driven on proposal approval
        ↓
[Acknowledgement]
    Bank ACK file received via SFTP (format varies by bank)
        ↓
[Reconciliation]
    M3 payment status updated based on bank confirmation
```

**Master data dependencies (critical):**
- `CBANAC.BAF4` or `CBANAC.SWBI` — supplier BIC/SWIFT code
- `CIDADR.TOWN` + `CIDADR.CSCD` — supplier address (Town and Country)
- `CBANAC.BACN` or `CBANAC.IBAN` — supplier bank account number
- `CBANAC.BKIN = 'INTG'` — bank account enabled for integration
- `CBANAC.STAT = '20'` — bank account active

**Data validation required before go-live:**
Run validation queries against master data to identify:
1. Missing or invalid BIC/SWIFT codes
2. Missing Town/City on supplier addresses
3. Missing Country on supplier addresses
4. Inactive or non-integration bank accounts

---

### Pattern: Outbound Document / EDI

**Description:** M3 generates a business document (purchase order, advance ship notice, invoice) transmitted to a supplier or customer.

**Classification:** INTEGRATION-GENERAL

**Standard flow:**

```
[M3 Business Event]
    Document created/approved in M3
        ↓
[ION Document Flow]
    ION BOD (Business Object Document) generated
        ↓
[External System]
    Trading partner receives via ION, EDI, or transformed file
```

*Details to be added from confirmed implementation evidence.*

---

## Inbound Integration Pattern (External System → M3)

### Pattern: Inbound Bank Acknowledgement

**Description:** Bank sends an acknowledgement file (payment status report) after processing the outbound payment file.

**Classification:** INTEGRATION-GENERAL

**Standard flow:**

```
[Bank]
    Generates payment status report (e.g. ISO 20022 pain.002)
    Delivers via SFTP to customer's SFTP folder
        ↓
[File Pickup]
    Scheduled SFTP poll or push notification
        ↓
[Validation]
    Message format validation
    Reference matching (end-to-end ID matching to outbound payment)
        ↓
[M3 Update]
    Payment status updated in M3 (program/API UNKNOWN — project-specific)
        ↓
[Reconciliation]
    Matched payments marked as confirmed / rejected in M3
        ↓
[Error Handling]
    Rejected payments: alert, re-submission workflow
```

---

### Pattern: Inbound Invoice (Supplier Invoice)

**Description:** Supplier sends an electronic invoice that is loaded into M3 AP.

**Classification:** INTEGRATION-GENERAL

*Details to be added from confirmed implementation evidence.*

---

## Integration Technology Selection Guide

| Requirement | Recommended Technology | Notes |
|---|---|---|
| File-based, scheduled, format transformation | **MEC** (M3 Enterprise Collaborator) | Standard for file-based bank integrations |
| Event-driven, real-time, BOD-based | **ION** | Standard for ERP-to-ERP and business event flows |
| Workflow automation, multi-step orchestration | **IPA** | Process automation, can call MEC and ION |
| Document management, output management | **IDM** | Invoice PDFs, document archiving |
| Real-time API, mobile, custom application | **ION API + MI Programs** | REST/OAuth2 access to M3 |
| Complex ETL, external middleware | **Middleware** | When M3-native tools are insufficient |

> [!NOTE]
> Technology selection for specific M3 payment file generation is UNKNOWN — not confirmed from the available evidence in the HSBC project. The functional specification should contain the definitive answer.

---

## Integration Anti-patterns

See `knowledge/integrations/anti-patterns.md` for the full list.

**Key anti-patterns (summary):**
- Assuming master data is populated without validation
- Skipping acknowledgement and reconciliation design
- Treating bank-specific format requirements as universal ISO 20022 requirements
- Designing error handling only for happy-path scenarios
- Not defining monitoring before go-live

---

## SFTP Pattern

### Standard SFTP integration structure

```
[Outbound]
Customer SFTP directory (outbound/pending/)
    → File placed by M3/MEC
    → Bank SFTP server picks up
    → File moved to outbound/processed/

[Inbound]
Bank SFTP server (inbound/)
    → File placed by bank
    → Customer system (MEC/IPA) polls and picks up
    → File moved to inbound/processed/
```

**Filename convention:** Typically agreed between customer and bank. In the HSBC project, the observed pattern is: `XMLV3{TYPE}-{SEQ}-{BANK_ACCOUNT}-{CCY}-{PAYMENT_NO} {BATCH}_{TIMESTAMP}.xml` — this is PROJECT-SPECIFIC.

**Classification of SFTP pattern:** INTEGRATION-GENERAL
**Classification of filename convention:** PROJECT-SPECIFIC (HSBC)
