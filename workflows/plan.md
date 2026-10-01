# Workflow: plan

> Neutral procedure (source of truth). Surfaced as `/plan` in Claude and the `plan` workflow in Antigravity. Both stubs say "follow this file."

Run the planning workflow for a feature or bug: detect which, run role agents in two waves, write the doc, decide affected sub-repo(s), create a branch per affected repo.

Be conversational at the natural checkpoints — pedagogical mode is on; don't bulldoze silently.

## Step 1 — Detect feature vs bug
Classify from the description: **Feature** (new capability — "add X") vs **Bug** (defect — "X is wrong when Y"). State your detection; ask the user to confirm. Accept corrections.

## Step 2 — Confirm description completeness
Ask whether the description is complete or needs more context. Surface specific clarifying questions. Iterate until the user says it's complete.

## Step 3 — Number assignment
Features: scan `features/` for the largest `F<N>-*.md`, assign `F<N+1>` (start F1). Bugs: scan `bugs/` for the largest `B<N>-*.md`, assign `B<N+1>` (start B1). State the number.

## Step 4 — Load relevant prior context
- Grep `features/` and `bugs/` for related docs; cite hits.
- Grep `.claude/memory/` for relevant entries (esp. `lessons-learned.md`, `gotchas.md`, `anti-patterns.md`, and `tenant-config.md` if tenant-related). Surface what the user should know.

## Step 5 — Wave 1 (parallel agents)
Run in parallel (one message, multiple Agent calls):
- Features: `ba` (domain analysis) + `tester-planner` (acceptance criteria).
- Bugs: `tester-planner` only (regression scenarios).
Wait, aggregate.

## Step 6 — Wave 2 (parallel agents)
Pass Wave 1 outputs as context:
- Features: `frontend` (UI), `backend` (architecture/API), `reviewer` (feature-specific checklist), `security` (considerations).
- Bugs: `frontend` and/or `backend` (whichever owns the area) for root cause + fix; `reviewer` checklist; `security` ONLY if the bug touches auth, user data, secrets, money, or external input.
Wait, aggregate.

## Step 7 — Synthesize and show the plan
Present one consolidated markdown summary (BA findings, ACs, UI, backend architecture, review checklist, security, data, flow). Ask for clarifications/pushback. Iterate until satisfied.

## Step 8 — Decide affected sub-repo(s)
State which sub-repos this touches (`opay-backend`, `opay-merchant-web`, future frontends). This drives branches and PRs — see `AGENTS.md` multi-repo git rule.

## Step 9 — Write the doc
On approval, write `features/F<N>-<slug>.md` or `bugs/B<N>-<slug>.md`. Include all Wave 1+2 sections, plus a required **`## Affected repos`** section listing each sub-repo and its branch/PR (PR filled at `/ship`). Show the path; ask the user to confirm.

## Step 10 — Branch per affected sub-repo
For each affected sub-repo, `cd` into it and create a branch: `feature/F<N>-<slug>` or `bug/B<N>-<slug>`. (Offer a git worktree only if working multiple features in parallel.) If a sub-repo isn't a git repo yet, prompt to `git init` first.

## Step 11 — Memory review
Aggregate every `## Memory candidates` from the agents. Dedupe against `.claude/memory/*.md`. Present survivors one at a time (yes/no). Append approved ones.

End with: "Planning complete for F<N>. Next: `/implement`."

## Constraints
- Give each agent only the context it needs.
- Don't skip user checkpoints.
- Ask before guessing.
