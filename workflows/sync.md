# Workflow: sync

> Neutral procedure (source of truth). Surfaced as `/sync` (Claude) and the `sync` workflow (Antigravity).

Regenerate the tool-specific stubs from the neutral `workflows/*.md`, and check Claude↔Antigravity parity. This is what keeps a change made in one tool visible to the other.

## Steps
1. Run the single regenerator: `python3 .claude/hooks/sync_adapters.py`.
   - For each `workflows/<name>.md`, it (re)writes a thin stub at `.claude/commands/<name>.md` (Claude slash command) and `.agent/workflows/<name>.md` (Antigravity workflow). Each stub just says "follow `workflows/<name>.md`" and carries the description.
   - It removes stubs whose neutral workflow no longer exists.
2. Verify parity: the set of stubs in `.claude/commands/` and `.agent/workflows/` matches `workflows/`.
3. If you find context or a procedure living in only one tool's folder, that's a bug — move it to the neutral location (`workflows/` or `.claude/memory/` or `AGENTS.md`) and re-run.

## When it runs
- **Claude:** automatically — a `PostToolUse` hook runs the regenerator when you edit `workflows/*.md` or `AGENTS.md`. Or run `/sync` manually.
- **Antigravity:** run the `sync` workflow after making a change so Claude's stubs/parity update too.

## Constraints
- The regenerator only writes stubs under `.claude/commands/` and `.agent/workflows/`. It never edits `workflows/`, `AGENTS.md`, or `.claude/memory/`.
- Context lives once in `AGENTS.md`; procedures live once in `workflows/`. Stubs are disposable.
