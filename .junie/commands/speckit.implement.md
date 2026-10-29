---
description: Execute the implementation plan with governance, gating, and setup verification
---

**Usage**:

    /speckit.implement
      [tasks="path/to/tasks.md"]
      [mode="plan|execute"]
      [task_ids="T012,T013"]
      [phase="Foundational"]
      [resume="true|false"]
      [checkpoint="phase|failure|none"]

**Modes** (default `plan`):
- `plan` — read-only dry run. Read artifacts and execute read-only inspection commands when necessary; output the execution runbook (phases, order, commands, checkpoints). Do not write files, change Git state, install dependencies, execute hooks, or modify application state.
- `execute` — perform the work. Requires an explicit `mode="execute"`.

**Selectors** (choose WHAT runs — never whether writes are allowed; only `mode` controls that):
- `task_ids` — comma-separated task IDs restricting the run to those tasks (dependencies are still honored).
- `phase` — restrict the run to a single phase name from `tasks.md`.
- `resume` — `true` starts at the first unchecked task within the selected scope; default `false`.
- `checkpoint` — pause behavior: `phase` (default) pauses after every phase with a status summary; `failure` continues through successful phases and pauses only on failure, scope drift, or unresolved risk; `none` continues without interactive pauses — blocking gates still always stop. `checkpoint=none` never bypasses safety gates.

## Mode Safety Invariant

When `mode=plan`:

- Do not create or switch branches.
- Do not create, edit, delete, move, stage, or commit files.
- Do not execute extension hooks.
- Do not install dependencies.
- Do not run commands that can modify application state.
- Read-only inspection commands are allowed.
- Report proposed changes in the runbook only.

When `mode=execute`:

- Apply all safety gates (checklist gate, governance context, branch verification, worktree safety, project-setup verification, standards loading, and task parsing/scope selection) before the first write or state-changing command.

1. **Artifact resolution** — apply the shared resolution priority: explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json -RequireTasks -IncludeTasks` / `.junie/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks`) → repository discovery when exactly one candidate exists → structured missing-input error. If tasks.md does not resolve, error and ask the user to run `/speckit.tasks` first.
2. **Checklist gate** — Scan `checklists/` under the feature directory. Execute mode: if any REQUIRED checklist has incomplete items, return Verdict BLOCKED — do not perform writes, report the incomplete items, and recommend the responsible command. Do not allow a normal confirmation to bypass a required checklist; only explicitly advisory/non-blocking checklist items may continue after an explicit user override. Never skip silently. Plan mode: record the checklist status in the runbook instead of prompting.
3. **Load governance context** — Read `/memory/constitution.md` if it exists in the target project and enforce MUST principles during implementation. Skip gracefully if absent.
4. **Branch verification (execute mode only)** — Run `git branch --show-current`. Branch association with the feature is proven only by: the exact branch recorded in `.specify/feature.json`; a matching issue ID; a matching feature slug; or explicit branch metadata in the feature directory — never solely because a branch is non-protected. Branch resolution priority: (1) the current branch when it is non-protected AND associated by one of those proofs; (2) the branch recorded in `.specify/feature.json`; (3) create ONE `feature/<issue-id>-<short-slug>` implementation branch (`git switch -c ...`) when on `main`, `master`, or `develop`, so implementation work never lands on a protected branch. Create at most ONE implementation branch per run; per-milestone/per-task branch suggestions are advisory only and must not trigger additional branch creation during the same execution.
5. **Worktree safety (execute mode)** — Run `git status --porcelain`. If the worktree is dirty:
   1. List the changed and untracked files.
   2. Determine whether any selected task may touch those files.
   3. Block automatically when paths overlap.
   4. Never stash, reset, discard, or overwrite existing changes.
   5. Permit continuation only when changes are non-overlapping AND the user explicitly requested continuation.
6. **Project-setup verification (execute mode only)** — Detect the tech stack from `plan.md` (and its `## Standards` section). Only create or modify an ignore file (`.gitignore`, `.dockerignore`, `.eslintignore`, `.prettierignore`, etc.) when: the selected tasks introduce or modify the relevant technology; the file is missing an essential exclusion required by generated artifacts; the proposed change is included in the selected-scope report; existing custom patterns are preserved; and the change passes unrelated-file protection. Never normalize or reorder unrelated ignore-file entries.
7. **Load standards** — Read every `.junie/skills/<tech>/SKILL.md` listed in the plan's machine-readable `## Standards` section before writing code. Do not guess additional standards.
8. **Parse tasks.md and select scope** — Extract phases (Setup, Foundational, User stories, Operational, Polish), task IDs, parallel markers `[P]`, `Depends on`, `Covers`, and `Validate` fields including the expectation contract (`Expected result: PASS | FAIL`, `Expected failing test`, `Expected reason`). Apply the `task_ids`/`phase`/`resume` selectors to compute the selected scope and report it before any execution. When `resume=true`: revalidate checked tasks inside the selected scope when their evidence is available; detect partial changes associated with the first unchecked task; do not recreate or overwrite valid partial work; report any mismatch between task status, Git changes, and evidence; block if a checked task no longer satisfies its validation command. When revalidating a completed expected-red test task (`Expected result: FAIL`) during resume: do not require the test to still fail after its dependent implementation is complete; verify its historical evidence recorded the expected failure before implementation; verify the test remains present and now passes as part of the completed behavior; mark missing or inconsistent historical evidence UNVERIFIABLE rather than automatically FAILED_VALIDATION.
9. **Execute phase-by-phase (execute mode)**:
   - Respect dependencies: sequential tasks in order.
   - Follow the task graph: test tasks before their dependent implementation tasks (TDD).
   - **Parallel `[P]` tasks** — run together ONLY when all of: dependencies are complete; expected file sets do not overlap; no shared contract, schema, generated artifact, configuration, or build input is modified; validation commands can run independently. Otherwise downgrade to sequential execution and report why.
   - File-based coordination: tasks touching the same files must run sequentially.
   - **Scope-Drift Gate** — if a task requires behavior not supported by an AC, NFR, `TR-###`, business rule, contract, or approved plan decision: do not invent the behavior, do not expand the task silently, record the finding in `implementation-findings.md` (feature directory), mark the task `BLOCKED: NEEDS_DECISION`, and continue only with independent tasks. Findings use the stable identifier `IMPL-FINDING-<task-id>-<requirement-or-hash>`; before appending, update an existing matching finding instead of duplicating it.
   - **Unrelated-file protection** — before each task, capture the changed-file baseline (`git status --porcelain`) and the expected files/modules from the task; after the task, compare new changes against the expected scope, explain every unexpected file, never run repository-wide formatting unless the task explicitly requires it, and never revert pre-existing changes. Authorized command-owned outputs — `tasks.md` status changes, `implementation-findings.md`, `execution-result.md` (if generated), and configured test reports — are exempt from the unexpected-file check but must still appear in `Files changed`.
   - **Validation-failure handling (dependency-aware)** — honor the shared Validation Evidence Contract: a nonzero exit is a task failure only when the task declares `Expected result: PASS` (or declares no expectation); when `Expected result: FAIL` is declared, the task succeeds when the observed failing test and reason match the expectation (`Matched expectation: Yes`). Record `Observed result`, `Observed failing test` / `Observed reason` (when applicable), and `Matched expectation` in the task's Evidence. After an actual failure: mark the task `FAILED_VALIDATION`; block all tasks that depend directly or transitively on it; do not mark it complete; continue only with selected tasks independent of the failed task that do not touch its changed files, contracts, schemas, configuration, generated artifacts, or build inputs; stop the run when safe independence cannot be proven.
   - Mark tasks `[X]` in `tasks.md` only after validation evidence exists (execute mode only).
   - Checkpoints: `phase` (default) pauses after every phase with a status summary; `failure` continues through successful phases and pauses only on failure, scope drift, or unresolved risk; `none` continues without interactive pauses — blocking gates (checklist, worktree, scope-drift, validation) still always stop.
