---
description: Generate unit tests for provided code using the appropriate testing framework.
---
Generate tests for $file.
1. Identify the technology from the file extension.
2. Read the relevant skill from `.junie/skills/<tech>/SKILL.md` and guidelines in `.junie/guidelines.md`.
3. Choose the correct framework: JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
4. Apply AAA pattern (Arrange, Act, Assert) for all tests.
5. Name tests: `should<Behavior>_when<Condition>`.
6. Cover: happy path, edge cases, error paths.
7. Use mocks/spies only for external dependencies - test real behavior.
8. Output the complete test file ready to save.
