# Syntax Conventions

Style preferences that go beyond naming. Read by `frontend`, `backend`, `reviewer`. Grows over time as patterns appear in reviews.

## Python

- **Type hints required** on all function signatures (mypy-friendly).
- Prefer `pathlib.Path` over `os.path` for paths.
- Use `dataclasses` (or `pydantic.BaseModel` for API models) over plain dicts for structured data with known shape.
- f-strings for formatting. Avoid `%` and `.format()`.
- `from __future__ import annotations` at the top of every file (postpones type-hint evaluation; avoids forward-reference issues).
- Import order: stdlib, third-party, first-party (separated by blank lines).

## TypeScript

- `interface` for object shapes; `type` for unions, intersections, and utility types. Don't mix purposes.
- Prefer `const` over `let`. Never `var`.
- Async/await everywhere. Use Promise chains only for one-liners.
- Functional React components with hooks. No class components.
- Named exports over default exports — except where the framework requires default (Next.js `page.tsx`, `layout.tsx`).
- Strict mode on (`strict: true` in `tsconfig.json`). No `any` without an explicit `// any: <reason>` comment.
- Prefer optional chaining (`obj?.field?.nested`) over manual null checks.

## Go

- `gofmt` is law (and `goimports`).
- Errors: return last, named `err`, checked immediately: `if err != nil { return …, fmt.Errorf("doing X: %w", err) }`. Always wrap with `%w` when bubbling up.
- Avoid `panic` outside `main` / `init`. Surface errors instead.
- `context.Context` is the first parameter for any function that does I/O or could be cancelled.
- Don't `init()` unless absolutely required (it makes test setup harder).

## Cross-language

- **Early returns** over deep `if` / `else` nesting.
- **No nested ternaries.** Extract to a function or use `if`/`else`.
- **Avoid `else` after `return`.** The `else` is redundant noise.
- **One purpose per function.** If naming requires "and," split it.
- **No commented-out code in commits.** Delete it; git remembers.
