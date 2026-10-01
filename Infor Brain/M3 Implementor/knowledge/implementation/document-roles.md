# Document Roles — Taxonomy

> **Classification:** INTEGRATION-GENERAL / M3-GENERAL
> This file defines the standard document role taxonomy used by M3 Implementor
> to classify, discover, and relate implementation documents.

---

## Role Codes

| Code | Document Type | Phase | Purpose | Key Inputs | Key Outputs |
|---|---|---|---|---|---|
| **BRD** | Business Requirement | SCOPING | Captures what the business needs in business terms | Stakeholder interviews | Business requirements |
| **RQS** | Requirement Specification | SCOPING | Formal numbered requirements | BRD | Numbered, traceable requirements |
| **FGA** | Fit-Gap Analysis | SCOPING | Maps requirements to M3 standard capability; identifies gaps | BRD, M3 knowledge | Gap list, solution options |
| **PRD** | Process Design | DESIGN | Documents business process flow (as-is and to-be) | FGA | Process flows, swim lanes |
| **FNS** | Functional Specification | DESIGN | Describes what the system should do (not how) | FGA, PRD | Functional design, validation rules |
| **TNS** | Technical Specification | DESIGN | Describes how the system will implement the functional design | FNS | Technical design, M3 programs, APIs |
| **IFS** | Interface Specification | DESIGN | Describes the interface between systems for an integration | TNS | Message format, protocol, security |
| **MAP** | Mapping Specification | DESIGN | Field-level mapping between source and target | IFS | Transformation rules, derivations |
| **SDS** | Solution Design | DESIGN | End-to-end architecture for a complex scope | FNS, TNS | Architecture decision, component diagram |
| **CFG** | Configuration Document | BUILD | Records M3 configuration settings and parameters | SDS, FNS | Configuration values, setup instructions |
| **TST** | Test Strategy | DESIGN/BUILD | Testing approach, test types, entry/exit criteria | FNS, TNS | Test plan |
| **TCS** | Test Case | BUILD | Individual test scenarios | FNS, IFS, MAP | Test steps, expected results |
| **SIT** | SIT Evidence | SIT | Test execution results from system integration testing | TCS | Pass/fail records, defect log |
| **UAT** | UAT Evidence | UAT | Business user acceptance test results | TCS | Sign-off, business verification |
| **DPL** | Deployment Plan | DEPLOYMENT | Steps to deploy the solution to production | TNS, SIT, UAT | Deployment procedure |
| **CTR** | Cutover Plan | DEPLOYMENT | Go-live checklist and timing | DPL | Cutover checklist, rollback plan |
| **RNB** | Runbook | POST-GO-LIVE | Operational procedures for the deployed integration | DPL | SOP, monitoring procedures |
| **DCL** | Decision Log | ALL | Records implementation decisions, options, and rationale | ALL | Decision records |
| **ISS** | Issue Log | ALL | Tracks issues, owner, and resolution | ALL | Issue records |
| **CHG** | Change Request | ALL | Scope changes to agreed design | ISS, BRD | Change specification, impact |
| **EST** | Estimate | SCOPING | Effort, cost, and timeline estimate | FGA | Effort breakdown |
| **API** | API Documentation | DESIGN | API/MI reference (e.g. Infor M3 API docs) | — | API specifications |
| **VDR** | Vendor Documentation | DESIGN | Bank spec, external system spec from vendor | — | Format requirements |
| **REG** | Regulatory Documentation | DESIGN | Regulatory rules, compliance requirements | — | Regulatory requirements |

---

## Document Relationship Graph

```
BRD ──→ FGA ──→ FNS ──→ IFS ──→ MAP ──→ TCS ──→ SIT ──→ UAT ──→ DPL ──→ RNB
              │                                                     │
              └──→ TNS ──→ SDS ──→ CFG                             └──→ CTR
                    │
                    └──→ TCS (technical test cases)
```

---

## Document Gap Rules

These rules identify gaps in the document chain:

| If you have... | But are missing... | Gap type |
|---|---|---|
| BRD | FGA | REQUIREMENT-GAP |
| FGA | FNS | DESIGN-GAP |
| FNS | TNS or IFS | DESIGN-GAP |
| IFS | MAP | MAPPING-GAP |
| FNS + IFS + MAP | TCS | TEST-GAP |
| TCS | SIT evidence | TEST-GAP |
| SIT evidence | UAT sign-off | TEST-GAP |
| UAT sign-off | DPL | DEPLOYMENT-GAP |
| DPL | RNB or monitoring spec | MONITORING-GAP |
| Any integration | No owner assigned | OWNERSHIP-GAP |
| MAP | No master data validation | DATA-GAP |
| IFS | No acknowledgement design | ACKNOWLEDGEMENT-GAP |

---

## Document Identification Signals

When classifying an unknown document, look for these signals:

| Signal phrase / element | Likely role |
|---|---|
| "the business requires", "as a user I need" | BRD |
| Numbered requirements (REQ-001), "shall", "must" | RQS |
| Gap column, "standard", "gap", "workaround", fit/gap table | FGA |
| Swim lanes, "as-is process", "to-be process" | PRD |
| "Functional Specification", scope/process/rules sections | FNS |
| M3 programs, APIs, data flow, technical components | TNS |
| Message format table, field definitions, protocol, transport | IFS |
| Source field → target field table, derivation rules | MAP |
| Architecture diagram, component diagram | SDS |
| M3 parameter values, "settings", "configuration" | CFG |
| Test approach, entry criteria, exit criteria | TST |
| Pre-conditions, test steps, expected result | TCS |
| Test execution dates, pass/fail columns, defect refs | SIT or UAT |
| Deployment steps, dependencies, rollback | DPL |
| Go-live checklist, cutover timing | CTR |
| Operational procedures, monitoring commands | RNB |
| Decision ID, options considered, selected option | DCL |
| Issue ID, status, resolution | ISS |
| Change ID, impact assessment, approval | CHG |
| Effort hours, cost, timeline | EST |
| Bank technical specification, format guide | VDR |
| Regulatory requirement, compliance, jurisdiction | REG |
