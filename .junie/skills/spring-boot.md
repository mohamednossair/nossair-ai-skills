---
name: spring-boot
description: Spring Boot API, configuration, validation, transactions, and security
---

# Spring Boot Skill

## References
- `.windsurf/memories/spring-angular-patterns.md`
- `.windsurf/memories/coding-standards.md`

## Guidelines
- REST: plural nouns, proper status codes, problem+json for errors.
- Validation: Bean Validation annotations + `@Validated` on controllers.
- Config: bind with `@ConfigurationProperties`, avoid `@Value` scatter.
- Persistence: transactional boundaries at service layer.
- Security: method-level `@PreAuthorize`, CSRF as needed, no secrets in props.

## Checklist
- [ ] Request/response DTOs separate from entities
- [ ] Pageable endpoints validate page/size limits
- [ ] Exception handlers return consistent error schema
- [ ] Health/metrics via Actuator where appropriate
