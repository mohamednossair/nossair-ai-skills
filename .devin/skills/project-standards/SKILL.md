---
name: project-standards
description: Load the right technology skill from .junie/skills before writing or reviewing code in this repo's target stack (Java 21, Spring Boot 3.2, Angular 20, TypeScript, Python, Oracle/MySQL)
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - model
---

Before generating or reviewing code, load the matching standards so output follows project conventions.

## Standards Map

| File / context | Load this skill |
|----------------|-----------------|
| Any task | `.junie/skills/global/SKILL.md` (always apply) |
| `.java` without Spring | `.junie/skills/java/SKILL.md` |
| `.java` with Spring annotations | `.junie/skills/java/SKILL.md` + `.junie/skills/spring-boot/SKILL.md` |
| `.ts` / `.tsx` without Angular | `.junie/skills/typescript/SKILL.md` |
| Angular components/services/templates | `.junie/skills/typescript/SKILL.md` + `.junie/skills/angular/SKILL.md` |
| `.py` | `.junie/skills/python/SKILL.md` |
| `.sql` for Oracle | `.junie/skills/oracle/SKILL.md` |
| `.sql` for MySQL | `.junie/skills/mysql/SKILL.md` |
| `pom.xml` / Maven build | `.junie/skills/maven/SKILL.md` |
| Auth, tokens, CORS, secrets, PII, user input | `.junie/skills/security/SKILL.md` (combine with the tech skill) |
| Slow endpoints, queries, pages; caching; concurrency | `.junie/skills/performance/SKILL.md` (combine with the tech skill) |
| Angular templates, forms, dialogs, custom widgets | `.junie/skills/accessibility/SKILL.md` (combine with `angular`) |
| Branches, commits, PRs | `.junie/skills/git/SKILL.md` |
| `*Test.java` | `.junie/skills/junit/SKILL.md` |
| `*.spec.ts` / `*.test.ts` | `.junie/skills/jest/SKILL.md` |
| Specs / plans / tasks | `.junie/skills/speckit/SKILL.md` |

Consolidated one-page summary: `.junie/guidelines.md`.

## Non-Negotiables (quick reference)

- Java 21+ LTS: records for DTOs, `Optional<T>` returns, `java.time`, constructor injection, virtual threads for I/O.
- Spring Boot 3.2+: layered architecture, DTOs never entities, `@Valid` on controller request bodies, `@Transactional` on services, Flyway migrations.
- Angular 20+: standalone components, OnPush, `inject()`, signals-first, `@if`/`@for` (with `track`)/`@switch`/`@defer`.
- TypeScript: `strict: true`, no `any`, explicit return types, named exports.
- Python: full type hints, no bare `except:`, f-strings, `with` for resources.
- SQL: bind variables always, no `SELECT *`, index foreign keys.
- Git: Conventional Commits, imperative mood, max 72 chars, branch from `main`/`master`/`develop` before committing.
- Never hardcode secrets, URLs, or environment-specific values.
