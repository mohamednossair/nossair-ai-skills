# Coding Standards

## Java (21+ LTS)
- Constructor injection only (never `@Autowired` on fields); declare deps `final`
- Return `Optional<T>` instead of `null` from public methods
- `record` for DTOs/value objects; `sealed` classes for restricted hierarchies
- Pattern matching in `switch` and `instanceof`
- Virtual threads for I/O-bound concurrency
- `java.time` only — no `Date`, `Calendar`, `SimpleDateFormat`
- `StringBuilder` in loops, not string `+`
- Try-with-resources for all `Closeable` resources
- Catch specific exceptions; include original cause in rethrows

## TypeScript
- `strict: true` in tsconfig — no `any`, use `unknown` with narrowing
- Explicit return types on public API functions
- `interface` for object shapes; `type` for unions/intersections
- Named exports preferred over default exports
- Optional chaining (`?.`) and nullish coalescing (`??`) for null handling
- `Promise.allSettled()` for partial success; `Promise.all()` for fail-fast

## Python
- Type hints on all function signatures (including return types)
- 4-space indent, 88-char line max (Black standard)
- Specific `except` clauses — no bare `except:`
- `with` statement for file/DB resources
- f-strings for formatting; `None` for mutable defaults
- `Protocol` for structural typing

## General Rules
- No hardcoded secrets, URLs, or env-specific values — use config/env vars
- Guard clauses (early return) over nested `if` blocks
- Methods: max ~20 lines; Classes: max ~300 lines
- No speculative abstractions — implement what's needed now
