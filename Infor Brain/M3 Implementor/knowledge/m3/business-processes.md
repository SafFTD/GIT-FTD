# M3 CE — Business Process Map

> **Classification:** M3-GENERAL
> **Source:** This file records standard M3 CE business processes. Entries must be verified
> against official Infor M3 documentation or confirmed implementation evidence before being
> classified as M3-GENERAL. Unverified entries are marked UNKNOWN.
>
> **Do NOT add project-specific process variations here.** Project-specific observations
> belong in `projects/{code}/knowledge/`.

---

## How to use this file

When a business requirement is received, identify the relevant process area from this map.
Then assess whether the requirement is covered by the standard M3 process.

---

## Finance

### Accounts Payable (AP)

**Standard M3 processes:**
- Supplier invoice registration (manual and automated)
- Invoice matching (2-way: PO/invoice, 3-way: PO/receipt/invoice)
- Invoice approval workflow
- Payment proposal creation
- Payment execution and file generation
- Bank reconciliation
- AP sub-ledger maintenance

**Key M3 areas:** Finance → Accounts Payable → Supplier Invoices, Payment

**Integration relevance:** Payment file generation (outbound to bank) is a standard M3 capability supported via payment proposals. The file format and delivery mechanism depend on configuration and integration setup.

**Note on payment file format:**
- Standard M3 supports multiple payment formats. The specific format (e.g. ISO 20022 pain.001) is configured per payment method / bank account.
- Classification of specific format support: UNKNOWN — requires verification against M3 documentation and MEC/ION capabilities.

---

### Accounts Receivable (AR)

**Standard M3 processes:**
- Customer invoice creation
- Payment receipt allocation
- Dunning
- AR sub-ledger maintenance

---

### General Ledger (GL)

**Standard M3 processes:**
- Journal entry
- Period close
- Financial reporting
- Intercompany accounting

---

### Cash Management / Banking

**Standard M3 processes:**
- Bank account master data maintenance
- Bank statement import
- Bank reconciliation
- Payment processing
- Electronic banking

**Integration relevance:** Bank statement import (inbound from bank) and payment file generation (outbound to bank) are core integration touchpoints for this process area.

---

## Procurement

### Purchase Order Management

**Standard M3 processes:**
- Purchase requisition
- Purchase order creation and approval
- Goods receipt
- Purchase order matching

---

### Supplier Master

**Standard M3 processes:**
- Supplier creation and maintenance
- Supplier bank account maintenance (CBANAC)
- Supplier address maintenance (CIDADR)

**Data relevance for integrations:** Supplier bank account and address master data are critical inputs for outbound payment integrations. See `knowledge/m3/tables.md` for field details.

---

## Supply Chain / Inventory

**Standard M3 processes:**
- Item master maintenance
- Warehouse management
- Stock transactions (receipt, issue, transfer)
- Inventory valuation

---

## Manufacturing

**Standard M3 processes:**
- Production order management
- Material requirements planning (MRP)
- Work centre management
- Routing and BOM

---

## Sales

**Standard M3 processes:**
- Customer order management
- Delivery and shipment
- Customer invoicing
- Price and discount management

---

## System / Cross-Cutting

### Company and Division structure

M3 CE uses a Company (CONO) / Division (DIVI) hierarchy to represent the customer's legal entity and operational structure.

- Company: Legal entity level (top-level)
- Division: Operational/accounting unit within a company

**Classification:** M3-GENERAL

**Project-specific instance (HSBC project):** Company 100, Division 001 — see `projects/HSBC-ISO20022/PROJECT.md`.

---

### Multi-company / Multi-currency

M3 CE supports multi-company, multi-currency, and multi-country configurations. This is standard capability. Specific currency and country setup is project-specific.

**Classification:** M3-GENERAL (capability); PROJECT-SPECIFIC (specific setup)

---

## Entries to add as knowledge grows

As implementations proceed, add standard process descriptions here with:
- Process name
- M3 module
- Key functionality
- Integration touchpoints
- Classification: M3-GENERAL

Mark anything unverified as UNKNOWN until confirmed from official Infor documentation or multiple implementation instances.
