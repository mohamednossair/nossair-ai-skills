---
description: Review Angular 20+ component — signals, change detection, lifecycle, RxJS, and template best practices
---
Review the provided Angular component (Angular 20+). Give specific feedback with corrected code.

## Component Design
- `ChangeDetectionStrategy.OnPush` — is it set? If not, flag it
- Standalone component required — flag any NgModule-based component
- `inject()` function required for DI (flag constructor injection)
- Component responsibility: extract business logic to services
- Consider zoneless change detection for new apps

## Signals (Primary Reactivity)
- `signal()` for local mutable state
- `computed()` for derived values — flag manual recalculation
- `effect()` for side effects ONLY (logging, DOM) — flag if used to set signals
- `toSignal()` to bridge Observables where appropriate
- `resource()` API for async data loading
- Flag missed opportunities to use signals over manual subscribe patterns

## Signal Inputs & Outputs
- `input.required<T>()` instead of `@Input()` decorator — flag old `@Input()`
- `input<T>(default)` for optional inputs with defaults
- `output<T>()` instead of `@Output() + EventEmitter` — flag old pattern
- `viewChild()` / `contentChildren()` instead of `@ViewChild` / `@ContentChild`

## Subscriptions & Memory Leaks
- Manual `subscribe()` without cleanup → `takeUntilDestroyed(this.destroyRef)` or `async` pipe
- Can manual subscriptions be replaced with `toSignal()` or `resource()`?

## Template Quality
- `@if` / `@for` / `@switch` / `@defer` — flag deprecated `*ngIf` / `*ngFor`
- `track` in `@for` loops for performance
- Complex template expressions → `computed()` signal or pipe
- `@defer (on viewport)` for heavy components

## Lifecycle Hooks
- Constructor: DI only (`inject()`)
- `ngOnInit`: init logic, subscriptions
- `ngOnDestroy`: cleanup (timers, manual subscriptions)

**Output:** Issues grouped by category with [CRITICAL] | [WARNING] | [SUGGESTION] severity and corrected code.
