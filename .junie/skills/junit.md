---
name: junit
description: JUnit testing patterns, parameterized tests, and fixtures
---

# JUnit Skill

## Guidelines
- Test pyramid: unit fast, integration selective.
- Use ParameterizedTest for data-driven branches.
- Isolate side effects; use temp directories/mocks.

## Checklist
- [ ] Deterministic tests; no sleeps
- [ ] Clear Arrange/Act/Assert structure
- [ ] Coverage for error paths and edge cases
