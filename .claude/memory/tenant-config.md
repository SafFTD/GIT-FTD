# Tenant configuration & multi-tenancy (full detail)

Canonical reference for the white-label model. AGENTS.md → **Multi-tenancy** points here.
Status: **design recorded, not yet implemented** (backend-first; frontend later).

## Canonical schema — one Pydantic model

Per-tenant configuration is defined **once** as a Pydantic v2 model in
`opay-backend/app/core/tenants/schema.py`. Nothing about a tenant is configured anywhere else.

| Group | Fields | Notes |
|---|---|---|
| **Branding** | `name`, `slug`, `logo_url`, `theme_colors`, `typography` | `theme_colors` + `typography` are the per-tenant **design-token** values — see [[design-tokens]]. Plug-and-play re-skin. |
| **Currency & locale** | `currency` (default `LKR`), `locale`, `timezone` | locale is also where per-tenant message copy plugs in — see [[message-constants]]. |
| **Data isolation / Supabase** | optional per-tenant `supabase_url` + keys | `None` ⇒ **shared project + `tenant_id` isolation** (matches the current single shared client). Per-tenant project is the opt-in alternative. |
| **Feature flags & pricing** | enabled features, buy/sell spreads, minimum amounts | drives what each tenant can do and at what margins. |

## Membership model — a user can belong to MANY tenants

> User directive: *"One user can be in multiple tenants; if he belongs to multiple, he gets to select the tenant in an in-between screen."*

- **User ↔ tenant is many-to-many.** A membership join (e.g. `user_tenant_memberships`: `user_id`, `tenant_id`, role, status) — **not** a `tenant_id` column on the user.
- **Sign-in returns the user's tenants.** After auth, the backend lists the tenants the user is a member of (with enough branding to render a picker).
  - 0 tenants → onboarding / no access.
  - exactly 1 → auto-select, skip the picker.
  - more than 1 → client shows an **in-between tenant-selection screen**; user picks one.
- **The selected tenant scopes every subsequent request.** Client carries the chosen tenant (e.g. an `X-Tenant-Id` header or tenant-scoped token); a backend dependency validates the user is a member of that tenant and loads its config. Membership is re-checked server-side on every request — the picker is UX, not the security boundary.
- **Backend-first.** Build the membership + selection API now; the in-between screen is a frontend concern added later. The frontend never branches on tenant id for styling/copy — it just consumes the selected tenant's tokens ([[design-tokens]]) and messages ([[message-constants]]).

## Creating a tenant (the rule the user asked for)

> *"A script I could run to add a new tenant and all his data — with all the settings, defaulting where I don't specify."*

**On demand, into Supabase.** New tenants are created by running the interactive tool
(`opay-create-tenant` in production; `uv run python scripts/create_tenant.py` in dev; surfaced
as `/new-tenant`). It **collects the tenant's info** (name, slug, branding, currency/locale,
isolation, flags, pricing) — every field has a default (from `schema.py`), so you can press Enter
through any — validates against the schema, then **inserts the tenant into the Supabase `tenants`
table** (service role; upsert with `--force`). It writes **no JSON files**. Run modes: interactive,
`--defaults --name "X"` (no prompts), `--force` (overwrite), `--dry-run` (preview).

### Standing rule — keep the creator in sync as features grow
**When a tenant-schema field OR a new feature/table is added that a tenant should have default
values for, ALWAYS ASK the user whether those defaults belong in the tenant schema
(`app/core/tenants/schema.py`) and the creator (`app/core/tenants/cli.py`).** A `PostToolUse`
hook (`TENANT_DEFAULTS_REMINDER` in checked-in `.claude/settings.json`) fires on edits to
`app/core/tenants/*.py` and to `supabase/migrations/*.sql` to prompt exactly this. The hook only
reminds — the agent asks, the human decides.

## Implementation status

Built:
- [x] `app/core/tenants/schema.py` — canonical Pydantic config (branding incl. `theme_colors` + `typography`, currency/locale, supabase, feature flags, pricing); every field defaulted.
- [x] `app/core/tenants/cli.py` + `scripts/create_tenant.py` shim — interactive creator with defaults; installable console command `opay-create-tenant` (pyproject `[project.scripts]`).
- [x] `supabase/migrations/*_create_tenants_table.sql` — `tenants` table (config jsonb, RLS).
- [x] Creator inserts into Supabase `tenants` (service role, upsert on slug).
- [x] `TENANT_DEFAULTS_REMINDER` hook in `.claude/settings.json` (tenant schema + migrations).

Not yet (deferred product/backend work — normal `/plan → /implement`):
- [ ] `user_tenant_memberships` table + migration (many-to-many).
- [ ] Sign-in returns memberships; `GET /api/tenants` lists the current user's tenants.
- [ ] `get_current_tenant` dependency — validates membership, loads config, scopes requests.

Related: [[design-tokens]], [[message-constants]].
