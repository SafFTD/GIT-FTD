# M3 CE — Programs Reference

> **Classification:** Entries must be individually classified.
> **Source policy:** Only add program names confirmed from official Infor M3 documentation,
> Infor M3 program reference, or from direct evidence in implementation work.
> Never invent or guess M3 program names.
>
> **Format:** M3 programs are typically 5–6 character codes (e.g. APS450, PPS200).
> MI programs follow the pattern {Module}{Area}MI (e.g. MDBREADMI, APS450MI).

---

## How to read this file

Each entry has:
- **Program code** — M3 program identifier
- **Description** — what the program does
- **Module** — M3 module
- **Integration relevance** — how it relates to integrations
- **Classification** — M3-GENERAL or UNKNOWN
- **Evidence** — source of confirmation

---

## Finance — Accounts Payable

*No programs have been confirmed from available evidence for this project. The HSBC project functional specification (FTD_M3_FS 1947) was not read during the audit — it likely contains M3 program references. Add entries here when confirmed.*

**Programs likely involved (UNKNOWN — not yet confirmed from evidence):**
- Payment proposal programs (unknown name — do not assume)
- Payment execution programs (unknown name — do not assume)
- AP sub-ledger inquiry (unknown name — do not assume)

> [!WARNING]
> Do not add M3 program names here without a confirmed source. The functional specification document `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx` should be read to extract confirmed program references for the HSBC project.

---

## MI Programs (APIs)

MI (M3 Interface) programs provide programmatic access to M3 transactions and master data.

*No MI programs have been confirmed from available evidence for this project.*

**MI programs likely involved (UNKNOWN — not yet confirmed):**
- Supplier master read (unknown MI program name)
- Bank account master read (unknown MI program name)
- Address master read (unknown MI program name)

---

## How to add programs

When a program is confirmed from evidence:

```markdown
### {ProgramCode} — {Description}

**Module:** {M3 module}
**Type:** [Interactive program / MI program / Batch program / Utility]
**Function:** [What it does]

**Transactions (for MI programs):**
| Transaction | Description | Input | Output |
|---|---|---|---|
| {TXN} | {description} | {key inputs} | {key outputs} |

**Integration relevance:** [How this program is used in integration context]

**Classification:** M3-GENERAL
**Evidence:** [Source — document, official documentation, implementation reference]
```

---

## DataPulse

**Description:** DataPulse is an Infor tool (ION API desktop client) used to execute M3 MI programs directly against the ION API endpoint, primarily for data extraction and validation purposes during implementation.

**Classification:** M3-GENERAL (ION API client — standard Infor tooling)

**Evidence:** `GC_TST_DataPulse.ionapi` — HSBC project (ION API connection file for DataPulse tool)

**Note:** DataPulse connects to the ION API using an `.ionapi` credential file. The credential file contains tenant ID, client credentials, and SSO/token endpoints. The `GC_TST_DataPulse.ionapi` file in the HSBC project connects to the TST (test) environment.

> [!CAUTION]
> The `.ionapi` file in the HSBC project contains OAuth2 credentials (client ID, client secret, service account access key and secret key). This file must never be copied, distributed, or committed to version control. It is sensitive and environment-specific.
