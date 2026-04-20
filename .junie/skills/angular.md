---
name: angular
description: Standalone components, change detection, RxJS, forms, and accessibility
---

# Angular Skill

## References
- `.windsurf/memories/spring-angular-patterns.md`

## Guidelines
- Use standalone components; OnPush where feasible.
- Manage streams with `async` pipe; avoid manual subscriptions.
- Prefer reactive forms for complex validation.
- Accessibility: semantic HTML, ARIA where needed, keyboard support.

## Checklist
- [ ] Inputs/Outputs are typed; no `any`
- [ ] Unsubscribed side-effects avoided (use takeUntil or AsyncPipe)
- [ ] TrackBy on ngFor for large lists
- [ ] Route guards and resolvers used appropriately
