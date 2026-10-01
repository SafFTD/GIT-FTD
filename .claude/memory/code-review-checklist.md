# Code Review Checklist

What the `reviewer` agent looks for when reviewing a feature or bug's diff. Use as a sweep — don't comment on every item, comment where there's a real issue.

## Correctness

- Does the diff actually do what the feature/bug doc says it should do?
- Are edge cases covered? Empty inputs, large inputs, negative numbers, missing optional fields, concurrent requests.
- Error paths — does every error case have a defined behavior? No silent failures.
- Race conditions in async / concurrent code.

## Quality

- See `.claude/memory/code-quality.md` — function length (BE 30/60, FE 150/30), one purpose per function, early returns, no nested ternaries.
- See `.claude/memory/naming.md` — idiomatic per language; consistent stems across layers.
- See `.claude/memory/syntax-conventions.md` — language-specific rules.
- Comments only when WHY is non-obvious. Delete WHAT-explaining comments.
- No commented-out code.
- No leftover `console.log` / `print` / debug noise.

## Architecture

- Did the diff introduce abstraction prematurely? Three similar lines is not a pattern; four is.
- Did it leak implementation details across layers (e.g. DB column names in API responses)?
- Single responsibility per module — does the new file pull its weight, or is it doing what an existing one already does?
- See `.claude/memory/anti-patterns.md` — known patterns to avoid.

## Tests

- Are the tests new code requires actually present?
- Do tests exercise behavior, not implementation?
- Are flaky tests being introduced (timing, ordering, random data without seed)?
- Does the test suite still run reasonably fast? Flag any test taking > 5s.

## Performance

- N+1 queries — any loop with a DB call?
- Unnecessary re-renders / re-fetches on the frontend?
- Synchronous I/O in async code paths?

## Reuse

- Did the diff reinvent something that already exists in `.claude/memory/reusable-utilities.md`?
- If it added something genuinely reusable, did it propose adding it to `reusable-utilities.md` (memory candidate)?

## Documentation

- Is the feature/bug doc up-to-date with what actually got built?
- Public functions / types have at least a one-line doc if their purpose isn't obvious from the name.

## Output

End the review with:

```markdown
## Reviewer findings — F<N>

### Must-fix
- <item> (file:line) — <why>

### Should-fix (style / clarity)
- <item> (file:line) — <why>

### Praise / patterns to keep
- <item> — <why worth highlighting>

## Memory candidates
- → .claude/memory/<file>.md: <candidate entry>
```
