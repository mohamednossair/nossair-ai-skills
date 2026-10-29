---
description: Generate spec-linked unit tests with AC traceability (canonical test generator)
---

**Usage**: `/speckit.test-generate file="path/to/source" [spec="path/to/spec.md"] [plan="path/to/plan.md"] [tasks="path/to/tasks.md"] [task="T012"] [ac="AC-004,AC-005"] [action="preview|write"] [allow_unlinked="false|true"] [run_tests="false|true"]`

Defaults: `action=preview`, `allow_unlinked=false`, `run_tests=false`.

    /speckit.test-generate
      file="path/to/source"
      [spec="..."]
      [plan="..."]
      [tasks="..."]
      [task="T012"]
      [ac="AC-004,AC-005"]
      [action="preview|write"]
      [allow_unlinked="false|true"]
      [run_tests="false|true"]

1. Read the target file to identify the class, function, or module under test.
2. **Specification resolution** — resolve the spec via the shared resolution priority (explicit `spec` parameter → `.specify/feature.json` → prerequisite script → single-candidate discovery). If no spec resolves: return BLOCKED by default and recommend `/test-generate` for non-spec-linked unit testing; permit unlinked generation only with `allow_unlinked=true` (and say so in the output). When `allow_unlinked=true` and no explicit `spec` is supplied, do NOT perform automatic specification discovery — generate unlinked tests.
3. **Task linkage (preferred path)** — resolve `tasks.md` via the shared resolution priority. Scope priority: `task` → explicit `ac` IDs → specification → plan Standards → target source.
   - If `task=` is supplied: verify the task exists and is a test task; use its `Covers`, `Validate` (command, `Expected result`, `Expected failing test`, `Expected reason`), and `Done when` fields as generation intent; do not generate tests outside the selected task's scope; report conflicts between the task and the specification as BLOCKED.
   - If tasks.md resolves but no `task=` is supplied: find candidate test tasks related to the target file; when exactly one candidate exists, select it and report the selection; when multiple candidates exist, return a structured ambiguity error listing them — do not guess.
4. **AC scoping** — never default to testing every AC in the specification. Map the target symbol to ACs using the plan, task `Covers`, code-map, and existing-test evidence; generate tests only for ACs confidently associated with the target symbol; report ambiguous mappings; return BLOCKED when no reliable target-to-AC mapping can be established. If `ac` IDs are supplied, they override the mapping — verify every requested AC ID exists in the selected specification; if any ID is missing, duplicated, deprecated without replacement, or belongs to another feature, return BLOCKED and list the invalid IDs.
5. **Test intent hierarchy** — ACs are the test intent; changed business rules (`BR-###`) are reached through their ACs. Do not test a business rule directly unless the plan or the selected task explicitly maps that rule.
6. **Framework resolution** — resolve the test framework in this priority: (1) existing repository test configuration; (2) the plan's machine-readable `## Standards` section; (3) the relevant technology `SKILL.md`; (4) command default (JUnit 5 + AssertJ for Java, Jest for TypeScript/Angular, pytest for Python) only when no project standard exists. A fallback framework may be proposed in preview mode, but write mode must not add a new testing framework or dependency unless the plan explicitly approves it; if no compatible framework is installed, return BLOCKED and recommend updating the plan or a setup task.
7. **Existing-test inspection** — before generating: discover existing tests for the target symbol; reuse existing conventions and fixtures; do not duplicate an existing behavioral test; if a test file exists, propose the minimal additions; never overwrite unrelated tests.
8. **Risk-based case selection** — for every selected AC: identify the applicable behavior dimensions (happy path, boundary, invalid input, authorization, state transition, failure/retry, concurrency, idempotency) and generate only meaningful cases; ensure at least one direct verification when unit testing is appropriate. Do not create artificial tests to satisfy a fixed count.
9. **Level reporting** — if an AC cannot be reliably proven at unit level (integration, contract, performance, accessibility, security, or UI verification is required), generate only the unit-testable cases and report the missing verification with the appropriate command or task recommendation.
10. Apply AAA pattern (Arrange, Act, Assert). Use mocks/spies only for external dependencies — test real behavior wherever possible. Follow the repository's existing test-naming convention; fall back to `should<Behavior>_when<Condition>` only when no convention exists. Annotate each test or describe block with a comment referencing its AC ID in the workflow's zero-padded format (e.g., `// Covers: AC-002`).
11. **Expected-red generation** — when the selected task declares `Expected result: FAIL`: create the expected test with the exact behavioral intent; do not weaken the assertion to make the test pass; in preview mode, report that the test is expected to fail before implementation; in write mode, do not interpret the expected red result as a generation failure; record the expected failing test and reason in the traceability summary.
12. **Mutation and execution contract** — `action=preview` (default) reads files and outputs proposed content without writing files or executing tests; `action=write` creates or updates the test file after existing-test inspection and scope checks, preserves unrelated tests, captures the original file content before modification, applies one atomic update when supported, restores the original file if the generated source structure fails validation, never truncates an existing test file, and reports every changed file. Tests are executed only when `run_tests=true` is explicitly supplied: run only the selected task's validation command, interpret the result against `Expected result` per the shared Validation Evidence Contract, and report `Observed result` and `Matched expectation`.
13. End with a test traceability summary — generate this as normal Markdown without the example indentation:

    ## Test Traceability

    ### AC-004

    - Generated test: `shouldRejectUnsupportedTransition_whenStatusIsInvalid`
    - Behavior verified: Invalid status transition is rejected.
    - Test level: Unit
    - Task: T012
    - Source file: `src/test/.../DocumentServiceTest.java`
    - Validation command: `./mvnw -Dtest=DocumentServiceTest test`

For more than one generated test under the same AC, number the tests and nest their details — generate this as normal Markdown without the example indentation:

    ### AC-004

    1. `shouldRejectUnsupportedTransition_whenStatusIsInvalid`
       - Behavior verified: Invalid status transition is rejected.
       - Test level: Unit

    2. `shouldAllowSupportedTransition_whenStatusIsValid`
       - Behavior verified: Supported status transition succeeds.
       - Test level: Unit

Follow-ups:
- Run `/speckit.analyze` (or `/speckit.validate`) to confirm test coverage aligns with spec ACs.
- Run `/review` or the relevant tech-review command on the generated test file.
