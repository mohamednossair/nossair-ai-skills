---
description: Generate dependency-ordered tasks grouped by user story
---

**Usage**: `/speckit.tasks [plan="path/to/plan.md"]`

> All examples below are format templates — generate real content as normal Markdown without the example indentation.

1. **Artifact resolution** — explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`) → single-candidate discovery → structured missing-input error; never guess with multiple candidates. If the plan does not resolve, stop and ask the user.
2. Load `plan.md` (tech stack, `## Standards`, validation approach) and `spec.md` (user stories with priorities P1, P2, P3..., `AC-###` IDs, `NFR-###` IDs).
3. Organize tasks by user story — each story becomes its own phase. Map models, services, and interfaces to the story that needs them.
4. Use the strict task contract — the first line stays checklist-parser compatible; details live in sub-bullets. Every task follows the exact structure shown in the contract-compliant example pair below. Field rules:

- Every task must contain ALL fields: `Depends on`, `Covers`, `Capability`, `Estimate`, `Risk`, `Standards`, `Validate`, `Done when`, `Evidence`. Use explicit values such as `None` or `Not applicable` rather than omitting a field; `Validate` may be `Not applicable` only for a non-behavioral task, with a reason.
- `T###` sequential task ID; `[US#]` required in user-story phases (omit for Setup, Foundational, Operational, Polish).
- `Depends on` is required when another task must be completed before this task; use `Depends on: None` for root tasks. Never omit the field.
- `Covers` mandatory for every task — never omit the field: implementation and test tasks map to at least one `AC-###`, `NFR-###`, or `TR-###` ID; setup tasks use `Covers: FEATURE-FOUNDATION` plus a one-line coverage rationale (e.g. `Coverage rationale: Feature-wide build configuration`).
- `TR-###` = approved technical requirement from the plan (e.g. a migration or backward-compatibility constraint). Never invent `TR-###` identifiers during task generation — reference only IDs that exist in `plan.md`; if a required technical constraint lacks an identifier, return BLOCKED (Task Generation Validation) and recommend updating `/speckit.plan`.
- `Capability` — required skill area (e.g. `backend`, `frontend`, `database`); never invent personal owners.
- `Validate` mandatory for behavior-changing tasks — an exact runnable command, not a description, plus the shared Validation Evidence Contract: declare `Expected result: PASS | FAIL` (default PASS; FAIL only for intentional red tests) and, when FAIL, `Expected failing test` + `Expected reason`; the completing agent records `Observed result`, `Observed failing test` / `Observed reason` (when applicable), and `Matched expectation: Yes | No` in Evidence.

5. Tests belong in the task graph, not a follow-up. For behavior-changing work: create the test task first, then the implementation task depending on it, and an integration-verification task when needed. `/speckit.test-generate` (canonical; `/test-generate` is its unlinked wrapper) may assist in writing test code during implementation, but test work must already exist in tasks.md.

Test-first completion semantics: a new test task may legitimately end with a FAILING test. Its `Done when` may mean: the new test compiles, fails for the expected missing behavior, existing unrelated tests remain passing, and the failure reason is recorded as evidence. The implementation task then makes the new test pass. Contract-compliant example pair (the exact structure every task must follow):

    - [ ] T012 [US2] Add rejection-path tests
      - Depends on: T004
      - Covers: AC-004
      - Capability: backend
      - Estimate: S
      - Risk: Medium
      - Standards: java, spring-boot
      - Validate:
        - Command: `./mvnw -Dtest=DocumentServiceTest test`
        - Expected result: FAIL
        - Expected failing test: `rejectsUnsupportedTransition`
        - Expected reason: Missing transition validation
      - Done when:
        - The new test compiles.
        - The new test fails for the expected reason.
        - Existing unrelated tests remain passing.
      - Evidence:
        - Observed result: FAIL
        - Observed failing test: `rejectsUnsupportedTransition`
        - Observed reason: Missing transition validation
        - Matched expectation: Yes

    - [ ] T013 [US2] Implement transition validation
      - Depends on: T012
      - Covers: AC-004
      - Capability: backend
      - Estimate: M
      - Risk: Medium
      - Standards: java, spring-boot
      - Validate:
        - Command: `./mvnw -Dtest=DocumentServiceTest test`
        - Expected result: PASS
      - Done when:
        - The rejection-path test passes.
        - Existing tests remain passing.
      - Evidence:
        - Passing `DocumentServiceTest`
        - Changed implementation path

6. Phase model: Setup → Foundational (blocking prerequisites) → one phase per user story in priority order → Operational (when applicable) → Polish & cross-cutting concerns. Include operational tasks when the change requires them: database migration, monitoring, logging, feature flags, rollback, data backfill, security review, performance verification, deployment configuration, documentation.
7. `[P]` validation — mark parallel ONLY after confirming all of: tasks do not modify the same file; do not generate the same artifact; neither changes an interface the other consumes; neither shares a required migration sequence. Different file paths alone are not sufficient. When `graphify-out/graph.json` exists (see the `graphify` skill), back the interface-consumer checks with `graphify affected "<symbol>"` (reverse dependency walk) and `graphify path` between the tasks' touch points; treat `EXTRACTED` edges as confirmed conflicts and `INFERRED` edges as needs-verification.
8. Keep tasks concise; avoid repeating spec/plan text.
9. **Task Generation Validation** — end with this summary; do not claim success when a Must requirement has no task coverage. The verdict is BLOCKED when any task: omits a mandatory field; references an undefined requirement (AC/NFR/TR) or dependency; sits in a circular dependency; covers a Must requirement without objective validation; uses `Expected result: FAIL` without expected failing test and reason; or lacks a validation command for behavior-changing work. Summary structure:

    ## Task Generation Validation

    - Total tasks:
    - Root tasks:
    - Parallel tasks:
    - Must ACs covered:
    - Must ACs uncovered:
    - NFRs covered:
    - NFRs uncovered:
    - Circular dependencies:
    - Missing validation commands:
    - High-risk tasks:
    - Verdict: PASS | BLOCKED

Follow-ups:
- Run `/speckit.analyze` to validate coverage, dependencies, and estimate/phase consistency before implementing.
- `/speckit.test-generate` (or `/test-generate`) assists writing test code for test tasks during implementation.
