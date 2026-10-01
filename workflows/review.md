# Workflow: review

> Neutral procedure (source of truth). Surfaced as `/review` (Claude) and the `review` workflow (Antigravity).

Review the diff: `reviewer` first (correctness/quality), then `security` (adversarial). Findings go to the doc; fixes route back to the dev agents.

## Step 1 — Reviewer pass
Invoke `reviewer` with the diff across all affected sub-repo(s). It walks `.claude/memory/code-review-checklist.md` and reports findings (`file:line`, issue, why, shape of fix) sorted by severity into `## Reviewer findings`. It does not edit.

## Step 2 — Security pass
Invoke `security` with the diff. It walks `.claude/memory/security-review-checklist.md`, focusing on auth, **tenant isolation**, input validation, money integrity, secrets, and OI/LLM concerns. Findings (with attack scenarios) go into `## Security findings`. For bugs, run this pass only if the change touches auth, user data, secrets, money, or external input.

## Step 3 — Route fixes
Must-fix (reviewer) and critical/high (security) items route back to `backend` / `frontend`. They fix and summarize what changed (`file:line`). Re-review changed areas if material.

## Step 4 — Memory
Aggregate `## Memory candidates`, dedupe, present, append approved.

End with: "Review complete for F<N>. Next: `/ship` once all must-fix / critical / high items are addressed and tests are green."

## Constraints
- `reviewer` and `security` never edit code.
- `security` focuses on security, not duplicating quality findings.
- Don't manufacture findings — a clean diff gets a clean bill.
