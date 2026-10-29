---
description: Read-only cross-artifact consistency and quality analysis
---

**Usage**: `/speckit.analyze [spec="..."] [plan="..."] [tasks="..."] [current_state="docs/ba/<module>/99-facts.json"] [mode="pre|post-implementation"] [base_ref="main"] [test_report="path/to/report"]`

> All examples below are format templates — generate real content as normal Markdown without the example indentation.

1. **Artifact resolution** — explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`) → single-candidate discovery → structured missing-input error; never guess with multiple candidates.
2. **STRICTLY READ-ONLY** — Do not modify any files. Output a structured Markdown report only.
3. Build the traceability matrix in BOTH directions:
   - Forward: Spec AC/NFR → Plan milestone → Tasks (coverage).
   - Backward: Task → Plan decision → AC/NFR or `TR-###` approved technical requirement → changed `BR-###` when applicable (reached via its AC; tasks must not cover a `BR-###` directly unless the plan explicitly allows it). Detects invented tasks and scope creep.
4. **Semantic drift check** — a link is not proof of behavior. For each AC→task mapping, verify the task and its tests preserve: actors, preconditions, business action, expected outcome, limits and thresholds, error paths, security constraints, timing requirements. Flag partial implementations (e.g., AC-008 requires deletion within 30 days; the task only adds the delete endpoint).
5. Validate NFR coverage by stable ID (`NFR-SEC-###`, `NFR-PERF-###`, `NFR-AVL-###`, `NFR-PRV-###`, `NFR-OPS-###`) across plan and tasks.
6. **Estimate/phase consistency**: large task marked `[P]` without decomposition; high-risk task with `S` estimate; task depending on a later phase or a later task ID; user-story task placed before its foundational dependency; polish task required for a Must AC.
7. **Constitution alignment** — Load `/memory/constitution.md` if it exists in the target project and flag MUST-principle violations as **CRITICAL**. Skip gracefully if absent.
8. **Documentation evidence** (when `current_state` resolves to a BA fact base): current business rule → new requirement; existing journey → changed journey; existing interface → planned change; rules marked unchanged → no task contradicts them. Contradicting an unchanged security, privacy, regulatory, or constitution-level rule is **CRITICAL**; any other unchanged-rule contradiction is **HIGH**.
9. Detect gaps against the shared mandatory-field contract (the exact fields `/speckit.tasks` promises to emit — `Depends on`, `Covers`, `Capability`, `Estimate`, `Risk`, `Standards`, `Validate`, `Done when`, `Evidence`), plus orphan ACs/tasks, circular or missing `Depends on`, unclear risks, and ambiguous glossary.
10. **Severity assignment** — Classify each finding:
    - **CRITICAL**: Constitution MUST violation, missing core artifact, or zero-coverage Must requirement blocking baseline functionality.
    - **HIGH**: Duplicate/conflicting requirement, ambiguous security/performance attribute, untestable acceptance criterion, semantic drift on a Must AC, unchanged-rule contradiction (CRITICAL when the unchanged rule is security/privacy/regulatory/constitution-level — see Documentation evidence above).
    - **MEDIUM**: Terminology drift, missing non-functional task coverage, underspecified edge case.
    - **LOW**: Style/wording improvements, minor redundancy.
11. **Evidence format** — use this structure for every finding:

    ### HIGH-003: AC-014 has no rejection-path test task

    - Specification: `spec.md#AC-014`
    - Plan: `plan.md#M3`
    - Tasks: `tasks.md#T021`
    - Problem: T021 implements the success path only.
    - Impact: Unauthorized state transitions may not be verified.
    - Recommended fix: Add a test task covering unauthorized and invalid-state requests.
    - Follow-up: `/speckit.tasks`

12. **Verdict** (required, at the end of the report; mutually exclusive):
    - **BLOCKED** — one or more CRITICAL findings. Missing core artifacts and zero-coverage Must requirements always generate CRITICAL findings.
    - **PASS_WITH_WARNINGS** — no CRITICAL findings; one or more HIGH or MEDIUM findings.
    - **PASS** — no CRITICAL, HIGH, or MEDIUM findings; all Must requirements have complete semantic and task coverage. LOW findings may remain under PASS.

End the report with this machine-readable summary:

    ## Analysis Result

    - Verdict: PASS_WITH_WARNINGS
    - Critical findings: 0
    - High findings: 2
    - Medium findings: 3
    - Low findings: 1
    - Complete requirements: 14
    - Partial requirements: 2
    - Missing requirements: 0
    - Conflicting requirements: 0
    - Unverifiable requirements: 1

13. Produce a concise report (max 50 findings; summarize overflow) with prioritized fixes and suggested follow-up commands (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks` for malformed or incomplete specification findings). Represent semantic coverage per requirement with the statuses `COMPLETE | PARTIAL | MISSING | CONFLICTING | UNVERIFIABLE`.
    In `mode="post-implementation"`: inspect four change categories separately — (1) committed feature changes (`base_ref...HEAD`), (2) staged changes, (3) unstaged changes, (4) relevant untracked files — and compare them to completed tasks; do not assume uncommitted files belong to the selected feature. Inspect cited evidence paths and read `test_report` when supplied. A checked `[X]` box is not proof by itself. Verify completed tasks against their `Done when` and `Evidence` fields, honoring the expectation contract: a task whose `Validate` declares `Expected result: FAIL` is complete when the observed failure matches the expected failing test and reason (`Matched expectation: Yes`) — an intentional red test is not an automatic failure.
    When `test_report` is absent: inspect task `Evidence` fields and available test-result artifacts; never execute tests (analysis is strictly read-only); mark a claimed test result unverifiable when no durable evidence exists — **HIGH** for unverifiable Must-AC completion, **MEDIUM** for other unverifiable test claims.
    When `base_ref` cannot be resolved: do not guess another branch; continue inspecting staged, unstaged, and relevant untracked files; mark committed-change inspection `UNVERIFIABLE`; return at least PASS_WITH_WARNINGS — BLOCKED when committed evidence is required for a Must requirement.

Traceability table format:

    | Requirement | Milestone | Tasks | Semantic status | Evidence |
    |---|---|---|---|---|
    | AC-008 | M3 | T021, T022 | PARTIAL | Timing limit not covered |

14. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
