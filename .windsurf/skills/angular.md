# Angular 20+ Skill

## Key Principles
- **Standalone components only** — NgModules are deprecated.
- **Signals-first reactivity**: Use `signal()`, `computed()`, and the `resource()` API.
- **Change Detection**: Use `ChangeDetectionStrategy.OnPush` on all components.
- **Dependency Injection**: Use `inject()` function instead of constructor parameters.
- **Template Control Flow**: Use `@if`, `@for`, `@switch`, and `@defer` with `track` for loops.

## Guidelines

### Components
- Set `changeDetection: ChangeDetectionStrategy.OnPush` on all components.
- Declare components as `standalone: true`.
- Use `inject()` for all dependency injection.
- Components should be lean — delegate business logic to services.
- Prefer **zoneless change detection** (`provideZonelessChangeDetection()`) for new apps.

### Signals (Primary Reactivity)
- `signal(value)`: writable reactive state.
- `computed(() => ...)`: derived read-only value (pure, no side effects).
- `effect(() => ...)`: side effects ONLY (DOM, logging). Do NOT use to derive state or set other signals.
- `resource()` API: declarative async data loading.
- Signal-based inputs/outputs: `name = input.required<string>();`, `selected = output<User>();`.
- Signal-based queries: `viewChild()`, `contentChildren()`.

### RxJS Patterns
- Cleanup: `takeUntilDestroyed(this.destroyRef)` for manual subscriptions.
- Operators: `switchMap` (cancel previous), `mergeMap` (parallel), `concatMap` (sequential), `exhaustMap` (ignore while busy).
- Avoid nested `subscribe()` — chain operators instead.

### Templates
- Always use `@for` with `track` (unique ID).
- Use `@defer` for lazy-loading heavy components.
- Avoid complex expressions in templates — use `computed()` signals or pipes.

## Checklist
- [ ] Is the component standalone?
- [ ] Is `OnPush` change detection enabled?
- [ ] Is `inject()` used for all DI?
- [ ] Are signals used for state and inputs/outputs?
- [ ] Does `@for` have a `track` function?
- [ ] Are deprecated directives (`*ngIf`, `*ngFor`) avoided?
- [ ] Are manual subscriptions cleaned up with `takeUntilDestroyed`?
