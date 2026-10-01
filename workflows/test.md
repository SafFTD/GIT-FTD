# Workflow: test

> Neutral procedure (source of truth). Surfaced as `/test` (Claude) and the `test` workflow (Antigravity).

Plan and run tests. `tester-planner` writes the plan + test code; `tester-runner` executes (no edit rights). The separation is intentional — it stops tests being weakened to pass.

## Step 1 — Plan + write tests
Invoke `tester-planner` with the feature doc. It:
- Reads the implementation to learn the real interfaces/endpoints.
- Writes a `## Test plan` in the doc, mapping scenarios to each acceptance criterion.
- Writes/finishes test code in the relevant sub-repo (backend pytest, frontend vitest/e2e per `.claude/memory/e2e-test-conventions.md`).

## Step 2 — Execute
Invoke `tester-runner` with the test paths. It runs the tests in each affected sub-repo (`uv run pytest` / `npm test`), captures output, and reports pass/fail. It does NOT edit anything.

## Step 3 — Route failures
- Legitimate test issue (bad assertion/setup) → back to `tester-planner` to fix the test.
- Real bug → back to `backend` / `frontend` to fix the code. Never weaken a test to go green.
Re-run after fixes until green.

## Step 4 — Record + memory
Put final results in the doc under `## Test results`. Aggregate `## Memory candidates`, dedupe, present, append approved.

End with: "Tests green for F<N>. Next: `/review`."

## Constraints
- `tester-runner` has no Edit/Write — keep it that way.
- Tests document behavior; they don't just re-assert the implementation.
