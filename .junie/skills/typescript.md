---
name: typescript
description: Strong typing, null-safety, modularity, and ESLint/TSConfig conventions
---

# TypeScript Skill

## References
- `.windsurf/memories/coding-standards.md`

## Guidelines
- Prefer explicit types and `strict` mode; avoid `any`.
- Model domain with discriminated unions and enums.
- Treat `undefined` vs `null` consistently; narrow with type guards.
- Keep modules small; avoid deep imports.

## Checklist
- [ ] No implicit `any`; generics where needed
- [ ] Exhaustive switch on unions
- [ ] Pure utils; side-effects isolated
- [ ] Tests with Jest where applicable
