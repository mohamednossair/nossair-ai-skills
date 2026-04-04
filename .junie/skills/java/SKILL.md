---
name: java
description: Review or develop Java 21+ code following modern LTS standards and best practices
---

# Java 21+ Skill

Use this skill when developing or reviewing Java 21+ code. The project targets Java 21 LTS minimum and emphasizes safety, immutability, and modern concurrency.

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
- **Sequenced Collections**: Use `SequencedCollection`, `SequencedMap` where appropriate.
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
- Domain vs. Programming Errors: Checked for domain errors, `RuntimeException` for programming errors.

## Checklist
- [ ] Is it using Java 21+ features where appropriate?
- [ ] Are fields marked `final` where they don't change?
- [ ] Is `Optional<T>` used for methods that can return "no value"?
- [ ] Is `record` used for DTOs?
- [ ] Are virtual threads used for I/O-bound concurrency?
- [ ] Does it avoid deprecated `Date`/`Calendar` in favor of `java.time`?
- [ ] Is the AAA pattern used in tests? (See JUnit skill)

## Example

### Modern Java Pattern
```java
public record UserResponse(String name, String email) {}

public class UserService {
    private final UserRepository repository;

    // Constructor injection
    public UserService(UserRepository repository) {
        this.repository = Objects.requireNonNull(repository);
    }

    public Optional<UserResponse> findUser(String id) {
        return repository.findById(id)
            .map(u -> new UserResponse(u.name(), u.email()));
    }

    public void processIoWork() {
        // Virtual threads for I/O
        try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
            executor.submit(() -> callExternalSystem());
        }
    }
}
```
