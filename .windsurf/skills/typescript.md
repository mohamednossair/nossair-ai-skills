# TypeScript Skill

## Key Principles
- **Strict Mode**: `strict: true` in `tsconfig.json`. No exceptions.
- **No `any`**: Use proper types or `unknown` with narrowing.
- **Explicit Returns**: Explicit return types on all public API functions.
- **Named Exports**: Prefer named exports over default exports.
- **Async Handling**: Use `Promise.allSettled()` for partial success; `Promise.all()` for fail-fast.

## Guidelines

### Types & Interface
- Prefer `interface` for object structures (extensible).
- Use `type` for unions, intersections, and primitives.
- Avoid non-null assertions (`!`). Use proper null checks or guards.
- Use `readonly` for immutable arrays and object properties.

### Async Patterns
- Use `async`/`await` instead of raw `.then()`.
- Use `Promise.allSettled()` when you need the results of all promises even if some fail.
- Catch errors in async functions with `try`/`catch`.

### Formatting & Exporting
- Named exports are mandatory for all components, services, and utils.
- Follow naming conventions: camelCase for functions/variables, PascalCase for classes/types.

## Checklist
- [ ] Is strict mode enabled?
- [ ] Are there any `any` types? (Should not be)
- [ ] Does every public function have an explicit return type?
- [ ] Are named exports used?
- [ ] Is `unknown` used instead of `any` for untrusted input?
- [ ] Is error handling present for async calls?
