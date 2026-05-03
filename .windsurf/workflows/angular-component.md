---
description: Review Angular 20+ component — signals, change detection, lifecycle, RxJS, and template best practices
---

**Usage**: `/angular-component file="path/to/component.ts"`

## Component Design
- `ChangeDetectionStrategy.OnPush` — is it set?
- Standalone component required — flag NgModule-based
- `inject()` function required for DI (flag constructor injection)
- Component responsibility: extract business logic to services

## Signals (Primary Reactivity)
- `signal()` for local mutable state
- `computed()` for derived values — flag manual recalculation
- `effect()` for side effects ONLY — flag if used to set signals
- `resource()` API for async data loading
- Signal-based inputs: `input.required<T>()` instead of `@Input()`
- Signal-based outputs: `output<T>()` instead of `@Output()`
- `viewChild()` / `contentChildren()` instead of `@ViewChild`

## Subscriptions & Memory Leaks
- Manual `subscribe()` without cleanup → `takeUntilDestroyed()` or `async` pipe
- Can manual subscriptions be replaced with `toSignal()` or `resource()`?

## Template Quality
- `@if` / `@for` / `@switch` / `@defer` — flag deprecated `*ngIf` / `*ngFor`
- `track` in `@for` loops for performance
- Complex template expressions → `computed()` signal or pipe

## Output
Issues grouped by category with [CRITICAL] | [WARNING] | [SUGGESTION] severity and corrected code.
