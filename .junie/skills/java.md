---
name: java
description: Java coding standards, error handling, collections, and immutability
---

# Java Skill

## References
- `.windsurf/memories/coding-standards.md`
- `.windsurf/memories/testing-standards.md`

## Guidelines
- Prefer immutability; use `record`/final fields when possible.
- Use Optional for truly optional returns; avoid it in fields/params.
- Validate public inputs; throw meaningful exceptions.
- Use SLF4J logging with parameterized messages; no string concat.
- Choose collections by access patterns; avoid premature streams overuse.

## Checklist
- [ ] Null-safety and boundary checks
- [ ] Logging levels consistent, no sensitive data
- [ ] Equals/hashCode/toString for value types
- [ ] Unit tests with JUnit; parameterized where helpful
