# Global Engineering Skill

Use for any language when reviewing or writing code.

## Key Principles
- Keep changes small, cohesive, and reversible.
- Prefer pure, testable units; inject dependencies.
- Fail fast with clear errors; validate inputs.
- Secure by default; least privilege; avoid secrets in code.

## Cross-Cutting Checklist
- [ ] Correctness: invariants, null/edge cases, error handling
- [ ] Security: input validation, authz/authn, secrets, logging PII
- [ ] Performance: hot paths, allocations, I/O, N+1 queries
- [ ] Readability: names, small functions, comments only when needed
- [ ] Testing: unit coverage for branches, reliable tests, fixtures

## References
- `coding-standards.md`
- `testing-standards.md`
- `tech-stack.md`
- `spring-angular-patterns.md`
