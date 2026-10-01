# Workflow: ship

> Neutral procedure (source of truth). Surfaced as `/ship` (Claude) and the `ship` workflow (Antigravity).

Verify readiness, then ship **one branch + one PR per affected sub-repo**, all linked from the single umbrella feature doc.

## Step 1 — Verify readiness
Read the doc. Confirm: Wave 1+2 outputs present; implementation done; all must-fix reviewer items addressed; all critical/high security items addressed; unit + e2e tests green. If anything is missing, list it and STOP — don't ship incomplete work.

## Step 2 — Optional post-notes
Ask whether any role should append a short `## Post-notes` reflection. Spawn only the agreed agents.

## Step 3 — Final memory review
Aggregate any leftover `## Memory candidates`, dedupe, present, write approved.

## Step 4 — Per affected sub-repo: commit, push, PR
For **each** sub-repo in `## Affected repos`, `cd` into it and:
1. `git status` — review what's uncommitted. If only intended changes, commit with a HEREDOC message:
   ```
   git commit -m "$(cat <<'EOF'
   [F<N>] <short description>

   Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
   EOF
   )"
   ```
2. `git push -u origin <branch>`.
3. Open the PR targeting that repo's `main`:
   ```
   gh pr create --title "[F<N>] <short description>" --body "$(cat <<'EOF'
   ## Summary
   - <bullet from doc>

   ## Test plan
   - [ ] <from doc Test plan>

   ## Umbrella doc
   - features/F<N>-<slug>.md (in opay-dev-docs)
   EOF
   )"
   ```
4. Record the PR URL back in the doc's `## Affected repos` row for that repo.

## Step 5 — Commit the doc
In the umbrella repo, commit the finalized `features/F<N>-<slug>.md` (it now lists every PR). Push.

## Step 6 — Worktree cleanup (if used)
If `/plan` created worktrees, offer to clean them up now or later.

## Constraints
- Never ship if any phase/test/review item is unaddressed.
- No `--force` / `--no-verify` unless the user explicitly asks.
- PRs target `main` in each sub-repo.
- If `gh` is unavailable/unauthenticated, surface it — never fake a PR URL.
- One feature doc → potentially many branches/PRs (multi-repo rule).
