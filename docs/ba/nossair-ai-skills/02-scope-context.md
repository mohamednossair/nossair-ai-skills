[<- Back to Index](./README.md) | [Next: Requirements ->](./03-requirements.md)

# 2. Scope & Context

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0

## What Is Built

The system is a centralized repository containing AI coding assistant skills, workflows, and coding standards. It consists of:

**Core Components**:
- **Skill Definitions**: Markdown files that define coding standards, review checklists, and best practices for different technologies (Java, TypeScript, Python, Spring Boot, Angular, SQL, Maven, Git, JUnit, Jest)
- **Unified Commands**: Workflow definitions that provide consistent behavior across AI assistants (/review, /plan, /test-generate, /git-commit)
- **Speckit Toolkit**: Specialized workflows for specification-driven development (/speckit.specify, /speckit.plan, /speckit.tasks, /speckit.validate, /speckit.analyze, /speckit.implement, /speckit.document-generate)
- **Deployment Scripts**: Automation scripts to install and sync skills to different AI assistants (install.sh, install.ps1, sync-claude.sh, sync-claude.ps1, sync-codex.sh, sync-codex.ps1)
- **Project Rules**: Shared guidelines for JetBrains AI Assistant that can be copied to any project

**Supported AI Assistants**:
- Claude Code (global skill deployment)
- Codex (global skill deployment)
- Junie (per-project deployment)
- Windsurf (per-project deployment)
- JetBrains AI Assistant (per-project rules)

**Supported Technologies**:
- Java 21+ LTS
- TypeScript (strict mode)
- Python (PEP 8)
- Spring Boot 3.2+
- Angular 20+
- Oracle Database
- MySQL Database
- Maven
- Git
- JUnit 5
- Jest

## How It Works Today

**Current State**: The system is a static repository of markdown files and shell scripts. There is no runtime application or database. The "business logic" is executed by AI assistants reading the markdown files and following the defined instructions.

**Deployment Flow**:
1. **For Claude Code**: Developers run `sync-claude.sh` or `sync-claude.ps1` to copy skill files from `.claude/skills/` to the global Claude Code skills directory
2. **For Codex**: Developers run `sync-codex.sh` or `sync-codex.ps1` to copy skill folders from `.junie/skills/` to the Codex skills directory
3. **For Junie**: Developers copy the `.junie/` folder to their project directory
4. **For Windsurf**: Developers copy the `.windsurf/` folder to their project directory
5. **For JetBrains AI Assistant**: Developers copy the `.aiassistant/` folder to their project directory

**Command Execution Flow**:
1. Developer invokes a command in their AI assistant (e.g., `/review file="src/App.java"`)
2. AI assistant reads the corresponding workflow file from the agent-specific directory
3. AI assistant follows the instructions in the workflow file
4. AI assistant reads relevant skill files and coding standards
5. AI assistant applies the standards to the developer's code or task
6. AI assistant outputs results according to the workflow instructions

**Maintenance Flow**:
1. Developer updates a skill file or workflow in the central repository
2. Developer runs sync scripts to deploy changes to AI assistants
3. Changes are immediately available to all developers using those AI assistants

## End-to-End Business Flow

**Scenario 1: Developer Code Review**

1. Developer writes code in their project
2. Developer invokes `/review file="src/Service.java"` in their AI assistant
3. AI assistant reads the review workflow and identifies the technology (Java)
4. AI assistant loads Java coding standards and the Java skill definition
5. AI assistant analyzes the code against standards (SOLID principles, null safety, performance, readability)
6. AI assistant outputs findings grouped by severity (Critical, Warning, Suggestion) with location, issue, impact, and fix
7. Developer reviews findings and applies fixes

**Scenario 2: Feature Planning**

1. Developer receives a new feature requirement
2. Developer invokes `/plan task="Add user authentication"` in their AI assistant
3. AI assistant reads the plan workflow
4. AI assistant breaks the task into logical steps
5. AI assistant identifies files to create/modify, applicable standards, and relevant skills
6. AI assistant estimates complexity and flags risks
7. AI assistant outputs a numbered plan with files, standards, skills, and risk per step
8. Developer follows the plan to implement the feature

**Scenario 3: Test Generation**

1. Developer writes a new service class
2. Developer invokes `/test-generate file="src/Service.java"` in their AI assistant
3. AI assistant reads the test generation workflow and identifies the technology (Java)
4. AI assistant loads testing standards (JUnit 5, AAA pattern, AssertJ)
5. AI assistant generates a complete test file with happy path, edge cases, and error paths
6. Developer reviews and runs the tests

**Scenario 4: Speckit Specification Workflow**

1. Product owner provides a feature description
2. Developer invokes `/speckit.specify feature="..."` to create a specification
3. Developer invokes `/speckit.plan spec="..."` to create an implementation plan
4. Developer invokes `/speckit.tasks plan="..."` to generate dependency-ordered tasks
5. Developer invokes `/speckit.implement tasks="..."` to get an execution runbook
6. Developer follows the runbook to implement the feature with proper test and review gates
7. Developer invokes `/speckit.validate` to ensure consistency across spec, plan, and tasks

## Integration Points

**External Systems**:
- **Claude Code**: Reads skills from `~/.claude/skills/` directory
- **Codex**: Reads skills from `$CODEX_HOME/skills/` or `~/.codex/skills/` directory
- **Junie**: Reads skills and commands from project `.junie/` directory
- **Windsurf**: Reads memories and workflows from project `.windsurf/` directory
- **JetBrains AI Assistant**: Reads rules from project `.aiassistant/rules/` directory

**No Backend Systems**: The system does not integrate with any databases, APIs, or external services. It is a purely static repository of documentation and scripts.

## Current Limitations

**Scope Boundaries**:
- The system only supports the 5 listed AI assistants
- The system only supports the 10 listed technologies
- Skills are manually authored in markdown; no automated generation from code
- No validation that deployed skills match the central repository
- No automated testing of skill definitions
- No metrics or analytics on skill usage

**Out of Scope**:
- The system does not execute code or perform actual code reviews
- The system does not store or manage project-specific configurations
- The system does not provide a web interface or dashboard
- The system does not manage user accounts or permissions
- The system does not integrate with CI/CD pipelines directly
