# Workflow: commands

> Neutral procedure (source of truth). Surfaced as `/commands` (Claude) and the `commands` workflow (Antigravity).

Refresh `COMMANDS.md` — the canonical, grouped dev-command reference — from each repo's command surface.

## Steps
1. Scan command-defining files across sub-repos:
   - `opay-backend/pyproject.toml` (uv scripts, deps), any `justfile`, `docker-compose.yml`.
   - `opay-merchant-web/package.json` (npm scripts), Vite/eslint config.
2. Extract the runnable commands (run app, logs, docker, db/Supabase, tests, lint, tenants, git/workflow).
3. Merge into `COMMANDS.md` under the right headings — don't drop hand-written notes; reconcile additions.
4. Group by repo and by task. Keep commands copy-pasteable.

## Trigger
A `PostToolUse` hook nudges you when a command-defining file (`pyproject.toml`, `package.json`, `docker-compose.yml`, `justfile`) is edited — run this then.

## Constraints
- `COMMANDS.md` is the single home for dev commands — never keep them only in your head or in a tool-specific file.
