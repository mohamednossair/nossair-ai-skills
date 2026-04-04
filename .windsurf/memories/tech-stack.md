# Tech Stack Overview

## Languages
- **Java 21+ LTS** (primary backend) — virtual threads, records, sealed classes, pattern matching
- **TypeScript** (frontend) — strict mode, Angular framework
- **Python** — scripting, tooling, type hints required

## Frameworks & Libraries
- **Spring Boot 3.2+** — REST APIs, JPA/Hibernate, Spring Security, virtual threads
- **Angular 20+** — standalone components, signals (primary reactivity), zoneless CD, resource API

## Build & Tooling
- **Maven** — Java build, dependency management, multi-module support
- **Git** — version control, Conventional Commits format
- **Flyway** — database schema migration management

## Databases
- **Oracle** — production database; bind variables, sequences/identity columns
- **MySQL** — InnoDB engine, utf8mb4 charset, HikariCP connection pool

## Testing
- **JUnit 5** — Java testing; Mockito for mocking; AssertJ for assertions; Testcontainers for real DB
- **Jest** — TypeScript/Angular testing; jest-preset-angular

## Project Conventions
- REST API URLs: plural nouns, kebab-case (`/api/v1/order-items`)
- API versioning: URI path-based (`/api/v1/...`)
- Commit messages: Conventional Commits (`feat(scope): description`)
- Package structure: `controller/` → `service/` → `repository/` → `domain/` → `dto/`
- DTOs: Java records, never expose JPA entities in API responses
- Config: `application.yml` with profile-specific overrides (`-dev`, `-prod`)
- Secrets: externalized to env vars or Vault — never in code
