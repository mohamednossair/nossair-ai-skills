# Business Analysis -- nossair-ai-skills

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0 | **Date**: 2026-04-21 | **Status**: Draft
> Auto-generated from source code. Written for product owners and business analysts. Review and adjust for accuracy.

## What is this system?
This is a centralized toolkit that provides consistent coding assistance across multiple AI coding assistants. It enables development teams to maintain unified coding standards, workflows, and commands across different AI tools (Claude Code, Codex, Junie, Windsurf, and JetBrains AI Assistant). The system manages skill definitions, coding guidelines, and deployment scripts to ensure developers receive consistent guidance regardless of which AI assistant they use.

## Health Summary

| Item | Count |
|------|-------|
| Features mapped | 15 |
| TBD sections | 3 |
| Mismatches flagged | 0 |
| Open questions | 2 |

## Contents

| # | Group | File | What a product owner will find here |
|---|-------|------|--------------------------------------|
| 1 | Overview | [01-overview.md](./01-overview.md) | What the system does, why it exists, who uses it -- in 30-second readable form |
| 2 | Scope & Context | [02-scope-context.md](./02-scope-context.md) | What is built, how the system works today, and the end-to-end business flow |
| 3 | Requirements | [03-requirements.md](./03-requirements.md) | User stories (As a / I want / So that) and rules the system enforces in plain language |
| 4 | Use Cases | [04-use-cases.md](./04-use-cases.md) | Step-by-step walkthroughs written as user stories, not technical flows |
| 5 | Acceptance Criteria | [05-acceptance-criteria.md](./05-acceptance-criteria.md) | Given/When/Then criteria a product owner can verify manually |
| 6 | Data & Reporting | [06-data-reporting.md](./06-data-reporting.md) | What data the system manages, what users see vs. what is stored, how success is measured |
| 7 | Supporting | [07-supporting.md](./07-supporting.md) | Assumptions, constraints, mismatches flagged as plain questions, risks as decisions needed |
| 8 | Reference | [08-reference.md](./08-reference.md) | Glossary translating every term to plain business language, change history |

## Quick Reference

**Primary Users**: Software developers, engineering leads, DevOps engineers

**Key Capabilities**:
- Unified commands across 5 AI coding assistants
- Centralized coding standards for Java, TypeScript, Python, Spring Boot, Angular
- Automated deployment scripts for skill distribution
- Speckit toolkit for specification-driven development workflows

**Integration Points**:
- Claude Code (global skill deployment)
- Codex (global skill deployment)
- Junie (per-project deployment)
- Windsurf (per-project deployment)
- JetBrains AI Assistant (per-project rules)

## How to Use This Document Set

1. **Start with 01-overview.md** to understand the system at a high level
2. **Review 02-scope-context.md** to see what exists and how it works
3. **Read 03-requirements.md** for detailed user stories and business rules
4. **Use 04-use-cases.md** and 05-acceptance-criteria.md** for verification
5. **Check 06-data-reporting.md** for data entities and metrics
6. **Review 07-supporting.md** for assumptions, constraints, and risks
7. **Reference 08-reference.md** for terminology glossary

## Notes for Reviewers

- This document was auto-generated from the source code repository
- Some sections marked as TBD require manual completion based on business context not evident in code
- The system is a toolkit/framework repository, not a traditional business application
- Business value is derived from developer productivity and consistency across AI tools
