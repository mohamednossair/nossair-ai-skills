---
description: Review Java 21+ code for immutability, error handling, logging, collections, and testing
---

**Usage**: `/java-review file="path/to/File.java"`

1. **Immutability**: Use `record` and final fields.
2. **Null Safety**: Return `Optional<T>` from public methods; never return `null`.
3. **Exceptions**: Catch specific exceptions only; never swallow; include original cause.
4. **Logging**: SLF4J parameterized logging; no PII.
5. **Collections**: Choose by access patterns; avoid unnecessary streams.
6. **Java 21+**: Use virtual threads, pattern matching, sealed classes.

## Checklist
- [ ] Constructor injection only; no `@Autowired` on fields
- [ ] `record` used for DTOs and value objects
- [ ] `Optional<T>` for optional returns
- [ ] Try-with-resources for `Closeable` resources
- [ ] `java.time` instead of `Date`/`Calendar`
- [ ] JUnit 5 tests with parameterized tests where helpful

## Output
Group by severity: [Critical] | [Warning] | [Suggestion]
- **Location**: [File:line]
- **Issue**: [What is wrong]
- **Why**: [Impact]
- **Fix**: [Corrected code snippet]
