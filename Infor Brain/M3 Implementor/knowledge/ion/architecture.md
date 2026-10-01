# ION — Infor Operating Network

> **Classification:** M3-GENERAL (ION is a standard Infor platform component)
> **Source policy:** Add verified ION capabilities. Mark unknowns clearly.

---

## Overview

**Infor ION** is the integration middleware layer in the Infor cloud ecosystem. It provides:

- **Message routing** between Infor applications and external systems
- **Business Object Document (BOD)** based messaging
- **Event-driven integration** triggered by M3 business events
- **ION API** — OAuth2 REST API access to M3 MI programs and other Infor APIs
- **Connection Points** — pre-built connectors to Infor applications

**Classification:** M3-GENERAL

---

## ION Components

### ION API Gateway

Provides OAuth2-authenticated REST API access to:
- M3 MI programs (via `/M3/m3api-rest/v2/execute/{program}/{transaction}`)
- Other Infor application APIs
- ION message queues

**Authentication:** OAuth2 client credentials flow.
**Credential format:** `.ionapi` file containing tenant ID, client ID/secret, service account keys, and SSO/token endpoints.

**Classification:** M3-GENERAL

**Observed in HSBC project:**
- Tenant: `LCCGLNLPSVGTXCNE`
- Environment: TST (test)
- Data centre: SE2 (`mingle-ionapi.se2.inforcloudsuite.com`)
- Tool: DataPulse (uses `.ionapi` for connection)

> The specific tenant ID, environment URLs, and credential values are PROJECT-SPECIFIC. The API pattern is M3-GENERAL.

---

### ION Document Flows

ION routes messages between applications using **Business Object Documents (BODs)**.

**BOD naming convention:** `{Verb}.{Noun}` (e.g. `Sync.CustomerPartyMaster`, `Process.PaymentOrder`)

**Classification:** M3-GENERAL (BOD framework) / UNKNOWN (specific BODs applicable to payment integration — not confirmed from available evidence)

---

### ION Connect

ION Connect provides connection points to external systems (EDI, flat file, web service).

**Classification:** M3-GENERAL (capability) / UNKNOWN (specific connection point details — not confirmed)

---

## ION API — Practical Usage

### Connection setup

1. Request an ION API connection point from the Infor M3 administrator.
2. Download the `.ionapi` credential file for the relevant environment.
3. Use the credential file to obtain OAuth2 tokens via the token endpoint.
4. Make M3 MI program calls using the access token.

### Token flow

```
Client application
    ↓ POST to {pu}token.oauth2
    ↓ with client_id, client_secret (from .ionapi)
ION SSO
    ↓ returns access_token
Client application
    ↓ GET {iu}/M3/m3api-rest/v2/execute/{program}/{transaction}
    ↓ Authorization: Bearer {access_token}
ION API Gateway
    ↓ routes to M3 Business Engine
M3 Business Engine
    ↓ executes MI transaction
    → returns JSON response
```

---

## ION and MEC Relationship

**Classification of relationship understanding:** UNKNOWN — the exact boundary between ION and MEC responsibilities in the HSBC payment integration is not established from available evidence. The functional specification likely contains this detail.

**General principle (M3-GENERAL):** In M3 CE implementations:
- ION handles event-driven, BOD-based integrations and API access.
- MEC handles file-based, scheduled, format-transformation integrations (SFTP, flat files, bank formats).
- IPA can orchestrate workflows that involve both.

The specific toolchain used in the HSBC payment file generation is UNKNOWN — must be confirmed from the functional specification.

---

## Open Questions

- Q1: Which ION component (if any) is used in the HSBC outbound payment file generation? Or is this MEC-only?
- Q2: Does the HSBC inbound acknowledgement use ION document flows or direct SFTP/MEC?

**Source needed:** `FTD_M3_FS 1947_Functional Specification HSBC and SCB Banking Integration_V2.0.docx`
