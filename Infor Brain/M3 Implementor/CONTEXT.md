# M3 Implementor — Active Context

This file defines the **currently active project context** for M3 Implementor.

Read this file **before** responding to any implementation question. The active project determines which project knowledge base is loaded and which project-specific decisions, integrations, and documents are in scope.

---

## Active Project

```yaml
project_code: GC-CR-26-014
project_name: HSBC H2H ISO 20022 Payment Integration
customer: Gold Coin Group
status: ACTIVE
phase: POST-DEPLOYMENT (ongoing — production support and change requests)
```

**Project knowledge base:** `projects/HSBC-ISO20022/`

**Source documents (READ-ONLY):**
`D:\GIT-FTD\Projects\GC-CR-26-014_HSBC H2H ISO 20022\`

> [!IMPORTANT]
> The source documents are read-only reference material. All derived knowledge is stored in `projects/HSBC-ISO20022/`. Never modify the source project directory.

---

## How to Load Context

When beginning work on a question or task:

1. Read this file (`CONTEXT.md`) — identify the active project.
2. Read `projects/{project-code}/PROJECT.md` — load project context.
3. Read `projects/{project-code}/documents.md` — understand available documentation.
4. Read relevant knowledge from `projects/{project-code}/knowledge/` — project-specific facts.
5. Read relevant global knowledge from `knowledge/` — M3-general and integration-general facts.
6. If the question involves a specific integration, read `projects/{project-code}/integrations/{integration}.md`.
7. Check `projects/{project-code}/decisions/decisions.md` — do not reopen settled decisions.
8. Check `projects/{project-code}/open-questions/questions.md` — identify existing unresolved questions.

---

## Switching Projects

To switch to a different project, update the **Active Project** section above with the new project code, customer, status, and phase. Ensure the corresponding `projects/{project-code}/` directory exists and is populated.

When multiple projects are active simultaneously, list them all and specify the **default project** (the one assumed when no project is explicitly specified in a question).

---

## Global Knowledge Base

Regardless of active project, always consult:

- `knowledge/m3/` — for M3 CE program, table, API, and process questions
- `knowledge/integrations/` — for integration pattern and format questions
- `knowledge/ion/` — for ION architecture questions
- `knowledge/mec/` — for MEC architecture questions
- `knowledge/implementation/` — for lifecycle, document role, and gap questions
- `memory/` — for cross-project learnings, gotchas, and anti-patterns

---

## No Active Project

If no project is active and a question is project-specific, respond with:

> "No active project context is loaded. Please specify the project or load a project context by updating `CONTEXT.md`."

For generic M3 questions (not project-specific), proceed using global knowledge only.
