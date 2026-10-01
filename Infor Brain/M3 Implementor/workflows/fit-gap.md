# Workflow: fit-gap

> **M3 Implementor workflow — source of truth.**
> Use this workflow to perform a fit-gap analysis for a set of business requirements
> against standard M3 CE capability.

---

## When to use

- At the start of an implementation to determine what standard M3 covers and what gaps exist.
- When evaluating a specific business requirement to determine the solution approach.
- Before recommending any extension, integration, or custom development.

---

## Step 1 — Load business requirements

**Agent:** m3-business-analyst

Read the business requirement document (BRD or verbal requirements). For each requirement:
- State the business need clearly.
- Identify the business process.
- Identify the M3 module area.

**Output:** Structured list of requirements by process area.

---

## Step 2 — Assess each requirement against standard M3

**Agent:** m3-functional-consultant

For each requirement in Step 1:

1. Identify what standard M3 CE provides in this area.
2. State whether the requirement is:
   - **FIT** — Satisfied by standard M3 configuration.
   - **PARTIAL FIT** — Satisfied by standard M3 with configuration, but with limitations.
   - **GAP** — Standard M3 does not satisfy the requirement.

**Output:** Fit-gap table.

---

## Step 3 — Propose gap solutions

**Agent:** m3-functional-consultant

For each GAP requirement, propose solutions in standard-first order:

1. **Configuration solution** — Can additional M3 configuration close the gap?
2. **Extension solution** — Can M3 extensibility (H5, XD, UDF, workflow) close the gap?
3. **Integration solution** — Is an external integration required?
4. **Custom development** — Last resort.

**Output:** Solution option table with recommendation per gap.

---

## Step 4 — Identify open questions

**Agent:** m3-business-analyst + m3-functional-consultant

For each requirement where the fit/gap is unclear, identify the specific questions that must be answered. Categorise as BUSINESS, FUNCTIONAL, TECHNICAL, REGULATORY.

---

## Step 5 — Review and validate

**Agent:** m3-reviewer

Verify that:
- Standard-first principle was applied.
- No gap was closed with integration when configuration could have worked.
- No integration is proposed without justification.
- Open questions are raised for ambiguous requirements.

---

## Step 6 — Produce fit-gap output

```markdown
## Fit-Gap Analysis — {Project / Requirement Set}

### Summary

| Requirement | Process Area | Fit/Gap | Solution Approach |
|---|---|---|---|
| REQ-001 | [area] | FIT | Standard M3 configuration |
| REQ-002 | [area] | PARTIAL FIT | Configuration + UDF |
| REQ-003 | [area] | GAP | Integration required |

### Requirement Detail

#### REQ-001: {description}
**Fit/Gap:** FIT
**Standard M3 capability:** [what M3 does]
**Configuration required:** [if any]

#### REQ-003: {description}
**Fit/Gap:** GAP
**Why standard M3 is insufficient:** [explanation]
**Recommended solution:** Integration — [technology] — [justification]
**Open questions:** [list]
```

---

## Constraints

- Never recommend integration without first confirming standard M3 cannot satisfy the requirement.
- Never classify as FIT without confirming the specific M3 functionality exists (not assumed).
- Mark any unknown M3 capability as UNKNOWN — do not assume FIT.
