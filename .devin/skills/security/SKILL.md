---
name: security
description: Security review and hardening (OWASP Top 10, Spring Security, JWT, CORS/CSRF, secrets/PII) — apply when code handles auth, user input, or secrets
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Apply the project's security standards when working on code that handles authentication, authorization, user input, secrets, or PII.

1. Read the detailed skill at `.junie/skills/security/SKILL.md` and follow it.
2. Combine with the technology skill (`spring-boot`, `angular`, `oracle`/`mysql`) for the code under review.
3. When reviewing, check the OWASP Top 10 items and the security checklist in the skill; group findings by [Critical] | [Warning] | [Suggestion] with Location, Issue, Why, Fix.
4. Flag any of these as Critical: missing authorization on an endpoint, string-concatenated SQL, secrets in code/logs, unsafe `[innerHTML]`, stack traces in error responses.
