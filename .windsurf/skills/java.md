# Java 21+ Skill

## Key Principles
- **Target Java 21 LTS minimum**: Use latest features.
- **Null Safety**: Return `Optional<T>` from public methods; never return `null`.
- **Immutability**: Use `record` for DTOs; mark fields `final`.
- **Exception Handling**: Catch specific exceptions; never swallow; include original cause.
- **Modern Concurrency**: Use virtual threads for I/O-bound tasks.

## Guidelines

### Core Language
- **Records**: Use `record` for pure data carriers and value objects.
- **Sealed Classes**: Use `sealed` to restrict type hierarchies.
- **Pattern Matching**: Use pattern matching in `switch` and `instanceof`.
- **java.time**: Always use `java.time` (e.g., `LocalDate`, `Instant`). Never use `Date` or `Calendar`.
- **var**: Use `var` for obvious local variable types.

### Code Style
- **Constructor Injection**: Use constructor injection only. Dependencies must be `final`.
- **Strings**: Use `StringBuilder` for concatenation in loops. Use text blocks for multi-line strings.
- **Guard Clauses**: Use early returns instead of nested `if` blocks.
- **Method/Class Size**: Max method size ~20 lines; max class size ~300 lines.

### Exception Handling & Resource Management
- Use **try-with-resources** for all `Closeable` resources.
- Catch specific exceptions only; never catch `Exception` or `Throwable` at broad scopes.
- Never swallow exceptions silently. Log or rethrow with context.

## Checklist
- [ ] Is it using Java 21+ features where appropriate?
- [ ] Are fields marked `final` where they don't change?
- [ ] Is `Optional<T>` used for methods that can return "no value"?
- [ ] Is `record` used for DTOs?
- [ ] Are virtual threads used for I/O-bound concurrency?
- [ ] Does it avoid deprecated `Date`/`Calendar` in favor of `java.time`?
