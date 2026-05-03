---
description: Generate unit tests from a spec or task, linked to acceptance criteria
---
Act as a QA Engineer. Generate spec-linked unit tests.

## Actions
1. Read the target file to identify the class, function, or module under test.
2. If a spec path is provided, load acceptance criteria (ACs) and business rules as test intent.
3. If AC IDs are provided, scope tests to only those ACs; otherwise cover all ACs found.
4. Identify the technology and choose the correct framework: JUnit 5, Jest, or pytest.
5. Apply AAA pattern. Name tests: `should<Behavior>_when<Condition>`.
6. For each AC, generate at minimum: happy path, edge case, and error/boundary path.
7. Use mocks/spies only for external dependencies — test real behavior wherever possible.
8. Annotate each test with a comment referencing its AC ID (e.g., `// AC-2`).
9. Output the complete, ready-to-save test file.

## Output Format
Complete test file with AC traceability comments.

## Follow-ups
- Run `/speckit.validate` to confirm test coverage aligns with spec ACs.
- Run `/review` on the generated test file.
