# E2E / Integration Test Conventions

End-to-end and HTTP-level integration tests. Read by `tester-planner` (who writes them) and `tester-runner` (who executes them). Distinct from unit tests — these hit the real stack.

## What counts as an e2e test here

A test that exercises the full stack from an HTTP request boundary down to the database (and back), with all real dependencies wired up. No mocks except for external third-party services (Stripe, OpenAI, etc., which get fakes).

## Structure

- File location: `tests/e2e/<feature>.test.ts` (frontend) or `tests/e2e/<feature>_test.py` (backend).
- One test file per feature. Group scenarios with `describe` / class.
- Each test sets up its own user, its own data, cleans up after itself. No order dependencies.

## Auth and identity

- Each test creates its own user via the test fixture (not the public sign-up API, unless testing sign-up itself).
- Tokens / sessions are issued via the test fixture, not real OAuth round-trips.

## Test plan format (tester-planner writes this)

Before writing tests, `tester-planner` writes a test plan into the feature doc under `## Test plan` section, structured as:

```markdown
## Test plan

### Acceptance criteria
- AC1: User can …
- AC2: When X, the system Y.

### Test scenarios (mapped to AC)
- [AC1] T1: <scenario description>
- [AC1] T2: <edge case description>
- [AC2] T3: …

### Out of scope (not tested here)
- ...
```

Each `T<N>` becomes one test function.

## Naming

- Python: `def test_<scenario_description>(client, ...):`
- TypeScript: `it("scenario description", async () => { ... })`
- Match the test name to the scenario in the test plan (T1, T2, ...).

## Running

- Local: `pnpm test:e2e` (frontend) / `pytest tests/e2e` (backend) — both should run against a local Postgres + the API running locally.
- CI: every PR runs the full e2e suite.

## tester-runner role

The `tester-runner` agent executes the tests `tester-planner` wrote. It does NOT have access to the implementation — only to the test plan and the test files. It runs them, reports results back, and never edits the tests to "make them pass." If a test fails legitimately, it returns the failure with stdout/stderr and lets the dev agents fix the code or the planner fix the test.

This separation is intentional: it stops "the agent that wrote the test" from being tempted to weaken assertions when implementation doesn't match.
