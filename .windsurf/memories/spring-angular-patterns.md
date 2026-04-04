# Spring Boot & Angular Patterns

## Spring Boot (Java 21+ LTS)

### Layered Architecture
```
Controller  (@RestController)  — HTTP in/out, no business logic
Service     (@Service)         — business logic, @Transactional here
Repository  (@Repository)      — data access, JPA/SQL queries
Domain                         — entities, value objects
DTO (records)                  — request/response objects (not entities)
```

### Key Rules
- `@Transactional` on service layer only; `readOnly=true` for reads
- `@Valid` on `@RequestBody` + Bean Validation on DTOs
- `@RestControllerAdvice` for global exception → consistent error response
- Never return JPA entity from controller — use DTO (record)
- `FetchType.LAZY` on all JPA relations; use `@EntityGraph` for intentional eager load
- Lombok: `@RequiredArgsConstructor`, `@Getter`, `@Slf4j` — avoid `@Data` on entities
- Error response shape: `{ "error": "CODE", "message": "...", "timestamp": "...", "path": "..." }`
- API versioning: `/api/v1/...` path-based
- Database migrations via Flyway — never modify applied migrations
- Virtual threads: `spring.threads.virtual.enabled=true`

### Spring Security
- Stateless JWT preferred for REST APIs
- CORS configured in `SecurityFilterChain`, not `@CrossOrigin`
- Never log passwords, tokens, or PII

## Angular (20+)

### Component Rules
- Standalone components only (NgModules deprecated)
- `ChangeDetectionStrategy.OnPush` on every component
- `inject()` function for all DI (not constructor params)
- Consider zoneless change detection for new apps

### Signals (Primary Reactivity Model)
- `signal()` for local mutable state
- `computed()` for derived values (pure, no side effects)
- `effect()` for side effects ONLY (DOM, logging, analytics)
- `toSignal()` to bridge Observables to Signals
- `resource()` API for declarative async data loading
- Anti-patterns: do NOT use `effect()` to derive state or set other signals

### Signal Inputs/Outputs
- `input.required<T>()` / `input<T>(default)` — replaces `@Input()`
- `output<T>()` — replaces `@Output() + EventEmitter`
- `viewChild()` / `contentChildren()` — replaces `@ViewChild` / `@ContentChild`

### Templates
- `@if` / `@for` / `@switch` / `@defer` — `*ngIf`/`*ngFor` are deprecated
- `@for` must have `track` by unique ID
- `@defer (on viewport)` for lazy loading heavy components

### Observables & Subscriptions
- `async` pipe in templates — no manual subscribe/unsubscribe when possible
- Manual subscriptions: `takeUntilDestroyed(this.destroyRef)`
- Chain operators instead of nesting `subscribe()`
- `switchMap` = cancel previous | `mergeMap` = parallel | `concatMap` = sequential | `exhaustMap` = ignore while busy

### HTTP Services
```typescript
getUsers(): Observable<User[]> {
  return this.http.get<User[]>('/api/v1/users').pipe(
    catchError(this.handleError)
  );
}
```
- Type every HTTP call
- Handle errors in service, expose clean Observable/Signal to component
- `shareReplay(1)` for cacheable data shared across components
- Consider `resource()` API as alternative to manual HTTP patterns

### Auth & Session
- JWT in `httpOnly` cookies (preferred) or `localStorage`
- Interceptor for 401 → transparent token refresh
- Route guards for protected pages
- Clear all auth state on logout
