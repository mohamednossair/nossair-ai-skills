---
description: Review TypeScript or Angular code for type safety, patterns, and best practices
---
Review the provided TypeScript / Angular code. Include specific fixes.

## Type Safety
- `any` usage → replace with proper types or `unknown`
- Missing return types on public functions
- Unsafe type assertions (`as Type`) without guards
- `null` / `undefined` not handled (optional chaining, nullish coalescing)

## Angular 20+ (if applicable)
- `ChangeDetectionStrategy.OnPush` missing on components
- Must use `inject()` function for DI (not constructor params)
- Signal-based inputs: `input.required<T>()` instead of `@Input()`
- Signal-based outputs: `output<T>()` instead of `@Output()`
- Subscriptions not cleaned up → suggest `takeUntilDestroyed()` or `async` pipe
- HTTP calls not typed: `this.http.get<ResponseType>(...)`
- Signals: `signal()`, `computed()`, `toSignal()` — primary reactivity model
- `resource()` API for async data loading
- `@if`/`@for`/`@switch`/`@defer` — flag deprecated `*ngIf`/`*ngFor`

## RxJS Patterns (if applicable)
- Nested `subscribe()` calls → refactor with `switchMap`/`mergeMap`
- Wrong higher-order operator: `switchMap` (cancel prev), `mergeMap` (parallel), `concatMap` (sequential), `exhaustMap` (ignore while busy)
- Missing `catchError` on HTTP streams
- `shareReplay(1)` missing on shared HTTP observables

## Code Quality
- `interface` for shapes, `type` for unions/intersections
- `const enum` or `as const` objects instead of mutable enums
- Async functions that never `await` anything
- Missing `readonly` on properties that don't change

**Output format:** [CRITICAL] | [WARNING] | [SUGGESTION] — with file/line refs and corrected code.
