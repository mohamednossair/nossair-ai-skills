---
apply: always
---

# Project Rules: AI Assistant Guidelines

Use these rules when generating or reviewing code in this project.

---

## Standards Sources

- **Technology skills**: `.junie/skills/<tech>/SKILL.md` — load the relevant one before generating or reviewing code (java, spring-boot, typescript, angular, python, maven, git, oracle, mysql, junit, jest, security, performance, accessibility, speckit, graphify, global).
- **Consolidated guidelines**: `.junie/guidelines.md`.
- **General principles**: `.junie/skills/global/SKILL.md` (SOLID, DRY, Clean Code).

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

### /review-pr [base]
1. Diff current branch against the base (default: main/master/develop)
2. Load relevant `.junie/skills/` standards per changed file
3. Per-file findings + cross-file consistency + test coverage
4. Output: [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix
5. End with Merge Recommendation: Approve / Approve with comments / Request changes

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

### Speckit Commands (/speckit.*)
For any `/speckit.<name>` invocation, read and follow `.junie/commands/speckit.<name>.md` exactly (source of truth for all agents). Available: specify, clarify, plan, tasks, validate, analyze, checklist, implement, taskstoissues, document-generate, test-generate.
- Every command starts with the prerequisite checker: `.junie/scripts/powershell/check-prerequisites.ps1 -Json` (Windows) or `.junie/scripts/bash/check-prerequisites.sh --json` (Linux/macOS).
- Artifacts live under `specs/NNN-<short-name>/` and are plain Markdown — a plan created with one AI tool can be implemented with another.

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

## Security Standards

- Validate all input server-side; never trust client input
- Deny by default — every endpoint authorized; object-level checks (no IDOR)
- `SecurityFilterChain` (not `WebSecurityConfigurerAdapter`); stateless JWT; BCrypt passwords
- `@PreAuthorize` on service methods for fine-grained authorization
- CORS restricted to known origins; generic error responses (no stack traces)
- No secrets in code/configs/logs; mask PII in logs; rate limit auth endpoints
- Angular: no unsafe `[innerHTML]`; server enforces authorization

---

## Performance Standards

- Measure first — no speculative optimization
- No N+1 queries (`@EntityGraph`, `JOIN FETCH`, DTO projections); paginate all list endpoints
- Cache with explicit TTL/eviction; virtual threads for I/O only
- Angular: OnPush, `track`, `@defer`, `computed()`; parallelize independent requests

---

## Accessibility Standards

- Semantic HTML first; every control keyboard-operable with logical Tab order
- Programmatic labels on all inputs; accessible names on icon-only buttons
- Dialogs trap and restore focus; errors announced, never color-only
- Contrast 4.5:1 (3:1 large text); respect `prefers-reduced-motion`

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
