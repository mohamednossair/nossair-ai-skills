---
name: global
description: Core engineering principles and cross-cutting review checklist
---

# Global Skill
Use for any language when reviewing or writing code.

## References
- See `.windsurf/memories/coding-standards.md`
- See `.windsurf/memories/testing-standards.md`
- See `.windsurf/memories/tech-stack.md`
- See `.windsurf/memories/spring-angular-patterns.md`

## Key Principles
- Keep changes small, cohesive, and reversible.
- Prefer pure, testable units; inject dependencies.
- Fail fast with clear errors; validate inputs.
- Secure by default; least privilege; avoid secrets in code.

## Checklist
- [ ] Correctness: invariants, null/edge cases, error handling
- [ ] Security: input validation, authz/authn, secrets, logging PII
- [ ] Performance: hot paths, allocations, I/O, N+1 queries
- [ ] Readability: names, small functions, comments only when needed
- [ ] Testing: unit coverage for branches, reliable tests, fixtures
