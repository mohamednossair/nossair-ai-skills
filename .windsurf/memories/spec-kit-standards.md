# Spec-Driven Development (SDD) Standards
The project follows a "Spec-First" approach to ensure architectural integrity and token-efficient AI collaboration.

## 🧱 Architectural Guardrails
- **No Vibe-Coding**: Never write code without an approved Task from `tasks/*.md`.
- **Phased Workflow**: Sequential progression is mandatory: `Constitution` -> `Spec` -> `Plan` -> `Tasks` -> `Implement`.
- **Validation Gates**: Every major architectural change must be reflected in `plan.md` before implementation.

## 📝 Document Standards
- **Constitution**: Principles are non-negotiable. If it's in the Constitution, it's a hard requirement.
- **Specification**: Must define WHAT and WHY. Keep user stories testable and concise.
- **Technical Plan**: Use technical language and structural diagrams (Mermaid or similar).
- **Task Breakdown**: Tasks must be atomic. If a task takes more than 50 lines to implement, break it down further.

## 📉 Token Optimization
- **Conciseness**: Avoid prose; use bullet points and structured headers.
- **Reference**: Tasks should reference specific IDs or headers in the Spec/Plan.
- **Cleanup**: Remove deprecated or outdated tasks once implemented.

