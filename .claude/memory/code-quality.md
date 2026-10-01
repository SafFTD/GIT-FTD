# Code Quality

Rules and heuristics for code we write here. Read by `frontend`, `backend`, and `reviewer` agents.

## Function length

**Backend (Python, Go):**
- Soft target: ≤ 30 lines per function (code lines, not blank/comments).
- Hard cap: 60 lines. Anything longer requires a `# Why this is long:` comment justifying it (e.g. unavoidable orchestration, sequence of distinct stages that don't decompose cleanly).
- Reviewer flags any function above the soft target and either accepts the justification or asks for a split.

**Frontend (TypeScript / React):**
- React components: soft target ≤ 150 lines (includes JSX, which inflates the count). Hard cap 250.
- Utility / hook functions: soft target ≤ 30 lines. Hard cap 60.
- A long component usually means subcomponents or custom hooks are waiting to be extracted. Look for repeated JSX patterns, multi-purpose state, or three+ effects in one component.

## General quality heuristics

- **Prefer explicit over clever.** A working dev coming back in 6 months should grok it.
- **Early returns over deep nesting.** Three levels of `if`/`else` is a smell.
- **Pure functions where possible.** Easier to test, easier to reason about. Side effects at the edges, logic in the middle (functional-core / imperative-shell).
- **Don't catch exceptions you can't handle.** Let them propagate. A bare `except:` or `catch (e)` that swallows and ignores is almost always wrong.
- **Don't write defensive code against bugs internal code can't have.** Validate at system boundaries (user input, external APIs). Trust framework guarantees inside the system.
- **One purpose per function.** If you'd describe it as "X and Y," split it.
- **Avoid premature abstraction.** Three similar lines is fine. Wait for the fourth before extracting.

## Comments

- Default: write none. Names should tell the story.
- Write a comment when the WHY is non-obvious: a workaround, a non-trivial invariant, a constraint from a system you can't change.
- Don't explain WHAT the code does — the code does that.
- Don't reference the current task/PR — those belong in the PR description.
