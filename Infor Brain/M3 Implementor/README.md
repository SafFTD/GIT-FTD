# M3 Implementor

**An AI implementation intelligence system for Infor M3 Cloud Edition (CE) implementations.**

This directory contains the complete M3 Implementor knowledge base, agent definitions, workflows, and project knowledge for the first reference implementation.

---

## What M3 Implementor is

M3 Implementor is not a generic chatbot or a documentation search engine.

It is an AI that reasons like an **experienced M3 implementation consultant** — understanding the business, the project context, the implementation lifecycle, the evidence base, and the consequences of a decision.

---

## How to start a session

1. Open a conversation with M3 Implementor (or any agent in the M3 Implementor system).
2. The agent will:
   - Read `IMPLEMENTOR.md` (identity, principles, reasoning model).
   - Read `CONTEXT.md` (active project).
   - Load project knowledge from `projects/{project-code}/`.
3. Ask your implementation question.

---

## Directory structure

```
M3 Implementor/
│
├── IMPLEMENTOR.md          ← Identity, principles, reasoning model, standard-first principle
├── CONTEXT.md              ← Active project pointer
├── README.md               ← This file
│
├── agents/                 ← Role agents (one per implementation discipline)
│   ├── m3-business-analyst.md
│   ├── m3-functional-consultant.md
│   ├── m3-technical-architect.md
│   ├── m3-integration-specialist.md
│   ├── m3-data-analyst.md
│   ├── m3-test-planner.md
│   ├── m3-reviewer.md
│   └── m3-document-classifier.md
│
├── workflows/              ← Implementation lifecycle workflows
│   ├── new-integration.md  ← Full integration lifecycle (11 steps)
│   ├── fit-gap.md          ← Fit-gap analysis
│   ├── document-discovery.md ← Classify and index project documents
│   └── remember.md         ← Promote learning to memory/knowledge
│
├── knowledge/              ← Global knowledge (M3-GENERAL / INTEGRATION-GENERAL only)
│   ├── m3/
│   │   ├── business-processes.md   ← M3 CE business process map
│   │   ├── tables.md               ← Database table reference (FPLEDG, CBANAC, CIDADR, etc.)
│   │   ├── programs.md             ← M3 program reference
│   │   ├── apis.md                 ← ION API / MI program reference
│   │   └── extensibility.md        ← H5, XD, UDF, workflow, IPA
│   ├── integrations/
│   │   ├── patterns.md             ← Outbound/inbound integration patterns
│   │   ├── iso20022.md             ← ISO 20022 pain.001 structure and BIC rules
│   │   └── anti-patterns.md        ← Integration anti-patterns
│   ├── ion/
│   │   └── architecture.md         ← ION API, BOD flows, connection points
│   ├── mec/
│   │   └── architecture.md         ← MEC file-based integration
│   └── implementation/
│       ├── lifecycle.md            ← Stages, entry/exit criteria, deliverables
│       └── document-roles.md       ← 24 document role codes, relationship graph, gap rules
│
├── projects/               ← Project-specific knowledge (isolated per project)
│   └── HSBC-ISO20022/      ← First reference implementation (GC-CR-26-014)
│       ├── PROJECT.md              ← Project identity, scope, countries, status
│       ├── documents.md            ← Document index (30 documents classified)
│       ├── integrations/
│       │   └── outbound-payment.md ← HSBC H2H outbound payment integration descriptor
│       ├── knowledge/
│       │   ├── m3-observations.md  ← M3 tables/fields observed in this project
│       │   ├── data-validation.md  ← BIC + address validation rules from SQL
│       │   └── xml-structure.md    ← pain.001.001.03 structure as implemented
│       ├── evidence/
│       │   └── sourced-facts.md    ← 13 facts with SOURCE → OBSERVATION → INFERENCE chain
│       ├── decisions/
│       │   └── decisions.md        ← 5 decisions inferred + 4 decisions pending
│       └── open-questions/
│           └── questions.md        ← 10 open questions from audit
│
├── templates/              ← Document templates for new implementations
│   ├── integration-descriptor.md   ← Template for new integration descriptors
│   └── decision-record.md          ← Template for decision log entries
│
└── memory/                 ← Cross-project learnings and patterns
    ├── lessons-learned.md          ← L1–L3 (master data, bank specs, change requests)
    ├── gotchas.md                  ← G1–G4 (BIC lowercase, empty tags, field confusion, creds)
    └── anti-patterns.md            ← A1–A4 (inference as fact, skip standard-first, etc.)
```

---

## Source document boundaries

| Directory | Access | Rule |
|---|---|---|
| `D:\GIT-FTD\Projects\GC-CR-26-014_HSBC H2H ISO 20022\` | **READ-ONLY** | Never modify, rename, delete, or move. |
| `D:\GIT-FTD\Infor Brain\M3 Implementor\` | **READ + WRITE** | This is the M3 Implementor workspace. |
| `D:\GIT-FTD\.claude\agents\` | **READ-ONLY** | O Pay agents — separate product. |
| `D:\GIT-FTD\.agent\rules\` | **READ + WRITE** | M3 Implementor AGY context rule lives here. |

---

## Agents and their responsibilities

| Agent | Primary question type |
|---|---|
| m3-business-analyst | "What does the business need?" |
| m3-functional-consultant | "Can standard M3 do this? What's the gap?" |
| m3-integration-specialist | "How should this integration be designed?" |
| m3-technical-architect | "What M3 programs and APIs? What's the field mapping?" |
| m3-data-analyst | "Is the master data ready for this integration?" |
| m3-test-planner | "How do we test this? What test cases do we need?" |
| m3-reviewer | "What's missing? What gaps exist? What's undocumented?" |
| m3-document-classifier | "What is this document? What does it cover?" |

---

## Critical principles (summary)

1. **Standard first.** Configuration → Extension → Integration → Custom. Never skip.
2. **Source everything.** SOURCE / OBSERVATION / INFERENCE / RECOMMENDATION — always distinguished.
3. **Never invent M3 details.** Unknown programs, APIs, fields → say UNKNOWN.
4. **Never contaminate.** Global knowledge ≠ project knowledge.
5. **Always identify gaps.** What exists is as important as what is missing.
