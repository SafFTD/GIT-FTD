# Unit Test Conventions

How to write unit tests in this project. Read by `frontend`, `backend`, `tester-planner`. Unit tests are written *with* the implementation, not after.

## Universal rules

- **One behavior per test.** Test name describes the behavior, not the method: `returns_403_when_user_not_owner` beats `test_delete_scenario`.
- **Arrange → Act → Assert** structure, blank lines between sections.
- **No shared mutable state across tests.** Each test sets up its own.
- **Test the contract, not the implementation.** If a refactor preserves behavior, the test should still pass.
- **Don't mock what you own.** Mock external systems (third-party APIs, time). Use real instances for your own code.
- **No flaky tests.** A test that passes "most of the time" is a broken test. Investigate and fix or delete.

## Python (pytest)

- Files: `tests/<module>/test_<thing>.py`
- Test functions: `test_<behavior_description>`
- Fixtures: `tests/conftest.py` for shared, module-level `conftest.py` for scoped
- Use `pytest.mark.parametrize` for the same test across multiple inputs
- For async code: `pytest-asyncio` with `@pytest.mark.asyncio`
- Database: use a real Postgres test DB with per-test transaction rollback (via `pytest-postgresql` or an explicit fixture). Don't mock the ORM.

```python
async def test_attempt_marks_solved_when_all_tests_pass(db, user, scenario):
    attempt = await create_attempt(db, user_id=user.id, scenario_id=scenario.id)
    result = await submit_attempt(db, attempt.id, solution="correct code")
    assert result.solved is True
    assert result.judge_passed is True
```

## TypeScript (Vitest / Jest)

- Files: co-located `<thing>.test.ts` next to the source file (preferred) OR `__tests__/<thing>.test.ts`
- Use `describe` for grouping, `it` for behavior
- For React components: Vitest + React Testing Library. Query by role / label, not by class / data-testid (unless no alternative).
- For hooks: `renderHook` from RTL
- Mocks: `vi.mock` for modules, but prefer dependency injection so you don't need mocks

```ts
describe("scenarioMatcher", () => {
  it("returns null when no scenario matches the package set", () => {
    expect(scenarioMatcher({ skill: "python", drill: "bug-fix", packages: ["unknown"] })).toBeNull();
  });
});
```

## What to test

- **Pure logic:** every branch, every edge.
- **Boundaries:** off-by-ones, empty inputs, max sizes, type coercion.
- **Error paths:** every error your function can raise gets a test that triggers it.
- **Integrations:** test the integration of *your* code with framework primitives (e.g. that your FastAPI dependency wiring works), not the framework itself.

## What NOT to test

- Don't test framework code (e.g. that `FastAPI` parses query params correctly).
- Don't test private functions directly. Test them via the public API.
- Don't write tests that just re-implement the function in the test.

## When in doubt — write the test first

Doing TDD on a tricky function is faster than debugging it later.
