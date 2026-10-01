# MEC — M3 Enterprise Collaborator

> **Classification:** M3-GENERAL (MEC is a standard Infor M3 component)
> **Source policy:** Add verified MEC capabilities. This file is sparse pending
> functional specification review for the HSBC project.

---

## Overview

**M3 Enterprise Collaborator (MEC)** is Infor's file-based integration middleware for M3. It specialises in:

- Extracting data from M3 in scheduled or event-triggered batches
- Transforming data into external formats (bank files, EDI, flat files, XML)
- Delivering files via SFTP, FTP, email, or other transports
- Receiving inbound files and loading data into M3

**Classification:** M3-GENERAL

---

## Primary Use Cases

| Use case | Typical MEC role |
|---|---|
| Bank payment file generation (outbound) | Extract AP payment data → transform to bank format (ISO 20022, MT, domestic) → deliver via SFTP |
| Bank statement import (inbound) | Receive bank statement file → transform → load into M3 bank reconciliation |
| EDI supplier orders | Extract M3 purchase order → transform to EDI → deliver to supplier |
| Invoice output | Generate formatted invoice output → IDM storage or email delivery |

**Note:** Whether MEC is the tool used for the HSBC payment file generation is UNKNOWN — not confirmed from available evidence. The functional specification should confirm this.

---

## MEC Architecture (General Understanding)

```
M3 Business Engine
    ↓ Data extraction (MI program call or M3 data export)
MEC Engine
    ├── Mapper / Transformer
    │   └── Maps M3 fields → target format fields
    ├── Template
    │   └── Defines output file structure (XML, CSV, fixed-width, etc.)
    └── Transport
        └── SFTP / FTP / file system / email
```

**Classification:** M3-GENERAL (architecture concept) / UNKNOWN (specific MEC components in HSBC — not confirmed)

---

## File-Based Integration Pattern

When MEC is used for a file-based integration:

1. **Trigger:** Scheduled job or M3 event triggers MEC extraction.
2. **Extraction:** MEC calls M3 MI programs or uses M3 data extraction to get payment/transaction data.
3. **Transformation:** MEC mapper transforms M3 field values to target format (e.g. CBANAC.BAF4 → XML BIC element).
4. **File generation:** MEC produces the output file (e.g. ISO 20022 XML).
5. **Delivery:** MEC places the file on SFTP server.

**Classification of this pattern:** INTEGRATION-GENERAL

---

## MEC Configuration

*MEC configuration details (specific programs, mappers, templates) for the HSBC project are UNKNOWN from available evidence.*

**Source needed:** `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx`

---

## Open Questions

- Q1 (TECHNICAL): Is MEC the primary tool for the HSBC outbound payment file generation?
- Q2 (TECHNICAL): Which MEC programs/mappers are used in this integration?
- Q3 (TECHNICAL): Does MEC handle the inbound bank acknowledgement, or is that a separate tool?

**Source needed:** `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx`
