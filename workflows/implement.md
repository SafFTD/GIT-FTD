# Workflow: implement

> Neutral procedure (source of truth). Surfaced as `/implement` (Claude) and the `implement` workflow (Antigravity).

Build the feature/bug against the agreed plan. Backend and frontend coordinate the API contract first, then split per sub-repo.

## Step 1 — Load the doc
Read `features/F<N>-<slug>.md` (or the bug doc). Confirm Wave 2 architecture/UI and the `## API contract` and `## Affected repos` sections exist. If the contract is incomplete, finalize it now (see Step 2).

## Step 2 — Lock the API contract (if touching both layers)
Have the `backend` and `frontend` agents jointly finalize request/response shapes and endpoint paths in the doc's `## API contract`. Neither side changes it unilaterally afterward.

## Step 3 — Implement per sub-repo
Split the work and `cd` into each affected sub-repo on its branch:
- `backend` agent → `opay-backend/` (routers/services/schemas under `app/features/<domain>/`, migrations under `supabase/migrations/`, messages via `app/core/messages.py`).
- `frontend` agent → the frontend repo (`opay-merchant-web/src/…`; styles via design tokens, copy via message constants).
Each writes unit tests alongside (`.claude/memory/unit-test-conventions.md`).

## Step 4 — Keep docs current
Update the feature doc with any decisions/contract changes. If you changed deps/scripts/migrations or tooling, update `COMMANDS.md`. Fix `opay-backend/CLAUDE.md` / `opay-merchant-web/CLAUDE.md` if you touched something they describe.

## Step 5 — Memory review
Aggregate `## Memory candidates` from the dev agents, dedupe, present, append approved ones.

End with: "Implementation complete for F<N>. Next: `/test`."

## Constraints
- Respect agent scope boundaries (backend edits only `opay-backend/`; frontend only its repo).
- Migrations are backend-only.
- Honor the single-source rules: `.claude/memory/design-tokens.md`, `.claude/memory/message-constants.md`.
- Multi-repo: one branch per affected sub-repo.
