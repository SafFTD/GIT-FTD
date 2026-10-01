# Anti-Patterns

Patterns we explicitly avoid in this codebase, with reasoning. Read by `frontend`, `backend`, `reviewer`. Grows when a reviewer flags a pattern more than once.

## Format

```markdown
## A<N>: <Short name>

**Looks like:**
```<lang>
// the pattern we're rejecting
```

**Why it's bad:** <1–3 sentences>
**Do this instead:**
```<lang>
// the preferred shape
```
**Exceptions:** <when (if ever) the anti-pattern is the right call>
```

## Entries

### A1: Catching exceptions only to log and re-raise

**Looks like:**
```python
try:
    do_thing()
except Exception as e:
    logger.error(f"do_thing failed: {e}")
    raise
```

**Why it's bad:** Adds noise without adding information — the exception itself carries the traceback. Logging at every layer creates duplicate log entries and makes the root cause harder to find, not easier.

**Do this instead:** Catch only when you can handle, transform, or genuinely enrich the exception. Otherwise let it propagate. Centralize logging at the system boundary (the request handler / job runner).

```python
# At the boundary:
@app.exception_handler(Exception)
async def unhandled(_, exc):
    logger.exception("Unhandled error")
    return JSONResponse({"error": "internal"}, status_code=500)
```

**Exceptions:** Wrapping with `raise NewError("more context") from e` is fine — that's adding information.

### A2: `useEffect` for derived state

**Looks like:**
```ts
const [filtered, setFiltered] = useState<Item[]>([]);
useEffect(() => {
  setFiltered(items.filter(i => i.active));
}, [items]);
```

**Why it's bad:** `filtered` is derivable from `items` — it's not state, it's a computation. The effect creates a render → effect → render cycle, plus a stale-state window between renders.

**Do this instead:**
```ts
const filtered = useMemo(() => items.filter(i => i.active), [items]);
```

Or for trivial computations, just compute inline:
```ts
const filtered = items.filter(i => i.active);
```

**Exceptions:** None — there's no case where this anti-pattern is right.
