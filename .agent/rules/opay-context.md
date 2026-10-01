# O Pay workspace rules (Antigravity)

**The single source of truth is `AGENTS.md` at the repo root. Read it first.** It defines the product, the multi-repo layout, domain vocabulary, the multi-tenancy model, and the engineering workflow. Do not duplicate context here — put it in `AGENTS.md` so every tool sees it.

## Where things live (shared, tool-neutral)
- **Context:** `AGENTS.md` (Claude reads it via `CLAUDE.md = @AGENTS.md`).
- **Workflow procedures:** `workflows/*.md` — the source of truth for `plan / implement / test / review / ship / remember / save-note / new-tenant / commands / sync`. The files in `.agent/workflows/` are **thin auto-generated stubs** that point back here.
- **Knowledge:** `.claude/memory/*.md`, `features/`, `bugs/`, `COMMANDS.md` — plain markdown both tools read and write directly.
- **Role personas:** `.claude/agents/*.md` — read these as personas (ba, backend, frontend, reviewer, security, tester-planner, tester-runner).

## Keeping in sync with Claude
After you make a change here, **run the `sync` workflow** (it calls `python3 .claude/hooks/sync_adapters.py`) so Claude's command stubs and the Antigravity workflow stubs are regenerated from `workflows/` and stay in parity. When Claude makes a change, a `PostToolUse` hook does this automatically.

If you ever find a procedure or context written only in a Claude- or Antigravity-specific folder, that's a bug — move it to the neutral location (`AGENTS.md`, `workflows/`, or `.claude/memory/`) and re-sync.
