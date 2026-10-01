# M3 CE — Extensibility Reference

> **Classification:** M3-GENERAL (standard extensibility capability descriptions)
> **Source policy:** Add confirmed extensibility capabilities. Mark specifics as UNKNOWN
> if not verified against official Infor M3 CE documentation.

---

## Extensibility Layers

M3 CE Cloud Edition provides multiple layers of extensibility. When standard configuration is insufficient, evaluate these in order before recommending custom development:

```
Layer 1: Configuration
    ├── M3 parameters and settings
    ├── User-defined fields (UDF)
    ├── Number series
    └── Business rules / validation rules

Layer 2: M3 Extensibility Framework
    ├── H5 (M3 H5 Client — web-based M3 UI)
    │   └── UI extensions, field additions, scripts
    ├── Experience Designer (XD)
    │   └── Custom applications and workflows on top of M3
    └── M3 Workflow
        └── Approval workflows, event-driven automation

Layer 3: Integration
    ├── ION (Infor Operating Network)
    ├── MEC (M3 Enterprise Collaborator)
    ├── IPA (Infor Process Automation)
    └── IDM (Infor Document Management)

Layer 4: Custom Development
    └── Last resort — requires strong justification in M3 CE Cloud
        (Cloud tenants have significant restrictions on code customisation)
```

---

## H5 Client

**Description:** The M3 H5 Client is the standard web-based user interface for M3 CE. It supports UI extensions through scripts and layouts that do not modify the M3 Business Engine.

**Classification:** M3-GENERAL

**Extensibility capabilities (unverified — mark UNKNOWN until confirmed):**
- Adding fields to existing screens
- Adding buttons and actions
- Running scripts on form events
- Custom views

---

## Experience Designer (XD / Experience Studio)

**Description:** Infor Experience Designer (also known as Experience Studio or Homepages) allows creation of custom user experiences on top of M3 data without modifying the M3 Business Engine.

**Classification:** M3-GENERAL (capability exists — specific features UNKNOWN until confirmed)

**Use cases:**
- Custom dashboards
- Simplified entry screens
- Approval flows surfaced as custom apps

---

## User-Defined Fields (UDF)

**Description:** M3 CE supports user-defined fields on certain master data entities. UDFs extend standard records without code changes.

**Classification:** M3-GENERAL (capability confirmed standard — specific UDF locations UNKNOWN until confirmed per entity type)

---

## M3 Workflows

**Description:** M3 supports workflow-driven approval processes. Certain transactions can be routed through approval workflows before processing.

**Classification:** M3-GENERAL (capability confirmed — specific workflow setup UNKNOWN until confirmed)

---

## IPA (Infor Process Automation)

**Description:** IPA is Infor's process automation tool. It can automate M3 processes, integrate with ION events, and orchestrate multi-step workflows involving M3 and external systems.

**Classification:** M3-GENERAL (component exists — capabilities UNKNOWN until confirmed from official documentation)

**Integration relevance:** IPA can be used to automate integration steps — e.g. triggering an outbound file generation based on an M3 event, or processing an inbound file through validation before posting to M3.

---

## Adding entries

When a specific extensibility capability is confirmed from evidence or official documentation, add it with:
- Classification: M3-GENERAL
- Source evidence
- Specific capability description
- Known limitations in M3 CE Cloud context
