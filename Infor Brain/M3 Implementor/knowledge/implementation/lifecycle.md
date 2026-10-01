# Implementation Lifecycle

> **Classification:** INTEGRATION-GENERAL / M3-GENERAL
> This file defines the standard M3 CE implementation lifecycle stages, gates,
> and expected deliverables. It is used by all M3 Implementor agents to understand
> what phase a project or feature is in and what should exist at each stage.

---

## Stages

```
SCOPING
    ↓
DESIGN
    ↓
BUILD
    ↓
SIT (System Integration Testing)
    ↓
UAT (User Acceptance Testing)
    ↓
DEPLOYMENT (Go-Live)
    ↓
POST-GO-LIVE (Stabilisation / Support)
```

---

## SCOPING

**Purpose:** Understand the business need, define scope, identify M3 capability gaps, and estimate effort.

**Key activities:**
- Business requirements gathering
- Standard M3 fit assessment (standard-first principle)
- Fit-gap analysis
- Scope definition and agreement
- High-level solution approach
- Effort estimation

**Expected deliverables:**
- Business Requirement Document (BRD)
- Fit-Gap Analysis (FGA)
- Effort Estimate (EST)
- Scope statement / Statement of Work

**Entry criteria:** Business need identified.
**Exit gate:** Scope agreed, effort approved, project initiated.

---

## DESIGN

**Purpose:** Produce detailed functional and technical designs for all in-scope items.

**Key activities:**
- Functional specification writing
- Technical specification writing
- Interface specification (for integrations)
- Field mapping design (for integrations)
- Process design
- Configuration specification
- Test strategy

**Expected deliverables:**
- Functional Specification (FNS)
- Technical Specification (TNS)
- Interface Specification (IFS)
- Mapping Specification (MAP)
- Solution Design (SDS) — if needed
- Test Strategy (TST)

**Entry criteria:** Scope agreed, business requirements documented.
**Exit gate:** Functional and technical designs approved by customer.

---

## BUILD

**Purpose:** Configure M3, develop integration components, and perform unit testing.

**Key activities:**
- M3 configuration
- Integration development (MEC/ION/IPA setup)
- Unit testing
- Developer testing
- Defect resolution
- Test case preparation

**Expected deliverables:**
- Configured M3 environment (TST)
- Integration deployed to TST
- Unit test evidence
- SIT test cases (TCS)

**Entry criteria:** Functional and technical designs approved.
**Exit gate:** Developer testing complete, SIT-ready sign-off.

---

## SIT (System Integration Testing)

**Purpose:** Verify that configured M3 and integration components work together correctly.

**Key activities:**
- Execute SIT test cases
- Verify integration data flows (outbound and inbound)
- Verify master data
- Defect logging and resolution
- Regression testing after defect fixes

**Expected deliverables:**
- SIT test execution results (SIT evidence)
- Defect log
- Regression test results
- SIT completion sign-off

**Entry criteria:** BUILD exit gate passed, test environment ready, test data prepared.
**Exit gate:** All critical/high defects resolved; SIT completion sign-off obtained.

---

## UAT (User Acceptance Testing)

**Purpose:** Business users verify that the system meets their requirements.

**Key activities:**
- Business user executes UAT test cases
- Business verification of outputs (payment files, reports, etc.)
- Defect logging by business
- Defect resolution by implementation team
- UAT completion sign-off

**Expected deliverables:**
- UAT test execution results (UAT evidence)
- Defect log (business-raised)
- UAT completion sign-off (business stakeholder)

**Entry criteria:** SIT exit gate passed.
**Exit gate:** UAT sign-off obtained from authorised business stakeholder.

---

## DEPLOYMENT

**Purpose:** Deploy the solution to the production environment.

**Key activities:**
- Production environment preparation
- Deployment execution (following deployment plan)
- Cutover activities
- Smoke testing in production
- Go-live confirmation
- Hypercare setup

**Expected deliverables:**
- Deployment Plan (DPL)
- Cutover Plan (CTR)
- Deployment completion record
- Go-live sign-off

**Entry criteria:** UAT sign-off obtained, deployment plan approved.
**Exit gate:** Go-live confirmed, hypercare active.

---

## POST-GO-LIVE

**Purpose:** Stabilise the solution, resolve production issues, and hand over to operations.

**Key activities:**
- Hypercare support (intensive support period post go-live)
- Production issue resolution
- Knowledge transfer to operations
- Runbook finalisation
- SLA / support model activation

**Expected deliverables:**
- Runbook (RNB)
- SOP documents
- Support handover
- Knowledge transfer completion

**Entry criteria:** Go-live confirmed.
**Exit gate:** Hypercare period complete, support handover accepted.

---

## Implementation Lifecycle Gap Detection

When M3 Implementor reviews a project, check for stage-appropriate deliverables:

| Stage | Must-have deliverables | Gap if missing |
|---|---|---|
| SCOPING → DESIGN | BRD, FGA | REQUIREMENT-GAP |
| DESIGN → BUILD | FNS, TNS, IFS, MAP | DESIGN-GAP, MAPPING-GAP |
| BUILD → SIT | TCS, deployed integration | TEST-GAP, DEVELOPMENT-GAP |
| SIT → UAT | SIT evidence, defect log | TEST-GAP |
| UAT → DEPLOYMENT | UAT sign-off, DPL, CTR | DEPLOYMENT-GAP |
| DEPLOYMENT → POST-GO-LIVE | RNB, SOP | MONITORING-GAP |

---

## Phase Assessment

When reviewing an integration or feature, determine which stage it is currently in by asking:

1. Does a business requirement exist? → If No: SCOPING incomplete
2. Does a functional design exist? → If No: DESIGN incomplete
3. Does a technical design exist? → If No: DESIGN incomplete
4. Has it been built/configured? → If No: BUILD not started
5. Has SIT been completed? → If No: SIT pending
6. Has UAT been completed? → If No: UAT pending
7. Has it been deployed to production? → If No: DEPLOYMENT pending
8. Is there a runbook / monitoring? → If No: MONITORING-GAP
