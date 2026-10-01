# Naming Conventions

Idiomatic per language — what a native reader of each expects. Read by `frontend`, `backend`, `reviewer`. Don't override per-language idioms for cross-language consistency; it makes every language look alien.

## Python

- Functions / variables: `snake_case`
- Classes: `PascalCase`
- Constants / module-level immutables: `SCREAMING_SNAKE_CASE`
- Private / internal: leading underscore (`_helper`, `_internal_state`)
- Module files: `snake_case.py`

## TypeScript / JavaScript

- Variables / functions: `camelCase`
- React components: `PascalCase` (file: `MyComponent.tsx`)
- Types / interfaces / classes: `PascalCase`
- Enums: `PascalCase` for the enum name; `PascalCase` or `SCREAMING_SNAKE_CASE` for members (pick one per file and stay consistent)
- Constants: `SCREAMING_SNAKE_CASE` for true module-level constants; `camelCase` for derived/computed
- Hooks: must start with `use` (`useUser`, `useAuth`) — React rule
- File names: `kebab-case.ts` for utility modules, `PascalCase.tsx` for components

## Go

- Exported (public, package-cross): `PascalCase`
- Unexported (package-private): `camelCase`
- Initialisms keep their case: `HTTPClient` (not `HttpClient`), `userID` (not `userId`) when unexported
- Receivers: short (1–2 letters), consistent across all methods of the same type (`u *User` everywhere, never mix with `user *User`)
- Errors named `err` and returned last
- File names: `snake_case.go`

## Booleans (all languages)

Prefix with `is`, `has`, `should`, `can`: `isActive`, `hasError`, `shouldRetry`, `canEdit`. Avoid bare nouns like `active` for booleans — ambiguous as to whether they're flags or state.

## API and DB

- API URL paths: `kebab-case` (`/api/payment-cards`).
- API JSON keys: `snake_case` (matches Python natural, easy to map for TS).
- DB tables / columns: `snake_case` plural for tables (`payment_cards`), `snake_case` singular for columns.

## Common stem reuse

If a concept appears in multiple layers, use the same stem with appropriate casing:
- DB: `payment_card`
- Python: `PaymentCard` (class), `payment_card` (var)
- TS type: `PaymentCard`
- TS var: `paymentCard`
- URL: `payment-cards`
