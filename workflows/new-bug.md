# Workflow: new-bug

> Neutral procedure for running a full bug lifecycle end-to-end. Surfaced as `/new-bug` in Claude and the `new-bug` workflow in Antigravity.

This workflow chains together the entire bug lifecycle: Plan -> Implement -> Test -> Review -> Ship.
At the end of each phase, you must pause and ask the user explicitly: "Should I continue to the next phase?" before proceeding.

## Phase 1: Plan
Run the procedure defined in `workflows/plan.md`, but specifically bypass Step 1 (Detect feature vs bug) since we know this is a **Bug**.
- Discuss the bug and ask all clarifying questions to the user.
- Come up with Acceptance Criteria (ACs) and reproduction steps.
- **Conditional Documentation:** Ask the user if this bug should be documented.
  - If YES: create the `bugs/B<N>-<slug>.md` doc.
  - If NO: skip creating the markdown file, but keep the agreed plan in context.
- Pause and ask: "Plan phase complete. Should I continue to Implement?"

## Phase 2: Implement
Run the procedure defined in `workflows/implement.md`.
- Pause and ask: "Implement phase complete. Should I continue to Test?"

## Phase 3: Test
Run the procedure defined in `workflows/test.md`.
- Pause and ask: "Test phase complete. Should I continue to Review?"

## Phase 4: Review
Run the procedure defined in `workflows/review.md`.
- Pause and ask: "Review phase complete. Should I continue to Ship?"

## Phase 5: Ship
Run the procedure defined in `workflows/ship.md`.
