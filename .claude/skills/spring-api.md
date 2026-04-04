---
description: Review or design Spring Boot REST API — controllers, services, DTOs, validation, error handling
---
Analyze the provided Spring Boot code and give actionable feedback.

## REST Design
- HTTP method semantics: GET (read), POST (create → 201), PUT (replace), PATCH (update), DELETE (→ 204)
- URL naming: plural nouns, kebab-case (`/api/order-items` not `/getOrderItems`)
- Use `ResponseEntity<T>` for explicit status codes
- DTO separation: never expose JPA entities directly in API responses

## Spring Patterns (Java 21+ LTS)
- Constructor injection only — flag any `@Autowired` on fields
- Use records for DTOs; avoid `@Data` on JPA entities
- `@Transactional` on service layer only; `readOnly=true` for reads
- `@Valid` on `@RequestBody` params + Bean Validation annotations on DTOs
- Global error handling via `@RestControllerAdvice` + `@ExceptionHandler`
- Consistent error response: `{ "error": "CODE", "message": "...", "timestamp": "...", "path": "..." }`
- API versioning: `/api/v1/...` path-based preferred
- Database migrations: Flyway or Liquibase (flag raw DDL in app code)

## JPA / Database
- `FetchType.LAZY` on relationships (flag any EAGER without justification)
- No entity loading in controller — use projections or DTOs in queries
- `@Transactional(readOnly = true)` for read-only service methods

## Configuration & Security
- No hardcoded URLs, passwords, or secrets → externalize to env vars / `application.yml`
- Use `@ConfigurationProperties` for grouped config (not scattered `@Value`)
- Input validated before processing — flag any missing validation

## Testing
- Suggest which test slice to use: `@WebMvcTest`, `@DataJpaTest`, `@SpringBootTest`
- Point out what's missing (no controller test, no exception path coverage, etc.)

**Output:** Flag issues by layer (Controller / Service / Repository / Config), with corrected code.
