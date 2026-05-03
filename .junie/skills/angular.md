---
name: angular
description: Standalone components, change detection, RxJS, forms, and accessibility
---

# Angular Skill

## References
- `.windsurf/memories/spring-angular-patterns.md`

## Guidelines
- Use standalone components; OnPush on all components.
- Use `inject()` function for all DI (not constructor parameters).
- Signals-first reactivity: `signal()`, `computed()`, `effect()` for side effects only, `resource()` API for async data loading.
- Signal-based inputs: `input.required<T>()`, `input<T>(default)`; Signal-based outputs: `output<T>()`.
- Template control flow: `@if`, `@for` (with `track`), `@switch`, `@defer` — never `*ngIf`/`*ngFor`.
- Manage streams with `async` pipe; avoid manual subscriptions. If needed, use `takeUntilDestroyed(this.destroyRef)`.
- Prefer reactive forms for complex validation.
- Accessibility: semantic HTML, ARIA where needed, keyboard support.

## Checklist
- [ ] Standalone component?
- [ ] OnPush change detection enabled?
- [ ] `inject()` used for all DI?
- [ ] Signals used for state and inputs/outputs?
- [ ] `@for` has `track` function?
- [ ] Deprecated directives (`*ngIf`, `*ngFor`) avoided?
- [ ] Manual subscriptions cleaned up with `takeUntilDestroyed`?
- [ ] Route guards and resolvers used appropriately
