---
description: Generate unit tests from a spec or task, linked to acceptance criteria
---

**Usage**: `/speckit.test-generate file="path/to/file" [spec="docs/specs/<feature>.md"] [ac="AC-1,AC-2"]`

1. Read the target file to identify the class, function, or module under test.
2. If a `spec` path is provided, load acceptance criteria (ACs) and business rules as test intent.
3. If `ac` IDs are provided, scope tests to only those acceptance criteria; otherwise cover all ACs found.
4. Identify the technology from the file extension and choose the correct framework:
   - JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
5. Apply AAA pattern (Arrange, Act, Assert). Name tests: `should<Behavior>_when<Condition>`.
6. For each AC, generate at minimum: happy path, edge case, and error/boundary path.
7. Use mocks/spies only for external dependencies — test real behavior wherever possible.
8. Annotate each test or describe block with a comment referencing its AC ID (e.g., `// AC-2`).
9. Output the complete, ready-to-save test file.

Follow-ups:
- Run `/speckit.validate` to confirm test coverage aligns with spec ACs.
- Run `/review` or the relevant tech-review command on the generated test file.
