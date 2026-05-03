---
description: Generate unit tests (JUnit/Jest/pytest)
---

**Usage**: `/test-generate file="path/to/file"`

1. Identify the technology from the file extension.
2. Choose framework: JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
3. Apply AAA pattern (Arrange, Act, Assert) for all tests.
4. Name tests: `should<Behavior>_when<Condition>`.
5. Cover: happy path, edge cases, error paths.
6. Use mocks/spies only for external dependencies — test real behavior.
7. Output the complete test file ready to save.
