---
description: Review Spring Boot REST API — controllers, services, DTOs, validation, error handling
---

**Usage**: `/spring-api file="path/to/Controller.java"`

## REST Design
- HTTP methods: GET (read), POST (create → 201), PUT (replace), PATCH (update), DELETE (→ 204)
- URL naming: plural nouns, kebab-case (`/api/order-items`)
- Use `ResponseEntity<T>` for explicit status codes
- DTO separation: never expose JPA entities directly

## Spring Patterns (Java 21+ LTS)
- Constructor injection only — flag `@Autowired` on fields
- Use records for DTOs; avoid `@Data` on JPA entities
- `@Transactional` on service layer only; `readOnly=true` for reads
- `@Valid` on `@RequestBody` + Bean Validation on DTOs
- Global error handling via `@RestControllerAdvice`
- Consistent error response: `{ "error": "CODE", "message": "..." }`
- API versioning: `/api/v1/...`

## JPA / Database
- `FetchType.LAZY` on relationships
- No entity loading in controller — use projections or DTOs
- `@Transactional(readOnly = true)` for read-only methods

## Configuration & Security
- No hardcoded secrets; use `@ConfigurationProperties`
- Input validated before processing

## Output
Flag issues by layer (Controller / Service / Repository / Config), with corrected code.
