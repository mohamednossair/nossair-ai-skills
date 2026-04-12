---
description: Generate unit tests (JUnit/Jest/pytest)
---

**Usage**: `/test-generate file="path/to/file"`

1. Identify the technology from the file extension.
2. Choose framework: JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
3. Apply AAA pattern. Name tests: `should<Behavior>_when<Condition>`.
4. Cover: happy path, edge cases, error paths.
5. Output the complete test file.
