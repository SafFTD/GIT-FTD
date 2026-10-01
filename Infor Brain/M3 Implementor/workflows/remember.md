# Workflow: remember

> **M3 Implementor workflow — source of truth.**
> Promote a durable learning from project work into the appropriate memory file
> so that M3 Implementor benefits from it in future sessions and projects.

---

## When to use

- After completing an implementation analysis where a new pattern was identified.
- After a review identifies a recurring mistake.
- After a project reveals a gotcha that should not be repeated.
- After a cross-project insight emerges that applies broadly.

---

## Steps

1. **Identify the learning.** What is the insight? State it clearly.

2. **Classify the knowledge type.** Is this:
   - M3-GENERAL? → `knowledge/m3/`
   - INTEGRATION-GENERAL? → `knowledge/integrations/`
   - PROJECT-SPECIFIC? → `projects/{code}/knowledge/` (do NOT put in global memory)
   - Cross-project implementation pattern? → `memory/lessons-learned.md`
   - A trap/mistake to avoid? → `memory/gotchas.md` or `knowledge/integrations/anti-patterns.md`
   - A process rule? → `knowledge/implementation/lifecycle.md` or `document-roles.md`

3. **Check for existing entries.** Search the target file for an existing entry covering this learning. Update rather than duplicate.

4. **Compose the entry.** State the rule and the why. Be concise. Include:
   - Evidence source (which project, which document)
   - Classification
   - Applies-to context (when this lesson kicks in)

5. **Verify the classification is correct.** A PROJECT-SPECIFIC fact must NEVER be promoted to global knowledge (`knowledge/`).

6. **Confirm with the user** before writing.

7. **Write to the appropriate file.**

---

## Constraints

- Never promote PROJECT-SPECIFIC, CUSTOMER-SPECIFIC, or BANK-SPECIFIC observations to global knowledge without strong evidence they are universal.
- Always cite the source project and evidence document.
- One fact per entry. Do not bundle multiple learnings.
- Memory is tool-neutral — write in plain markdown that any AI tool can read.
