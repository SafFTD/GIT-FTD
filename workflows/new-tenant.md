# Workflow: new-tenant

> Neutral procedure (source of truth). Surfaced as `/new-tenant` (Claude) and the `new-tenant` workflow (Antigravity).

Create a new white-label tenant in Supabase by running the interactive creator. It collects the tenant's info; every setting has a default, so it is confirm-through-easy.

## Steps
1. Run the creator:
   - Production (installed): `opay-create-tenant`
   - Dev (checkout): `cd opay-backend && uv run python scripts/create_tenant.py`
2. It collects the tenant's data — name, slug, logo, theme colours, typography, currency/locale, Supabase isolation, feature flags, pricing — showing each default; blank input accepts the default.
   - Non-interactive: add `--defaults --name "Royal Gold"`.
   - Overwrite an existing slug: `--force`. Preview without writing: `--dry-run`.
3. It validates against the canonical schema (`app/core/tenants/schema.py`) and **inserts the tenant into the Supabase `tenants` table** (service role). Requires `SUPABASE_URL` + `SUPABASE_SERVICE_ROLE_KEY`. No files are written.
4. The tenant's `theme_colors`/`typography` are the plug-and-play design-token values ([[design-tokens]]); copy plugs into per-tenant locale ([[message-constants]]).

## Standing rule — keep the creator in sync as features grow
When a tenant-schema field OR a new feature/table is added that a tenant should have default values for, ALWAYS ASK the user whether those defaults belong in the schema (`app/core/tenants/schema.py`) and the creator (`app/core/tenants/cli.py`). A `PostToolUse` hook (`TENANT_DEFAULTS_REMINDER`) fires on edits to `app/core/tenants/*.py` and `supabase/migrations/*.sql` to prompt exactly this. See `.claude/memory/tenant-config.md`.

## Membership (a user can belong to many tenants)
The many-to-many membership model and tenant-selection flow are specified but not yet implemented — see the status checklist in `.claude/memory/tenant-config.md`.
