# Coding Guidelines for Junie

These are the standing coding standards and preferences to follow in all work on this project.

---

## Java (21+ LTS)
- **Target Java 21 LTS minimum** — use latest LTS features
- **Constructor injection only** — never `@Autowired` on fields; declare dependencies `final`
- Return `Optional<T>` instead of `null` from public methods
- Use try-with-resources for all `Closeable` resources
- Catch specific exceptions only; never swallow silently; include original cause in rethrows
- Use `record` for DTOs and value objects (immutable, compact)
- Use sealed classes for restricted type hierarchies
- Use pattern matching in `switch` and `instanceof`
- Use virtual threads for I/O-bound concurrency (`Executors.newVirtualThreadPerTaskExecutor()`)
- Use `java.time` — never `Date`, `Calendar`, or `SimpleDateFormat`
- `StringBuilder` for string concatenation in loops — never `+`
- Mark fields `final` when they don't change after construction
- Use `var` for obvious local variable types

## TypeScript (strict mode)
- `strict: true` in `tsconfig.json` — no exceptions
- No `any` — use proper types or `unknown` with narrowing
- Explicit return types on public API functions
- Named exports preferred over default exports
- `Promise.allSettled()` for partial-success scenarios; `Promise.all()` for fail-fast

## Angular (20+)
- **Standalone components only** — NgModules are deprecated
- `ChangeDetectionStrategy.OnPush` on all components
- `inject()` function for all DI (not constructor params)
- **Signals are the primary reactivity model:**
  - `signal()` for local state, `computed()` for derived values
  - `effect()` for side effects only — never to derive state
  - `toSignal()` to bridge Observables to Signals
  - `resource()` API for declarative async data loading
- Signal-based inputs: `input.required<T>()`, `input<T>(default)`
- Signal-based outputs: `output<T>()` instead of `@Output() + EventEmitter`
- Signal-based queries: `viewChild()`, `contentChildren()`
- Template control flow: `@if`, `@for`, `@switch`, `@defer` — never `*ngIf`/`*ngFor`
- `@for` must have `track` — always track by unique ID
- Clean up subscriptions with `takeUntilDestroyed(this.destroyRef)` or `async` pipe
- Type all HTTP calls: `this.http.get<ResponseType>(...)`
- RxJS: `switchMap` (cancel), `mergeMap` (parallel), `concatMap` (sequential), `exhaustMap` (ignore while busy)
- Avoid nested `subscribe()` — chain operators instead

## Python
- Type hints on all function signatures (PEP 484)
- 4-space indentation, 88-char line limit (Black standard)
- Specific exceptions in `except` clauses — never bare `except:`
- Use `with` statement for all file I/O and database connections
- Mutable default arguments are bugs: use `None` and assign inside function
- f-strings for string formatting (not `%` or `.format()`)
- Use `Protocol` for structural typing

## Spring Boot
- Layers: `controller` (HTTP only) → `service` (business logic) → `repository` (data)
- `@Transactional` on service methods only; `readOnly = true` for read-only methods
- Validate all request bodies with `@Valid` + Bean Validation annotations
- `@RestControllerAdvice` for global exception handling — consistent error response shape
- Never expose JPA entities in API responses — always use DTOs (records)
- `FetchType.LAZY` on all JPA relationships; use `@EntityGraph` for intentional eager loading
- Lombok: use `@RequiredArgsConstructor`, `@Getter`, `@Slf4j`; avoid `@Data` on entities
- API versioning: URI path (`/api/v1/...`) preferred
- Database migrations: Flyway — never modify applied migrations
- Virtual threads: `spring.threads.virtual.enabled=true` (Spring Boot 3.2+)

## SQL (Oracle & MySQL)
- **Always use bind variables** — never concatenate user input into SQL
- `SELECT *` is forbidden in production code — list columns explicitly
- Index all foreign key columns
- Use `FETCH FIRST N ROWS ONLY` (Oracle) / `LIMIT` (MySQL) for pagination
- Schema changes via Flyway migrations only

## Git Commit Messages
- Follow Conventional Commits: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`
- Imperative mood, max 72 chars, no trailing period

## Testing
- **JUnit 5 (Java)**: AAA pattern, `@ExtendWith(MockitoExtension.class)`, AssertJ assertions
- **Jest (TypeScript/Angular)**: AAA pattern, `jest.spyOn()` for mocks, `jest.clearAllMocks()` in `beforeEach()`
- Test names: `should<behavior>_when<condition>`
- Cover: happy path + edge cases + error paths
- Test public behavior, not private methods — if a private method needs its own test, extract it
- Use Testcontainers for real database testing
- Do not write tests only for coverage — test behavior

## General
- No hardcoded secrets, URLs, or environment-specific values — externalize to config/env
- Max method size: ~20 lines; max class size: ~300 lines
- Guard clauses (early return) over nested `if` blocks
- No speculative abstractions, feature flags, or backward-compat shims
