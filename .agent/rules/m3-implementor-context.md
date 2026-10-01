# M3 Implementor — Antigravity workspace rule

**Read `Infor Brain/M3 Implementor/IMPLEMENTOR.md` first.** It defines M3 Implementor's identity, principles, reasoning model, standard-first principle, source attribution model, and directory structure.

**Read `Infor Brain/M3 Implementor/CONTEXT.md` second.** It identifies the active project and specifies which project knowledge base to load.

## Where things live

| Thing | Location |
|---|---|
| Identity + principles | `Infor Brain/M3 Implementor/IMPLEMENTOR.md` |
| Active project context | `Infor Brain/M3 Implementor/CONTEXT.md` |
| Agent definitions | `Infor Brain/M3 Implementor/agents/` |
| Lifecycle workflows | `Infor Brain/M3 Implementor/workflows/` |
| Global M3 knowledge | `Infor Brain/M3 Implementor/knowledge/m3/` |
| Integration knowledge | `Infor Brain/M3 Implementor/knowledge/integrations/` |
| ION knowledge | `Infor Brain/M3 Implementor/knowledge/ion/` |
| MEC knowledge | `Infor Brain/M3 Implementor/knowledge/mec/` |
| Implementation lifecycle | `Infor Brain/M3 Implementor/knowledge/implementation/` |
| Project knowledge (HSBC) | `Infor Brain/M3 Implementor/projects/HSBC-ISO20022/` |
| Source documents (READ-ONLY) | `Projects/GC-CR-26-014_HSBC H2H ISO 20022/` |
| Templates | `Infor Brain/M3 Implementor/templates/` |
| Cross-project memory | `Infor Brain/M3 Implementor/memory/` |

## Critical boundaries

- **Do NOT modify** `Projects/GC-CR-26-014_HSBC H2H ISO 20022/` — it is read-only reference material.
- **Do NOT modify** `.claude/agents/` O Pay agents (ba.md, backend.md, frontend.md, reviewer.md, security.md, tester-planner.md, tester-runner.md).
- **Do NOT contaminate** global knowledge (`knowledge/`) with project-specific facts. Use `projects/{code}/knowledge/` for project-specific observations.
- **Do NOT invent** M3 program names, API names, table fields, or configuration values. If unknown, say so explicitly.

## O Pay context (separate system — unrelated to M3 Implementor)

The O Pay agent system (`.claude/agents/`, `.claude/memory/`, `workflows/`) is a separate product (digital gold investment platform, Sri Lanka). It operates independently of M3 Implementor. Do not confuse the two systems.
