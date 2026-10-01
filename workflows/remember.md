# Workflow: remember

> Neutral procedure (source of truth). Surfaced as `/remember` (Claude) and the `remember` workflow (Antigravity).

Curate `.claude/memory/` — promote a durable learning into the right memory file so every tool (and future session) benefits.

## Steps
1. Take the insight from the user (or from a just-finished phase).
2. Pick the target file by kind:
   - conventions → `code-quality.md` / `naming.md` / `syntax-conventions.md`
   - traps/surprises → `gotchas.md`
   - things to avoid → `anti-patterns.md`
   - cross-feature insights → `lessons-learned.md`
   - reusable helpers → `reusable-utilities.md`
   - styling → `design-tokens.md`; messages → `message-constants.md`; tenants → `tenant-config.md`
   - review/security/test checklists → the matching `*-checklist.md` / `*-conventions.md`
3. Check for an existing entry covering it — update rather than duplicate.
4. Append a concise, self-contained entry. State the rule and the why.
5. Confirm the file + entry with the user.

## Constraints
- One fact per entry; don't restate what the code or `AGENTS.md` already says.
- Memory is shared knowledge both Claude and Antigravity read — keep it tool-neutral.