10. Suggest branch strategy per milestone/task (feature/*, bugfix/*) — advisory only, consistent with repo rules.
11. For each task, propose: commit slices, test scaffolds (`/speckit.test-generate` for test tasks), and review checkpoints (`/review`).
12. Track Definition of Done and link back to AC/NFR IDs — and to changed `BR-###` rules via their ACs — for end-to-end traceability (`BR-014 → AC-006 → M2 → T017 → test evidence`).
13. Output a runbook with commands and checkpoints to execute safely (this is the entire output in `plan` mode), separating three sections so proposals are never mistaken for completed work: `## Inspections Performed` (read-only checks actually executed), `## Proposed Commands` (validation, test, and hook commands for execute mode), and `## Commands Not Executed in Plan Mode`.
14. **Extension hooks (execute mode only)** — If `.specify/extensions.yml` exists, resolve `hooks.before_implement` and `hooks.after_implement`. Display the resolved hook commands in the runbook. A failed `before_implement` hook blocks implementation; `after_implement` runs only when its configured condition is satisfied; retry a failing hook at most once; never execute a hook outside the repository without explicit authorization.
15. **Final verdict** — end every run with this report, applying precedence when multiple outcomes apply: FAILED_VALIDATION (at least one selected task had an actual validation failure) > BLOCKED (no validation failure occurred, but a blocking gate or unresolved decision prevented execution) > PARTIALLY_COMPLETED (some selected tasks completed and others were skipped or deferred without a validation failure or blocking safety gate) > COMPLETED (every selected task completed with matching evidence).

Generate it as normal Markdown without the example indentation:

    ## Execution Result

    - Verdict: COMPLETED | PARTIALLY_COMPLETED | BLOCKED | FAILED_VALIDATION
    - Selected scope:
    - Completed tasks:
    - Blocked tasks:
    - Skipped tasks:
    - Files changed:
    - Validation commands passed:
    - Validation commands failed:
    - AC coverage:
    - NFR coverage:
    - Findings:
    - Recommended next command:
