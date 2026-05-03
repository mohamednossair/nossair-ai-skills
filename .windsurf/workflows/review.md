---
description: Review code using relevant tech skill and guidelines
---

**Usage**: `/review file="path/to/file"`

1. Identify the technology from the file extension.
2. Apply the relevant tech-specific section below.
3. Analyze: correctness, security, performance, readability, SOLID/DRY.
4. Output findings grouped by: [Critical] | [Warning] | [Suggestion]
   - **Location**: [File:line]
   - **Issue**: [What is wrong]
   - **Why**: [Impact]
   - **Fix**: [Corrected code]

---

## Java (.java)

### Core Language
- Immutability: `record` for DTOs, `final` fields.
- Null Safety: Return `Optional<T>` from public methods; never return `null`.
- Exceptions: Catch specific exceptions only; never swallow; include original cause.
- Logging: SLF4J parameterized logging; no PII.
- Collections: Choose by access patterns; avoid unnecessary streams.
- Java 21+: Virtual threads, pattern matching, sealed classes.
- Constructor injection only; no `@Autowired` on fields.
- `java.time` instead of `Date`/`Calendar`.
- Try-with-resources for all `Closeable`.

### Spring Boot
- REST: GET (read), POST (create → 201), PUT (replace), PATCH (update), DELETE (→ 204)
- URL naming: plural nouns, kebab-case (`/api/order-items`)
- `ResponseEntity<T>` for explicit status codes
- Never expose JPA entities — use DTO records
- `@Transactional` on service layer only; `readOnly=true` for reads
- `@Valid` on `@RequestBody` + Bean Validation on DTOs
- `@RestControllerAdvice` for global error handling
- Consistent error response: `{ "error": "CODE", "message": "..." }`
- API versioning: `/api/v1/...`
- `FetchType.LAZY` on relationships; `@EntityGraph` for eager load
- No hardcoded secrets; use `@ConfigurationProperties`

### Checklist
- [ ] Constructor injection only; `final` fields
- [ ] `record` used for DTOs and value objects
- [ ] `Optional<T>` for optional returns
- [ ] Try-with-resources for `Closeable` resources
- [ ] `java.time` instead of `Date`/`Calendar`
- [ ] `@Valid` on request bodies
- [ ] `FetchType.LAZY` on all JPA relationships
- [ ] JUnit 5 tests with parameterized tests where helpful

---

## TypeScript / Angular (.ts)

### TypeScript
- No `any` — replace with proper types or `unknown` with narrowing
- Explicit return types on public API functions
- `strict: true` in `tsconfig.json` — no exceptions
- `interface` for shapes, `type` for unions/intersections
- Named exports preferred over default exports
- Optional chaining (`?.`) and nullish coalescing (`??`) for null handling
- `const enum` or `as const` instead of mutable enums
- Async functions that never `await` — flag them

### Angular 20+
- Standalone components only — flag NgModule-based
- `ChangeDetectionStrategy.OnPush` on every component
- `inject()` function for DI — flag constructor injection
- Signals-first: `signal()`, `computed()`, `effect()` for side effects only
- `resource()` API for async data loading
- Signal-based inputs: `input.required<T>()`; outputs: `output<T>()`
- Signal-based queries: `viewChild()`, `contentChildren()`
- `@if` / `@for` (with `track`) / `@switch` / `@defer` — never `*ngIf`/`*ngFor`
- Manual subscriptions → `takeUntilDestroyed()` or `async` pipe
- Complex template expressions → `computed()` signal or pipe

### Checklist
- [ ] Standalone component?
- [ ] `OnPush` change detection enabled?
- [ ] `inject()` used for all DI?
- [ ] Signals used for state and inputs/outputs?
- [ ] `@for` has `track` function?
- [ ] Deprecated directives (`*ngIf`, `*ngFor`) avoided?
- [ ] Manual subscriptions cleaned up?

---

## Python (.py)

- Type hints on all function signatures (PEP 484)
- 4-space indentation, 88-char line limit (Black standard)
- Specific `except` clauses — no bare `except:`
- Use `with` statement for all file/DB resources
- f-strings for formatting; `None` for mutable defaults
- `Protocol` for structural typing
- Guard clauses over nested `if` blocks
- No hardcoded secrets or environment-specific values

### Checklist
- [ ] All function signatures type-hinted?
- [ ] Bare `except:` clauses avoided?
- [ ] f-strings used for formatting?
- [ ] Default arguments immutable?
- [ ] `with` statement used for I/O?

---

## SQL (.sql)

### All SQL
- No string concatenation — use bind variables
- No `SELECT *` in production — list columns explicitly
- JOIN conditions complete (no accidental cartesian product)
- NULL handling: `IS NULL` / `IS NOT NULL`, not `= NULL`
- Aggregates without GROUP BY on non-aggregate columns — flag
- Indexes on WHERE, JOIN, and ORDER BY columns
- Avoid functions on indexed columns in WHERE clauses
- `EXISTS` vs `IN`: prefer `EXISTS` for large subquery results

### Oracle-Specific
- Bind variables: `:param` syntax
- `FETCH FIRST N ROWS ONLY` for pagination
- `VARCHAR2` (not `VARCHAR`) for character strings
- `MERGE` for upsert operations
- Sequences + `NEXTVAL` for ID generation

### MySQL-Specific
- `LIMIT` for pagination
- `InnoDB` storage engine
- `utf8mb4` charset for all text columns
- Use `EXPLAIN` to analyze query performance

### Checklist
- [ ] Bind variables used consistently?
- [ ] `SELECT *` avoided?
- [ ] All foreign keys indexed?
- [ ] Pagination used?

---

## Git (branches, commits, messages)

- Branch prefixes: `feature/`, `bugfix/`, `docs/`, `chore/`
- Conventional Commits: `type(scope): description`
- Types: feat, fix, refactor, test, docs, chore, perf, style
- Imperative mood, max 72 chars, no trailing period
- Atomic commits; one logical change per commit
- Clean history: rebase or merge as per project policy

## General Cross-Cutting

- SOLID, DRY, Clean Code
- Guard clauses (early return) over nested `if` blocks
- Fail fast: validate inputs at function start
- Max method: ~20 lines; max class: ~300 lines
- No hardcoded secrets, URLs, or env-specific values
- No speculative abstractions
