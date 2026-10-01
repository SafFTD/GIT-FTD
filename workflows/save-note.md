# Workflow: save-note

> Neutral procedure (source of truth). Surfaced as `/save-note` (Claude) and the `save-note` workflow (Antigravity).

Quickly capture an in-flight note tied to the current feature/bug — lighter than `/remember` (which curates shared conventions).

## Steps
1. Identify the active work item (current branch or the doc in context). If unclear, ask.
2. Append the note to that `features/F<N>-…md` or `bugs/B<N>-…md` under a `## Notes` section (create it if absent), timestamped.
3. If the note is actually a durable convention (not item-specific), suggest `/remember` instead and route it to `.claude/memory/`.

## Constraints
- Notes are work-item scoped; conventions belong in `.claude/memory/` via `/remember`.
