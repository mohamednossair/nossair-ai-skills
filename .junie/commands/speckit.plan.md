---
description: Turn the spec into an outcome-oriented implementation plan
---

**Usage**: `/speckit.plan [spec="path/to/spec.md"]`

1. **Artifact resolution** — apply the shared resolution priority: explicit parameter → `.specify/feature.json` → prerequisite script (`scripts/powershell/check-prerequisites.ps1 -Json` / `scripts/bash/check-prerequisites.sh --json`) → repository discovery when exactly one candidate exists → structured missing-input error. Never guess when multiple candidates exist. If the spec does not resolve, stop and ask the user.
2. Read `/memory/constitution.md` if it exists in the target project and cross-check against the spec — flag MUST-principle violations before planning. Skip gracefully if absent. Then check the spec's `## Specification Status`: proceed freely only when it is `ready-for-planning`; if it is `draft` or lists blocking clarifications, stop and direct the user to `/speckit.clarify` first (record this as BLOCKED in the Planning Result).
3. Identify milestones (2–5), each outcome-oriented.

Use this structure for every milestone. Generate this as normal Markdown without the example indentation:

    ### M1: <Outcome>
    - Covers: <AC-### / NFR-### / TR-### IDs; include BR-### for changed existing rules>
    - Depends on: <milestone IDs or None>
    - Deliverables:
    - Risks:
    - Validation: <demo | test | doc>
    - Definition of Done:

Traceability validation: every Must AC maps to at least one milestone; every milestone maps to at least one AC, NFR, or `TR-###` approved technical requirement; every `BR-###` marked as changed in the spec's Current-State References appears in some milestone's `Covers`.

4. Map dependencies between milestones and on external teams/services; note critical path.
5. Assign required capabilities per milestone (e.g., `backend`, `frontend`, `database`, `security-review`) — capabilities are mandatory. `Suggested owner` is optional; emit it only when a real owner is known, otherwise `Unassigned` — never invent people.
6. Phase 0 — distinguish blocking clarifications from non-blocking research:
   - **Blocking clarification** (the spec's status is not `ready-for-planning`, or blocking clarifications are listed): prevent planning, return BLOCKED, direct the user to `/speckit.clarify`, and do not create planning artifacts.
   - **Non-blocking research decision**: planning may proceed — record the decision in `research.md`; return READY_WITH_WARNINGS until it is resolved when it affects later milestones.
7. Phase 1 — generate the technical artifacts when applicable (see Output artifacts): `data-model.md`, `contracts/` (API/interface specs), `quickstart.md`. `data-model.md` owns the TECHNICAL storage representation: database types, table/column names, constraints, indexes, migrations, and entity mappings. Business entities stay conceptual in `spec.md`.
8. Carry forward every `NFR-###` ID from the spec. For each NFR: describe the planned implementation approach, map it to a milestone, and define the validation method. Reserve task-level mapping for `/speckit.tasks` — task IDs do not exist yet at planning time.
   When the plan introduces technical requirements that are neither business ACs nor NFRs (e.g. migrations, backward compatibility), assign stable `TR-###` IDs and list them in a `## Technical Requirements` section.

Generate this as normal Markdown without the example indentation:

    ### TR-001: Backward-compatible API migration

    - Source: architecture decision
    - Rationale: Existing clients continue using API version 1.
    - Validation: Contract compatibility test

Reference them in milestone `Covers` lines (`AC-###, NFR-###, TR-###`). TR IDs are stable across replanning: never renumber an existing TR; mark invalidated TRs `Deprecated`; assign a new ID to replacement requirements; preserve references from milestones and tasks.

9. **Standards section (required, machine-readable for cross-agent handoff)** — Include exactly one `## Standards` section in `plan.md`, resolving technology standards ONCE for the whole chain. Downstream commands (`/speckit.tasks`, `/speckit.implement`) parse this section, so it must be exactly one `## Standards` H2 followed by one `yaml` fenced block.

Generate this as normal Markdown without the example indentation:

    ## Standards

    ```yaml
    backend:
      - java
      - spring-boot
      - maven
    frontend:
      - typescript
      - angular
    database:
      - oracle
    review:
      - security
      - performance
      - accessibility
    ```

Each entry maps to `.junie/skills/<tech>/SKILL.md` (plus `.junie/guidelines.md`). Any agent implementing this plan later must load those files first. Before completing `plan.md`, run the standards parse validation:

1. Confirm exactly one `## Standards` heading exists.
2. Confirm the next content block is valid YAML.
3. Confirm every listed skill resolves to an existing `SKILL.md`.
4. Put unresolved entries in `## Missing Standards` (name + reason) instead of writing broken paths — the Standards YAML contains only successfully resolved skills; never include unresolved entries in the machine-readable YAML block.
5. Return BLOCKED (Planning Result) if a missing standard is required for a Must requirement.

10. **Output artifacts** — Always generate `plan.md`. Generate the others only when applicable: `research.md` (clarification or research decisions exist), `data-model.md` (the feature changes business or persistence data), `contracts/` (interfaces, APIs, events, or external integrations change), `quickstart.md` (special developer setup or verification required). Never emit empty placeholder files.
11. **Planning Result** — end with this verdict.

Generate it as normal Markdown without the example indentation:

    ## Planning Result

    - Verdict: READY | READY_WITH_WARNINGS | BLOCKED
    - Specification:
    - Milestones:
    - Must ACs covered:
    - Must ACs uncovered:
    - NFRs covered:
    - Changed business rules covered:
    - Open research decisions:
    - Missing standards:
    - Generated artifacts:
    - Recommended next command:

BLOCKED when: a Must AC has no milestone; a required standard cannot be resolved; a blocking clarification remains; or a constitution MUST principle is violated. READY_WITH_WARNINGS when no blockers remain but non-critical risks or research items do. READY when all required coverage and standards checks pass.

12. Keep steps lean; avoid micro-tasks.

Follow-ups:
- Run `/speckit.tasks` to expand milestones into dependency-ordered tasks.
- Apply the `git` skill early to align on branch/commit strategy.
