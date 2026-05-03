---
apply: always
---

# Project Rules: AI Assistant Guidelines

Use these rules when generating or reviewing code in this project.

---

## Tech Stack

- **Java 21+ LTS**: Records, sealed classes, pattern matching, virtual threads
- **TypeScript**: Strict mode, no `any`, explicit return types
- **Python**: Type hints, 4-space indent, f-strings
- **Spring Boot 3.2+**: Constructor injection, `@Transactional` on services, virtual threads enabled
- **Angular 20+**: Standalone components, signals-first, OnPush CD, `inject()` function
- **Databases**: Oracle (production), MySQL (InnoDB), Flyway migrations
- **Testing**: JUnit 5 + AssertJ, Jest, pytest

---

## Unified Commands

When the user invokes these commands, follow the instructions exactly:

### /review file="path"
1. Identify technology from file extension
2. Check against SOLID, DRY, security, performance
3. Output: [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix

### /plan task="..."
1. Break into logical steps with files to modify/create
2. Identify applicable coding standards and patterns
3. Flag risks per step
4. Output numbered plan with files, standards, Risk

### /test-generate file="path"
1. Identify technology
2. Use JUnit 5 (Java), Jest (TS/Angular), pytest (Python)
3. AAA pattern, name: `should<Behavior>_when<Condition>`
4. Cover happy path, edge cases, error paths

### /git-commit
1. Analyze changes with `git status`, `git diff`, `git branch`
2. If on main/master/develop, create work branch first
3. Conventional Commits: `type(scope): description`
4. Types: feat, fix, refactor, test, docs, chore, perf, style
5. Output commit hash and message only

---

## Java 21+ Standards

- Constructor injection only (no `@Autowired` on fields), `final` fields
- Return `Optional<T>` instead of `null` from public methods
- `record` for DTOs; `sealed` for restricted hierarchies
- Pattern matching in `switch` and `instanceof`
- Virtual threads: `Executors.newVirtualThreadPerTaskExecutor()` for I/O
- `java.time` only — never `Date`, `Calendar`
- Try-with-resources for all `Closeable`
- Catch specific exceptions only; never swallow silently

---

## Angular 20+ Standards

- Standalone components only (`standalone: true`)
- `ChangeDetectionStrategy.OnPush` on all components
- `inject()` function for DI (not constructor params)
- Signals-first: `signal()`, `computed()`, `effect()` for side effects only
- `resource()` API for async data loading
- Signal inputs: `input.required<T>()`, `input<T>(default)`
- Signal outputs: `output<T>()`
- Template control flow: `@if`, `@for` (with `track`), `@switch`, `@defer`
- Never `*ngIf`, `*ngFor`
- `takeUntilDestroyed(this.destroyRef)` for manual subscriptions

---

## Spring Boot Standards

- Layers: controller → service → repository
- `@RequiredArgsConstructor` with `final` fields
- Never expose JPA entities in API responses — use DTO records
- `@Transactional` on service layer only; `readOnly = true` for reads
- `@Valid` on all `@RequestBody`
- `@RestControllerAdvice` for global exception handling
- `FetchType.LAZY` on all JPA relationships; `@EntityGraph` for eager load
- Lombok: `@RequiredArgsConstructor`, `@Getter`, `@Slf4j` — avoid `@Data` on entities
- API versioning: `/api/v1/...`
- `spring.threads.virtual.enabled=true`

---

## SQL Standards (Oracle & MySQL)

- Always use bind variables — never concatenate user input
- `SELECT *` forbidden in production — list columns explicitly
- Index all foreign key columns
- Pagination: `FETCH FIRST N ROWS ONLY` (Oracle), `LIMIT` (MySQL)
- Schema changes via Flyway migrations only — never modify applied migrations

---

## Git Standards

- Conventional Commits: `type(scope): description`
- Types: feat, fix, refactor, test, docs, chore, perf, style
- Imperative mood, max 72 chars, no trailing period
- Branch prefixes: `feature/`, `bugfix/`, `docs/`, `chore/`
- From main/master/develop: create work branch before committing

---

## Testing Standards

- **JUnit 5**: AAA pattern, `@ExtendWith(MockitoExtension.class)`, AssertJ assertions
- **Jest**: AAA pattern, `jest.spyOn()`, `jest.clearAllMocks()` in `beforeEach()`
- Test names: `should<behavior>_when<condition>`
- Cover: happy path + edge cases + error paths
- Test public behavior, not private methods

---

## General Principles

- SOLID, DRY, Clean Code
- Guard clauses (early return) over nested `if` blocks
- Fail fast: validate inputs at function start
- Max method: ~20 lines; max class: ~300 lines
- No hardcoded secrets, URLs, or env-specific values
- No speculative abstractions
