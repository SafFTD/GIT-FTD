# Design tokens — styling lives in ONE place (non-negotiable)

> User directive (verbatim intent): *"Colours and typography cannot be used on the fly — all has to be in one place, defined and then used everywhere else. I'm talking about **any** of the styles, because it is multi-tenant: I should be able to change colours and typography in a plug-and-play manner."*

## The rule

**No style value is ever written inline.** Colours, typography (font family, sizes, weights, line-heights), spacing, radii, shadows, breakpoints — every visual constant — is **defined once as a named token** and referenced by name everywhere else. A literal hex colour, font name, or px value in a component/stylesheet is a bug.

```
❌ color: #C8A24B;  font-family: "Inter";  padding: 12px;
✅ color: var(--color-primary);  font: var(--font-body);  padding: var(--space-3);
```

## Why this shape (multi-tenancy)

O Pay is white-label. Theming must be **plug-and-play per tenant** — swap a tenant's colour/typography set and the whole app re-skins with zero component edits. That only works if components consume *named tokens*, never raw values. The token *values* are the only thing that varies per tenant; the token *names* are stable contract.

## Layering: base tokens → per-tenant overrides

1. **Base/default token set** — the canonical names and fallback values, defined once per consuming repo (e.g. a single `theme/tokens` module / `:root` CSS custom properties).
2. **Per-tenant overrides** — a tenant's `branding.theme_colors` and `branding.typography` (from the tenant config schema, see [[tenant-config]]) override the base values at runtime. Selecting/loading a tenant re-binds the token values; components don't change.

So the source of truth for *which* tokens exist = the base token module; the source of truth for a *tenant's* values = the tenant config schema. Both are single-source. Frontend **reads** tokens (theme provider / CSS vars); it never hardcodes and never branches on tenant id.

## Applies to every consuming repo

Backend exposes a tenant's tokens via tenant config. Each frontend (React/Next.js, later) keeps exactly one token module that maps those into CSS custom properties / a theme object, and all components reference the tokens. Same rule, per repo.

Related: [[tenant-config]] (where per-tenant values live), [[message-constants]] (sibling single-source rule for strings).
