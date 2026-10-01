# Message constants — defined in ONE place (non-negotiable)

> User directive (verbatim intent): *"Message constants should be defined in one place and used everywhere else properly."*

## The rule

**No user-facing or contract message string is written inline.** Error messages, validation messages, success/notification text, status labels — every message is **defined once as a named constant** and referenced by key everywhere else. A bare string literal used as a message is a bug.

```
❌ raise HTTPException(401, detail="Invalid or expired token")
✅ raise HTTPException(401, detail=Messages.AUTH_INVALID_TOKEN)
```

## Why

- **Single point of change** — fix wording once, it updates everywhere.
- **Consistency** — the same condition always speaks with the same words.
- **Multi-tenant / locale-ready** — O Pay is white-label with per-tenant locale (see [[tenant-config]]). Centralised keys are the seam where localisation/per-tenant copy plugs in later. Scattered literals make that impossible.
- **Testability** — tests assert on a constant, not a fragile copy-pasted string.

## Per repo

- **opay-backend (Python):** one central module of message constants (e.g. `app/core/messages.py`), grouped by domain. Routers/services reference it; they never inline message text.
- **opay-be-services (TS, legacy reference):** same idea — a single messages module.
- **Frontends (later):** one messages/copy module per app, key-addressed, ready to back with i18n.

## Separate concern (flagged, not folded in)

Routers currently pass raw `str(e)` (often Supabase internals) straight to clients. Centralising *our* messages is a different fix from *not leaking* internal exception text. Track that as its own cleanup — don't conflate the two.

Related: [[design-tokens]] (sibling single-source rule for styles), [[tenant-config]].
