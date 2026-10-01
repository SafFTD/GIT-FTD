# HSBC Project — Decision Log

> **Classification:** PROJECT-SPECIFIC
> **Purpose:** Record implementation decisions to prevent them from being reopened unnecessarily.
> Each decision should have a source, rationale, and status.

---

## Decision Format

```markdown
### D{NNN}: {Short title}

**Date:** [YYYY-MM-DD or UNKNOWN]
**Project:** GC-CR-26-014 / GC-CR-26-021
**Status:** [OPEN / DECIDED / SUPERSEDED]
**Owner:** [who made / who must make this decision]
**Source:** [document, meeting, email — cite specifically]

**Decision context:** [What implementation question required a decision]
**Options considered:**
- Option A: [description]
- Option B: [description]

**Selected approach:** [what was decided]
**Rationale:** [why]

**Impact:** [what this affects]
**Dependencies:** [what depends on this decision]
```

---

## Decisions

### D001: BIC field BAF4 used as primary BIC source

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from SQL evidence)
**Owner:** FTD Technical Team
**Source:** D08 SQL — `UPPER(TRIM(BAF4)) AS bic_clean` and `TRIM(BAF4) AS bic_raw`

**Decision context:** M3 CBANAC has two BIC-related fields: BAF4 and SWBI. A decision was made about which field to use as the primary BIC source for the payment integration.

**Selected approach:** BAF4 is used as the primary BIC field for validation and payment file generation. SWBI is extracted for reference comparison only.

**Rationale:** UNKNOWN — not documented from available evidence.

**Impact:** All BIC validation and payment file generation logic reads from CBANAC.BAF4. Suppliers must have the BIC populated in BAF4 (not only in SWBI) for the integration to work.

**Open:** The rationale for choosing BAF4 over SWBI should be documented. If SWBI is the standard M3 BIC field, this decision may need revisiting.

---

### D002: Address type priority — Bank Address (10) before Postal Address (1)

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from SQL evidence)
**Owner:** FTD Technical Team
**Source:** D08 SQL — `CASE WHEN CAST(ADTE AS INTEGER) = 10 THEN 1 WHEN CAST(ADTE AS INTEGER) = 1 THEN 2 END`

**Decision context:** M3 CIDADR can have multiple address types per supplier. A decision was made about which address type to use for the payment file.

**Selected approach:** Bank Address (ADTE=10) is preferred. If no bank address exists, Postal Address (ADTE=1) is used as fallback.

**Rationale:** Bank address contains bank-relevant information that may be more appropriate for payment files than a general postal address.

**Impact:** Suppliers who have a bank address entered (type 10) will have that used in the payment file. Suppliers with only a postal address (type 1) will use that. Suppliers with neither will fail validation.

---

### D003: Bank accounts with BKIN = 'INTG' only are in scope

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from SQL evidence)
**Owner:** FTD Technical Team / GCIT
**Source:** D08 SQL — `BKIN = 'INTG'`

**Decision context:** Not all supplier bank accounts in M3 should be used for the integration. A mechanism was needed to identify which bank accounts are integration-enabled.

**Selected approach:** The BKIN field value 'INTG' is used as the flag to include a bank account in integration scope.

**Rationale:** UNKNOWN — the standard M3 mechanism for integration bank account flagging.

**Impact:** Only bank accounts with BKIN = 'INTG' are included in the payment file. Bank accounts without this flag are excluded.

---

### D004: BIC branch code 'XXX' treated as invalid

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from SQL evidence)
**Owner:** UNKNOWN
**Source:** D08 SQL — `WHEN SUBSTR(B.bic_clean, 9, 3) = 'XXX' THEN 'INVALID - Dummy Branch Code (XXX)'`

**Decision context:** Some BIC codes use 'XXX' as a branch code, indicating the primary office. A decision was made whether to accept these.

**Selected approach:** BICs with 'XXX' branch code are treated as INVALID.

**Rationale:** UNKNOWN — may be a HSBC bank requirement or project quality standard. Not documented.

**Impact:** Suppliers with 'XXX' branch code BICs will be flagged as REVIEW and may be excluded from payment files.

**Open:** The rationale must be confirmed and documented. See Q010 in open-questions.

---

### D005: Company 100, Division 001 defines the integration scope

**Date:** UNKNOWN
**Project:** GC-CR-26-014
**Status:** DECIDED (inferred from SQL evidence)
**Owner:** GCIT / FTD
**Source:** D08 SQL — `CONO = 100 AND DIVI IN ('001')`

**Decision context:** The Gold Coin M3 implementation has multiple companies and divisions. A decision was made about the scope for the HSBC payment integration.

**Selected approach:** Company 100, Division 001 is the scope.

**Rationale:** UNKNOWN — this is the Gold Coin Feedmills entity scope based on business context.

**Impact:** Only AP transactions and bank accounts in Company 100 / Division 001 are included.

---

## Decisions Required (from audit)

These are decisions that appear to have been made implicitly but are not formally recorded, or decisions that need to be made:

| # | Decision needed | Priority | Owner |
|---|---|---|---|
| R001 | Confirm rationale for BAF4 vs SWBI field choice | MEDIUM | FTD |
| R002 | Confirm whether 'XXX' BIC rejection is HSBC requirement or project choice | MEDIUM | FTD / HSBC |
| R003 | Confirm whether GC-CR-26-021 is fully implemented and decisions are reflected | HIGH | FTD |
| R004 | Formally document go/no-go decision criteria for each country | MEDIUM | GCIT / FTD |
