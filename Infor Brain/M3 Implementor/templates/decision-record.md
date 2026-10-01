# Decision Record Template

> Copy to `projects/{project-code}/decisions/decisions.md` or add a new entry.
> Every significant implementation decision should be recorded here.
> The goal is to prevent the same decision from being reopened unnecessarily.

---

## Decision Format

```markdown
### D{NNN}: {Short title}

**Date:** [YYYY-MM-DD or UNKNOWN]
**Project:** [{project-code}]
**Status:** [OPEN / DECIDED / SUPERSEDED]
**Owner:** [who made or who must make this decision]
**Source:** [meeting, document, email — cite specifically. If inferred from evidence, say so.]

**Decision context:**
[What implementation question required a decision — 2-3 sentences]

**Options considered:**
- Option A: [description — pros/cons]
- Option B: [description — pros/cons]
- Option C: [if applicable]

**Selected approach:** [what was decided]

**Rationale:** [why this option was selected — be explicit. If rationale is unknown, say UNKNOWN.]

**Impact:**
[What does this decision affect — components, behaviour, downstream processes]

**Dependencies:**
[What depends on this decision]

**Superseded by:** [D{NNN} if this decision was later reversed]
```

---

## Decision Status Values

| Status | Meaning |
|---|---|
| OPEN | Decision is required but has not been made |
| DECIDED | Decision has been made — do not reopen without new evidence |
| SUPERSEDED | A later decision (reference: D{NNN}) replaced this one |

---

## Example Entry

```markdown
### D001: BIC field BAF4 used as primary BIC source in CBANAC

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from implementation evidence)
**Owner:** FTD Technical Team
**Source:** ISO20022_Swift_BIC Master Data Validation_SQL V1.sql

**Decision context:**
M3 CBANAC has two BIC-related fields: BAF4 and SWBI. The integration must read from
one field consistently.

**Options considered:**
- Option A: Use BAF4 as primary BIC field
- Option B: Use SWBI as primary BIC field
- Option C: Check both, prefer BAF4 with SWBI fallback

**Selected approach:** Option A — BAF4 is the primary BIC field.

**Rationale:** UNKNOWN — rationale not documented in available evidence.

**Impact:** All BIC validation and payment file generation reads from CBANAC.BAF4.

**Dependencies:** Supplier bank accounts must have BIC in BAF4 field to be included.
```
