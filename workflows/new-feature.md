# Workflow: new-feature

> Neutral procedure for running a full feature lifecycle end-to-end. Surfaced as `/new-feature` in Claude and the `new-feature` workflow in Antigravity.

This workflow chains together the entire feature lifecycle: Plan -> Implement -> Test -> Review -> Ship.
At the end of each phase, you must pause and ask the user explicitly: "Should I continue to the next phase?" before proceeding.

## Phase 1: Plan
Run the procedure defined in `workflows/plan.md`, but specifically bypass Step 1 (Detect feature vs bug) since we know this is a **Feature**.
- Discuss the feature and ask all clarifying questions to the user.
- Come up with Acceptance Criteria (ACs) and agree on them.
- **Mandatory Documentation:** You must document the feature (create the `features/F<N>-<slug>.md` doc).
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
