---
name: security
description: Security review and hardening for Java/Spring, Angular, and SQL — OWASP Top 10, Spring Security, JWT, CORS/CSRF, secrets and PII handling
---

# Security Skill

Use this skill for security-focused development and reviews. It consolidates OWASP Top 10 checks with Spring Security and Angular security standards for this project.

## When to Use
- Writing or reviewing code that handles authentication, authorization, sessions, or tokens.
- Designing REST endpoints, CORS policies, CSRF protection, or input validation.
- Handling secrets, credentials, API keys, or PII.
- Any `/review` of code involving user input, auth, or external data (combine with the technology skill).

## Key Principles
- **Never trust client input**: validate every input server-side, at the boundary.
- **Deny by default**: every endpoint requires explicit authorization; least privilege everywhere.
- **Fail securely**: errors must be generic — no stack traces, SQL, or internal paths in responses.
- **Defense in depth**: validation + parameterized queries + output encoding + authorization, not just one layer.
- **Secrets never in code or logs**: env vars or vault only; PII masked in logs.

## Guidelines

### OWASP Top 10 Review Checks
- **A01 Broken Access Control**: object-level authorization on every request (no IDOR — verify the caller owns the resource); `@PreAuthorize` on service methods for fine-grained rules; admin routes protected.
- **A02 Cryptographic Failures**: passwords hashed with BCrypt or Argon2 (never MD5/SHA-1/plain); sensitive data encrypted at rest and in transit (TLS).
- **A03 Injection**: bind variables for all SQL/JPQL (never string concatenation); no dynamic native queries from user input.
- **A04 Insecure Design**: rate limiting on login/refresh/registration endpoints; abuse cases considered for new features.
- **A05 Security Misconfiguration**: CORS restricted to known origins (never `*` with credentials); no default credentials; actuator endpoints secured or disabled in prod.
- **A06 Vulnerable Components**: no dependencies with known CVEs; keep the BOM updated.
- **A07 Auth Failures**: token expiry + refresh rotation; generic "invalid credentials" messages (no user enumeration); lockout or throttling on repeated failures.
- **A08 Integrity Failures**: verify dependency sources; no unsigned/unverified artifacts in the build.
- **A09 Logging Failures**: log auth events (login success/failure, token refresh); never log passwords, tokens, secrets, or PII.
- **A10 SSRF**: validate and allow-list outbound URLs built from user input.

### Spring Security
- Use a `SecurityFilterChain` bean — `WebSecurityConfigurerAdapter` was removed in Spring Boot 3.
- Stateless JWT APIs: `SessionCreationPolicy.STATELESS`, CSRF disabled only for token-based APIs, CORS configured per environment.
- Passwords: `BCryptPasswordEncoder` (or Argon2); never reversible encoding.
- Method security: `@EnableMethodSecurity` + `@PreAuthorize` on service methods, not just URL rules.
- Never disable security filters for "internal" endpoints in production profiles.

### Angular
- Templates escape by default — flag any `[innerHTML]` with unsanitized content; never use `bypassSecurityTrustHtml` without explicit justification.
- Route guards (`CanActivateFn`) for protected routes — but the server must still enforce authorization (client checks are UX, not security).
- Prefer short-lived access tokens; avoid long-lived JWTs in `localStorage` where an httpOnly cookie is possible.
- Type all HTTP calls and handle errors — leaked error details in the console are an information-disclosure vector.

### Secrets & PII
- Secrets come from environment variables or a vault — never hardcoded, never committed in `application.yml`.
- Mask PII in logs (email, names, IDs); log identifiers, not raw personal data.
- Collect the minimum PII needed; document retention where applicable.

## Checklist
- [ ] All inputs validated server-side?
- [ ] Every endpoint has authorization (deny by default, object-level checks)?
- [ ] SQL/JPQL fully parameterized?
- [ ] Passwords hashed with BCrypt/Argon2?
- [ ] No secrets in code, configs, or logs?
- [ ] CORS restricted to known origins?
- [ ] Error responses generic (no stack traces or internals)?
- [ ] Auth events logged; no secrets/PII in logs?
- [ ] Rate limiting on auth endpoints?
- [ ] Angular: no unsafe `[innerHTML]`; server enforces authorization?

## Example

### Stateless JWT Security Filter Chain
```java
@Bean
SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
        .csrf(csrf -> csrf.disable()) // token-based API only
        .cors(cors -> cors.configurationSource(corsConfigurationSource()))
        .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/api/v1/auth/**").permitAll()
            .anyRequest().authenticated())
        .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()));
    return http.build();
}
```
> Note: `permitAll` only on the auth endpoints themselves; everything else is authenticated. Add `@PreAuthorize` on services for role- or object-level rules.
