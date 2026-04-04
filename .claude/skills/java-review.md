---
description: Review Java code for quality, SOLID, null safety, exception handling, and performance
---
Review the following Java code. Be specific — include line references and corrected snippets.

## Check these areas:

**Code Quality**
- SOLID principles (flag violations)
- Naming conventions: `PascalCase` classes, `camelCase` methods/vars, `ALL_CAPS` constants
- Methods > 20 lines or classes > 300 lines → suggest extraction
- Magic numbers/strings → extract to constants
- Code duplication (DRY violations)

**Safety & Correctness**
- Null risks → suggest `Optional<T>` where applicable
- Exception handling: catch specific types only, no silent swallowing, use try-with-resources
- Resource leaks (streams, connections, files)
- Thread safety issues (if concurrent context)

**Performance**
- String concatenation in loops → `StringBuilder`
- Wrong collection type for the use case
- Unnecessary object creation
- N+1 query patterns (if JPA present)

**Modern Java (21+ LTS)**
- Virtual threads for I/O-bound concurrency
- `record` for DTOs and value objects
- Pattern matching in `switch` and `instanceof`
- Sealed classes for restricted hierarchies
- `Optional` instead of null returns
- `java.time` instead of `Date`/`Calendar`
- `var` for obvious local types

**Output format:** Group by severity — [CRITICAL] | [WARNING] | [SUGGESTION] — each with the issue, why it matters, and the fixed code.
