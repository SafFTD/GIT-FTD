# M3 CE — M3 API / MI Program Reference

> **Classification:** Entries must be individually classified.
> **Source policy:** Only add MI programs and APIs confirmed from official Infor M3 API
> documentation, Infor ION API reference, or confirmed implementation evidence.
>
> The Infor M3 API is exposed via ION API (OAuth2). MI programs provide transaction-level
> access. REST APIs provide a higher-level interface.

---

## ION API Access

**Standard access model:**

```
Client Application (e.g. DataPulse, custom application)
    ↓ OAuth2 (client credentials)
ION API Gateway (mingle-ionapi.inforcloudsuite.com)
    ↓
M3 MI Program execution
    ↓
M3 Business Engine response
```

**Authentication:** OAuth2 client credentials flow via `.ionapi` credential file.

**Standard ION API endpoints (M3-GENERAL — from Infor documentation structure):**

| Endpoint pattern | Purpose |
|---|---|
| `{ionapi_url}/M3/m3api-rest/v2/execute/{program}/{transaction}` | Execute MI transaction |
| `{ionapi_url}/M3/m3api-rest/v2/execute/{program}/{transaction}?maxrecs={n}` | List with max records |

**Classification:** M3-GENERAL — standard Infor M3 ION API access pattern

---

## ION API Environments

M3 CE Cloud implementations use the following standard environment pattern:

| Environment | Purpose | ION Base URL pattern |
|---|---|---|
| TST | Test / Development | `mingle-ionapi.se2.inforcloudsuite.com` (SE2 data centre — observed) |
| PRE | Pre-production | Typically same data centre |
| PRD | Production | May be different data centre |

> **Project-specific:** The tenant ID and exact ION URL are customer/project-specific. The HSBC project uses `LCCGLNLPSVGTXCNE` on `se2.inforcloudsuite.com`. These values must NOT be treated as universal.

---

## M3 MI Programs

MI programs are M3's primary API interface. Each program has named transactions (e.g. `LstSuppliers`, `GetHead`, `AddRecord`).

### How MI programs are structured

```
{ProgramCode}MI
├── {Transaction1}   ← e.g. LstSuppliers, GetHead, AddRecord
│   ├── Input fields
│   └── Output fields
└── {Transaction2}
```

---

## Known MI Programs (from evidence)

*No MI programs have been confirmed by name from the available evidence in the HSBC project audit. The functional specification document must be read to extract MI program references.*

**Placeholder — to be populated from:**
- `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx`
- Official Infor M3 API documentation (H5, ION API Explorer)

---

## MI Program Entry Template

When a MI program is confirmed, add an entry:

```markdown
### {ProgramCode}MI — {Description}

**Module:** {M3 module}
**Purpose:** [What this MI program provides access to]
**Classification:** M3-GENERAL

**Evidence:** [Source document / official Infor documentation]

#### Transactions

| Transaction | Description | Key Input Fields | Key Output Fields |
|---|---|---|---|
| {TXN} | {description} | {fields} | {fields} |

**Integration usage:** [How this MI program is used in integration context]
```

---

## REST APIs

Infor M3 CE also exposes REST APIs through the ION API platform.

*REST API details: Not documented from available evidence. Add as confirmed.*

---

## M3 API Anti-patterns

> Move confirmed anti-patterns to `memory/anti-patterns.md`

**Do not:** Hard-code MI program transaction responses without handling error codes.
**Do not:** Assume MI program output field order is stable — use field names, not positions.
**Do not:** Call MI programs without checking the return code (RESP field).
