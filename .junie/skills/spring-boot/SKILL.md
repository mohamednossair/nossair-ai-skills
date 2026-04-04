---
name: spring-boot
description: Review or develop Spring Boot 3+ applications with layered architecture and virtual threads
---

# Spring Boot Skill

Use this skill when developing or reviewing Spring Boot applications. The project follows a strict layered architecture and targets Spring Boot 3.2+ for virtual thread support.

## Key Principles
- **Layered Architecture**: `controller` → `service` → `repository`.
- **Constructor Injection**: Use `@RequiredArgsConstructor` (Lombok) and `final` fields. No `@Autowired` on fields.
- **DTOs (Records)**: Never expose JPA entities in API responses. Use Java records as DTOs.
- **Transactional**: Use `@Transactional` on service methods only; `readOnly = true` for reads.
- **Validation**: Use `@Valid` + Bean Validation on all request bodies.
- **Modern Concurrency**: Enable virtual threads via `spring.threads.virtual.enabled=true`.

## Guidelines

### Controllers
- Use `ResponseEntity<T>` for explicit status codes.
- URL naming: plural nouns, kebab-case (`/api/order-items`).
- Use `@RestControllerAdvice` for global exception handling.
- Consistent error response shapes: `{ "error": "CODE", "message": "...", "timestamp": "...", "path": "..." }`.
- Version APIs via URI path (e.g., `/api/v1/...`).

### Services & Repositories
- Business logic belongs in the service layer.
- Use `FetchType.LAZY` for all JPA relationships.
- Use `@EntityGraph` for intentional eager loading.
- Lombok: Use `@RequiredArgsConstructor`, `@Getter`, `@Slf4j`. Avoid `@Data` on entities.
- Configuration: No hardcoded secrets; use `@ConfigurationProperties` over scattered `@Value`.

### Database
- Flyway for database migrations. Never modify applied migrations.
- Always use bind variables in SQL (avoid SQL injection).

## Checklist
- [ ] Is it using constructor injection with `final` fields?
- [ ] Are JPA entities kept private (not exposed in API)?
- [ ] Is `@Transactional` on the service layer?
- [ ] Are virtual threads enabled/used for I/O?
- [ ] Are request bodies validated with `@Valid`?
- [ ] Is `@RestControllerAdvice` used for errors?
- [ ] Is there any `@Data` on JPA entities? (Should not be)

## Examples

### Modern Spring Boot Service
```java
@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {
    private final OrderRepository repository;

    @Transactional
    public OrderResponse createOrder(@Valid OrderRequest request) {
        log.info("Creating order for customer: {}", request.customerId());
        Order order = Order.builder()
            .status(OrderStatus.PENDING)
            .build();
        return OrderResponse.fromEntity(repository.save(order));
    }

    @Transactional(readOnly = true)
    public Optional<OrderResponse> getOrder(Long id) {
        return repository.findById(id).map(OrderResponse::fromEntity);
    }
}
```
