---
apply: always
---

# Code Style (Project)

Use these as default rules in the IDE. For full details, see:
- `.windsurf/memories/coding-standards.md`
- `.windsurf/memories/tech-stack.md`
- `.windsurf/memories/testing-standards.md`

## General
- Prefer small, cohesive modules with clear names.
- Avoid duplication; extract pure helpers where possible.
- Validate inputs at boundaries; fail fast with actionable errors.
- No secrets/PII in code, logs, or configs.

## Java / Spring Boot
- Immutability by default; meaningful exceptions; SLF4J with placeholders.
- Controllers are thin; services are transactional; entities are not leaked to API.
- Use `@ConfigurationProperties` over scattered `@Value`.

## TypeScript / Angular
- `strict` typing; avoid `any`; favor discriminated unions and generics.
- Use standalone components; `OnPush` where feasible; AsyncPipe over manual subscribe.
- Accessibility: semantic HTML, keyboard nav, ARIA as needed.

## Python
- Type hints for public APIs; logging via stdlib; no prints in libs.
- Keep modules small; package with clear `__init__` APIs.

## SQL (Oracle/MySQL)
- Parameterize queries; avoid string concatenation.
- Design indexes for predicates/joins; verify with EXPLAIN/PLAN.
- Avoid `SELECT *`; use migrations with forward/back tests.
