# M3 Implementation — Anti-patterns

> **Classification:** INTEGRATION-GENERAL / M3-GENERAL
> Implementation patterns to explicitly avoid.
> Promoted here via the `remember` workflow.
>
> See also: `knowledge/integrations/anti-patterns.md` for integration-specific anti-patterns.

---

## Format

```markdown
## A{N}: {Short name}

**Classification:** [M3-GENERAL / INTEGRATION-GENERAL]
**Evidence:** [Project / context where this was observed]

**What it looks like:** [The pattern being rejected]
**Why it's bad:** [1-3 sentences]
**Do this instead:** [The preferred approach]
**Exceptions:** [When (if ever) the anti-pattern is the right call]
```

---

## Entries

### A1: Presenting an inference as a sourced fact

**Classification:** M3-GENERAL (applies to all implementation knowledge)

**What it looks like:**
Stating "ISO 20022 requires Town and Country in postal addresses" without citing the ISO standard or bank specification — based only on observing validation SQL in a project.

**Why it's bad:** The inference may be correct for a specific project or bank but wrong as a universal rule. Subsequent implementations that rely on this "fact" may design incorrectly, leading to rework when the actual bank requirement differs.

**Do this instead:** Always distinguish SOURCE, OBSERVATION, INFERENCE, and RECOMMENDATION. Cite the document or specification. If not confirmed from an authoritative source, classify as UNKNOWN or PROJECT-SPECIFIC.

**Exceptions:** None — source attribution is always required for significant implementation claims.

---

### A2: Recommending integration before confirming standard M3 cannot solve the requirement

**Classification:** M3-GENERAL

**What it looks like:**
A user asks "How do we send invoices to suppliers?" and the agent immediately recommends an EDI or API integration without checking whether M3's standard supplier communication features can handle it.

**Why it's bad:** Custom integrations add implementation cost, maintenance burden, and failure risk. Standard M3 features that are ignored lead to unnecessary complexity.

**Do this instead:** Always apply the standard-first principle. Evaluate Configuration → Extension → Integration → Custom Development in that order. Document why each layer is insufficient before recommending the next.

**Exceptions:** If the requirement clearly requires external system communication (e.g. bank payment file, EDI with trading partner), proceed to integration design directly while still noting the standard M3 assessment.

---

### A3: Skipping open question documentation because the answer seems obvious

**Classification:** M3-GENERAL

**What it looks like:**
The implementation team assumes the payment trigger, error handling, or retry mechanism without documenting the assumption or the decision.

**Why it's bad:** "Obvious" assumptions frequently turn out to be wrong at UAT or in production. Undocumented assumptions become invisible technical debt that surfaces as defects.

**Do this instead:** Raise every significant assumption as an open question. If the answer is known, document it as a decision. If it is assumed, document it as an assumption pending confirmation.

**Exceptions:** None — open questions and decisions must always be documented.

---

### A4: Contaminating global knowledge with project-specific data

**Classification:** M3-GENERAL (architecture of M3 Implementor knowledge base)

**What it looks like:**
Adding Gold Coin's company identifier (ABCA0946001) to the global knowledge base as if it is a standard M3 or ISO 20022 value. Adding HSBC BIC codes as general examples. Adding Company 100 as a default M3 company code.

**Why it's bad:** Future users of M3 Implementor will receive incorrect information specific to one customer, potentially causing incorrect implementation decisions for different customers.

**Do this instead:** Always classify knowledge before storing it. Customer-specific, project-specific, and bank-specific values belong in `projects/{code}/knowledge/`, not in `knowledge/`. Only M3-GENERAL and INTEGRATION-GENERAL facts belong in the global knowledge base.

**Exceptions:** None — this is a fundamental architectural principle of M3 Implementor.
