---
description: Core engineering principles and cross-cutting review checklist
---

**Usage**: Apply to any language when reviewing or writing code.

1. Keep changes small, cohesive, and reversible.
2. Prefer pure, testable units; inject dependencies.
3. Fail fast with clear errors; validate inputs.
4. Secure by default; least privilege; avoid secrets in code.

## Checklist
- [ ] Correctness: invariants, null/edge cases, error handling
- [ ] Security: input validation, authz/authn, secrets, logging PII
- [ ] Performance: hot paths, allocations, I/O, N+1 queries
- [ ] Readability: names, small functions, comments only when needed
- [ ] Testing: unit coverage for branches, reliable tests, fixtures

## References
- `.windsurf/memories/coding-standards.md`
- `.windsurf/memories/testing-standards.md`
- `.windsurf/memories/tech-stack.md`
- `.windsurf/memories/spring-angular-patterns.md`
