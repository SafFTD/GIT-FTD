# Integration Descriptor Template

> Copy this template to `projects/{project-code}/integrations/{integration-name}.md`
> Fill in all sections. Mark UNKNOWN where information is not yet established.
> Do NOT leave sections blank — use UNKNOWN with a source note.

---

## Integration Identity

| Attribute | Value | Classification | Source |
|---|---|---|---|
| Integration ID | INT-{NNN} | PROJECT-SPECIFIC | — |
| Integration name | | PROJECT-SPECIFIC | — |
| Project code | | PROJECT-SPECIFIC | — |
| Version | 1.0 | — | — |
| Status | [DESIGN / BUILD / SIT / UAT / DEPLOYED / DEPRECATED] | — | — |

---

## Summary

**Business purpose:** [What business need this integration serves — 2-3 sentences]

**Direction:** [OUTBOUND / INBOUND / BIDIRECTIONAL]

**Source system:** [system name]
**Target system:** [system name]

**Integration technology:** [ION / MEC / IPA / SFTP / API / file / middleware]
**Message format:** [ISO 20022 pain.001.001.03 / CSV / EDI / JSON / XML / other]

---

## Countries / Scope

| Country | Currency | Entity | Status |
|---|---|---|---|
| [country] | [currency] | [legal entity] | [in-scope / out-of-scope / planned] |

---

## M3 Components

| Component | Value | Classification | Source |
|---|---|---|---|
| M3 Module | | M3-GENERAL | |
| M3 Program | UNKNOWN — pending [source] | UNKNOWN | — |
| MI Program / API | UNKNOWN — pending [source] | UNKNOWN | — |
| M3 Tables | | M3-GENERAL | |
| Trigger mechanism | UNKNOWN — pending [source] | UNKNOWN | — |

---

## Outbound Flow (if applicable)

```
[Business trigger]
    ↓
[M3 data extraction — program/table]
    ↓
[Transformation — tool + format]
    ↓
[Delivery — protocol + endpoint]
    ↓
[Acknowledgement — format + matching]
    ↓
[Reconciliation — M3 update]
```

---

## Inbound Flow (if applicable)

```
[External trigger]
    ↓
[Message receipt — protocol + pickup]
    ↓
[Validation — format + business rules]
    ↓
[Transformation — tool]
    ↓
[M3 API / MI call — program + transaction]
    ↓
[M3 processing outcome]
    ↓
[Acknowledgement — to sender]
```

---

## Master Data Dependencies

| Table | Fields | Mandatory | Validation | Source |
|---|---|---|---|---|
| [table] | [fields] | [Y/N] | [rule] | [document] |

---

## Delivery

| Attribute | Value | Classification |
|---|---|---|
| Protocol | SFTP / HTTPS / ION / other | |
| Endpoint | UNKNOWN — see [source] | PROJECT-SPECIFIC |
| Directory | UNKNOWN | PROJECT-SPECIFIC |
| Filename convention | UNKNOWN | PROJECT-SPECIFIC |
| Schedule | UNKNOWN | PROJECT-SPECIFIC |

---

## Acknowledgement

| Attribute | Value |
|---|---|
| Ack type | Synchronous / Asynchronous / None |
| Ack format | UNKNOWN |
| Ack matching | UNKNOWN |

---

## Error Handling

| Error scenario | Detection | Response | Notification |
|---|---|---|---|
| Format invalid | | | |
| Delivery failure | | | |
| Target rejection | | | |
| Master data missing | | | |

---

## Security

| Attribute | Value |
|---|---|
| Authentication | UNKNOWN — see [source] |
| Transport encryption | UNKNOWN |
| Credential storage | UNKNOWN — do NOT record actual credentials here |

---

## Gap Assessment

| Gap Type | Status | Detail |
|---|---|---|
| REQUIREMENT-GAP | [PRESENT / GAP / UNKNOWN] | |
| DESIGN-GAP | [PRESENT / GAP / UNKNOWN] | |
| MAPPING-GAP | [PRESENT / GAP / UNKNOWN] | |
| DEVELOPMENT-GAP | [PRESENT / GAP / UNKNOWN] | |
| TEST-GAP | [PRESENT / GAP / UNKNOWN] | |
| DEPLOYMENT-GAP | [PRESENT / GAP / UNKNOWN] | |
| MONITORING-GAP | [PRESENT / GAP / UNKNOWN] | |
| DATA-GAP | [PRESENT / GAP / UNKNOWN] | |
| ACKNOWLEDGEMENT-GAP | [PRESENT / GAP / UNKNOWN] | |
| OWNERSHIP-GAP | [PRESENT / GAP / UNKNOWN] | |

---

## Documents

| Document | Role Code | Status | Location |
|---|---|---|---|
| [document] | [code] | [FOUND / MISSING] | [path] |

---

## Decisions

See `decisions/decisions.md` in the project folder.

| Decision ID | Summary | Status |
|---|---|---|
| D{NNN} | | DECIDED / OPEN |

---

## Open Questions

See `open-questions/questions.md` in the project folder.

| Question ID | Summary | Priority | Status |
|---|---|---|---|
| Q{NNN} | | HIGH / MEDIUM / LOW | OPEN |
