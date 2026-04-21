[<- Back to Index](./README.md) | [Previous: Supporting](./07-supporting.md)

# 8. Reference

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0

## Glossary

| Term | Plain Language Definition |
|------|---------------------------|
| **AI Assistant** | A software tool that uses artificial intelligence to help developers write, review, and test code. Examples include Claude Code, Codex, Junie, Windsurf, and JetBrains AI Assistant. |
| **AI Coding Assistant** | Same as AI Assistant - an AI-powered tool that assists with coding tasks. |
| **Skill** | A set of instructions, guidelines, and best practices that an AI assistant uses to provide technology-specific guidance. For example, a Java skill tells the AI how to review Java code. |
| **Unified Command** | A command (like /review or /plan) that works the same way across multiple AI assistants. This ensures developers get consistent guidance regardless of which AI tool they use. |
| **Workflow** | A step-by-step process that an AI assistant follows when a command is invoked. Workflows define what the AI should do and in what order. |
| **Coding Standards** | Rules and guidelines for how code should be written. These include naming conventions, structure requirements, and best practices. |
| **Conventional Commits** | A standard format for Git commit messages that follows the pattern `type(scope): description`. This makes commit history easier to read and automate. |
| **Speckit** | A toolkit for specification-driven development that helps teams go from feature description to implementation through structured workflows. |
| **Specification (Spec)** | A document that describes what a feature should do, including goals, acceptance criteria, data model, and open questions. |
| **Implementation Plan** | A document that breaks down a feature specification into milestones, deliverables, dependencies, and risks. |
| **Task List** | A document that breaks down an implementation plan into specific, dependency-ordered tasks with acceptance criteria. |
| **Execution Runbook** | A document that provides step-by-step instructions for implementing tasks, including branch strategy, test scaffolds, and review checkpoints. |
| **Claude Code** | An AI coding assistant by Anthropic that uses slash commands stored in markdown files. |
| **Codex** | An AI coding assistant that loads skills from a skills directory based on request context. |
| **Junie** | An AI coding assistant that uses agent skills and custom slash commands stored in project directories. |
| **Windsurf** | An AI coding assistant that uses persistent context memories and workflow files stored in project directories. |
| **JetBrains AI Assistant** | An AI coding assistant integrated into JetBrains IDEs that uses project rules for guidance. |
| **Sync Script** | A script that copies skill files from the central repository to the AI assistant's installation directory. |
| **Parity Validation** | A check that ensures unified commands have identical behavior across different AI assistants. |
| **AAA Pattern** | A testing pattern that stands for Arrange (setup), Act (execute), Assert (verify). |
| **SOLID** | A set of principles for object-oriented design: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion. |
| **DRY** | Don't Repeat Yourself - a principle that encourages avoiding code duplication. |
| **DTO (Data Transfer Object)** | An object used to transfer data between processes, typically in API requests and responses. |
| **JPA (Java Persistence API)** | A Java specification for object-relational mapping that allows Java objects to be stored in a database. |
| **Bean Validation** | A Java specification for validating object constraints, such as @NotNull or @Size. |
| **Virtual Threads** | A feature in Java 21 that allows lightweight threads for improved concurrency. |
| **Record** | A Java feature for creating immutable data classes with minimal boilerplate. |
| **Sealed Class** | A Java feature that restricts which classes can extend or implement a class or interface. |
| **Pattern Matching** | A Java feature that allows matching patterns in switch statements and instanceof checks. |
| **Signal** | An Angular feature for reactive state management, replacing traditional @Input and @Output. |
| **Standalone Component** | An Angular component that doesn't require an NgModule, introduced in Angular 14+. |
| **OnPush** | An Angular change detection strategy that only checks for changes when inputs change. |
| **Strict Mode** | A TypeScript compiler option that enables stricter type checking. |
| **Type Hint** | A Python feature that allows specifying the expected type of function parameters and return values. |
| **PEP 8** | The style guide for Python code, covering naming conventions, indentation, and other formatting rules. |
| **Flyway** | A database migration tool for Java that manages schema changes in a version-controlled way. |
| **Maven** | A build automation tool for Java projects that manages dependencies and build processes. |
| **JUnit 5** | A testing framework for Java applications. |
| **Jest** | A testing framework for JavaScript/TypeScript applications. |
| **AssertJ** | A fluent assertion library for Java tests that provides readable assertion statements. |
| **Mockito** | A mocking framework for Java tests that allows creating mock objects. |
| **Testcontainers** | A library that provides lightweight Docker containers for integration testing. |
| **Git** | A version control system for tracking changes in code. |
| **Branch** | A parallel version of the codebase in Git, used for isolated development work. |
| **Commit** | A saved state of changes in Git. |
| **Pull Request (PR)** | A mechanism for proposing changes to a codebase in Git hosting platforms. |
| **CI/CD** | Continuous Integration and Continuous Deployment - automated processes for building, testing, and deploying code. |
| **Linting** | Automated checking of code for style and syntax errors. |
| **Refactoring** | The process of restructuring existing code without changing its external behavior. |
| **Edge Case** | A scenario that occurs at the extreme ends of operating ranges or with unusual inputs. |
| **Happy Path** | The default scenario where everything works as expected without errors. |
| **Guard Clause** | A conditional check at the beginning of a function that returns early if a condition is met. |
| **Dependency Injection** | A design pattern where objects receive their dependencies from external sources rather than creating them. |
| **Layered Architecture** | A software architecture pattern that separates concerns into distinct layers (e.g., controller, service, repository). |
| **REST API** | A web service that uses HTTP methods (GET, POST, PUT, DELETE) to perform operations on resources. |
| **API Versioning** | The practice of managing multiple versions of an API to allow for backward compatibility. |
| **Bind Variable** | A placeholder in a SQL statement that is replaced with a value at runtime, preventing SQL injection. |
| **SQL Injection** | A security vulnerability where malicious SQL code is inserted into user input. |
| **PII (Personally Identifiable Information)** | Information that can be used to identify an individual, such as names, email addresses, or phone numbers. |
| **Secret** | Sensitive information such as passwords, API keys, or tokens that must be kept secure. |
| **Environment Variable** | A variable outside the application code that stores configuration values, such as database URLs or API keys. |
| **Vault** | A secure system for storing and managing secrets, such as HashiCorp Vault. |
| **Markdown** | A lightweight markup language for formatting text, commonly used for documentation. |
| **Frontmatter** | Metadata at the beginning of a markdown file, typically enclosed in triple dashes (---). |
| **Shell Script** | A script written for a command-line shell (bash) to automate tasks on Linux/macOS. |
| **PowerShell Script** | A script written for PowerShell to automate tasks on Windows. |
| **Repository** | A storage location for software packages and version control data. |
| **Git Root** | The top-level directory of a Git repository. |
| **Workspace** | The set of directories and files a developer is currently working on. |
| **Monorepo** | A repository that contains multiple projects or modules. |
| **Polyrepo** | An approach where each project or module has its own repository. |
| **Tech Stack** | The set of technologies used to build a software system. |
| **Framework** | A pre-built structure that provides a foundation for developing applications. |
| **Library** | A collection of pre-written code that developers can use to perform common tasks. |
| **Dependency** | External code that a project relies on to function. |
| **Package Manager** | A tool that automates the process of installing, updating, and managing dependencies. |
| **Build Tool** | A tool that automates the process of compiling, testing, and packaging software. |
| **IDE** | Integrated Development Environment - a software application that provides comprehensive facilities for programming. |
| **CLI** | Command Line Interface - a means of interacting with a computer program through text commands. |
| **Slash Command** | A command invoked by typing a forward slash followed by a command name, commonly used in chat interfaces and AI assistants. |
| **Prompt** | The input or instruction given to an AI system to elicit a response. |
| **Context** | The information or environment in which something occurs or is understood. |
| **Persistent Context** | Information that is maintained across multiple interactions with an AI system. |
| **Memory** | Stored information that an AI system can reference across sessions. |
| **Workflow File** | A markdown file that defines the steps an AI assistant should follow for a specific command. |
| **Skill File** | A markdown file that defines technology-specific guidance for an AI assistant. |
| **Guidelines File** | A markdown file that contains project-wide coding standards and conventions. |
| **Template** | A pre-formatted file that serves as a starting point for creating new files. |
| **Scaffolding** | The process of generating a basic project structure or file set. |
| **Deployment** | The process of making software available for use. |
| **Sync** | The process of copying files from one location to another to ensure they are up-to-date. |
| **Validation** | The process of checking that something meets specified requirements. |
| **Verification** | The process of confirming that something is correct or true. |
| **Acceptance Criteria** | The conditions that a software feature must satisfy to be accepted by a stakeholder. |
| **User Story** | A description of a software feature from the perspective of a user, typically following the format "As a [user], I want [feature], so that [benefit]." |
| **Use Case** | A description of how a user interacts with a system to achieve a specific goal. |
| **Stakeholder** | A person or organization with an interest in a project or its outcome. |
| **Business Analyst** | A person who analyzes an organization's business processes and systems to identify improvements. |
| **Product Owner** | A person responsible for defining and prioritizing product features. |
| **Engineering Lead** | A person responsible for technical decisions and managing the engineering team. |
| **Developer** | A person who writes, tests, and maintains software. |
| **DevOps Engineer** | A person who focuses on the intersection of development and operations, often responsible for deployment and infrastructure. |
| **Maintainer** | A person responsible for maintaining and updating a software project. |
| **Contributor** | A person who contributes code, documentation, or other improvements to a project. |
| **Open Source** | Software whose source code is made available for anyone to use, modify, and distribute. |
| **Proprietary** | Software that is owned by an individual or company and not freely available. |
| **License** | A legal document that specifies how software can be used, modified, and distributed. |
| **Documentation** | Written material that explains how software works and how to use it. |
| **README** | A file that provides an overview and introduction to a software project. |
| **CHANGELOG** | A file that records notable changes made to a software project over time. |
| **Version** | A specific iteration of software, often following semantic versioning (major.minor.patch). |
| **Release** | The distribution of a new version of software. |
| **Patch** | A small change to software that fixes bugs or makes minor improvements. |
| **Feature** | A distinct functionality or capability of software. |
| **Bug** | An error, flaw, or fault in software that produces incorrect or unexpected results. |
| **Issue** | A problem or request tracked in a project management system. |
| **Ticket** | Another term for an issue, commonly used in project management systems like Jira. |
| **Sprint** | A fixed time period in which specific work must be completed, commonly used in Agile development. |
| **Milestone** | a significant point or event in project development. |
| **Deliverable** | A tangible outcome or product provided as part of a project. |
| **Risk** | A potential event or circumstance that could negatively impact a project. |
| **Mitigation** | An action taken to reduce the likelihood or impact of a risk. |
| **Assumption** | Something accepted as true without proof, often used as a basis for planning. |
| **Constraint** | A limitation or restriction that affects a project. |
| **Dependency** | A relationship where one thing relies on another. |
| **Traceability** | The ability to track and link artifacts across different stages of development. |
| **Gap** | A missing element or discrepancy between expected and actual state. |
| **Inconsistency** | A lack of uniformity or compatibility between elements. |
| **Drift** | Gradual deviation from an intended state or standard. |
| **Adoption** | The process of starting to use a new technology or practice. |
| **Onboarding** | The process of integrating a new team member or technology. |
| **Feedback** | Information about reactions to a product, person, or service. |
| **Quality Assurance (QA)** | The process of ensuring that software meets specified quality standards. |
| **Code Review** | The process of examining code to find errors and improve quality. |
| **Peer Review** | A review of work by someone with similar expertise. |
| **Test Coverage** | The percentage of code that is executed by automated tests. |
| **Integration Test** | A test that verifies that different parts of a system work together correctly. |
| **Unit Test** | A test that verifies a small, isolated piece of code. |
| **End-to-End Test** | A test that verifies that a system works as expected from start to finish. |
| **Regression Test** | A test that verifies that changes have not introduced new bugs. |
| **Smoke Test** | A quick test to verify that the most critical functions work. |
| **Performance Test** | A test that measures how well a system performs under specific conditions. |
| **Security Test** | A test that identifies vulnerabilities in a system. |
| **Accessibility Test** | A test that verifies that a system is usable by people with disabilities. |
| **User Acceptance Test (UAT)** | A test that verifies that a system meets user requirements. |
| **Definition of Done (DoD)** | A checklist that must be satisfied before work is considered complete. |
| **Backlog** | A list of tasks or features to be worked on. |
| **Kanban** | A method for visualizing and managing work. |
| **Scrum** | An Agile framework for developing, delivering, and sustaining complex products. |
| **Agile** | An iterative approach to software development that emphasizes flexibility and collaboration. |
| **Waterfall** | A sequential software development methodology. |
| **DevOps** | A set of practices that combines software development and IT operations. |
| **SRE (Site Reliability Engineering)** | A discipline that incorporates aspects of software engineering and applies them to infrastructure and operations problems. |
| **Cloud Native** | An approach to building and running applications that takes advantage of the cloud computing model. |
| **Microservices** | An architectural style that structures an application as a collection of loosely coupled services. |
| **Monolith** | A software application in which the user interface and data access code are combined into a single program. |
| **Serverless** | A cloud computing execution model where the cloud provider dynamically manages the allocation of machine resources. |
| **Container** | A lightweight, standalone, executable package of software that includes everything needed to run an application. |
| **Docker** | A platform for developing, shipping, and running applications in containers. |
| **Kubernetes** | An open-source system for automating deployment, scaling, and management of containerized applications. |
| **Infrastructure as Code (IaC)** | The process of managing and provisioning infrastructure through code rather than manual processes. |
| **Terraform** | An open-source infrastructure as code software tool. |
| **Ansible** | An open-source automation tool for configuration management and application deployment. |
| **CI Pipeline** | An automated process for building, testing, and validating code changes. |
| **CD Pipeline** | An automated process for deploying code changes to production or other environments. |
| **Artifact** | A byproduct of software development, such as compiled code, documentation, or test results. |
| **Repository Guidelines** | Rules and conventions for managing a code repository. |
| **Commit Message** | A message that describes the changes made in a Git commit. |
| **Branch Prefix** | A standard naming convention prefix for Git branches (e.g., feature/, bugfix/). |
| **Pull Request Template** | A template for creating pull requests with standard information. |
| **Code Owner** | A person or team responsible for approving changes to specific files or directories. |
| **Protected Branch** | A Git branch that has restrictions on who can push changes or require pull requests. |
| **Required Status Checks** | CI/CD checks that must pass before a pull request can be merged. |
| **Merge Strategy** | The method used to integrate changes from one branch into another (e.g., merge, rebase, squash). |
| **Rebase** | A Git operation that rewrites commit history to move a branch to a new base. |
| **Squash Merge** | A merge strategy that combines all commits from a feature branch into a single commit. |
| **Fast-Forward Merge** | A merge strategy that simply moves the branch pointer forward if there are no divergent commits. |
| **Merge Conflict** | A situation where Git cannot automatically reconcile changes from different branches. |
| **Stash** | A Git operation that temporarily saves changes that are not ready to be committed. |
| **Cherry-Pick** | A Git operation that applies a specific commit from one branch to another. |
| **Tag** | A reference to a specific point in Git history, often used for releases. |
| **Remote** | A version of a repository hosted on a server or network. |
| **Origin** | The default name given to the primary remote repository. |
| **Upstream** | A remote repository from which you forked your own repository. |
| **Fork** | A copy of a repository that allows you to make changes without affecting the original. |
| **Clone** | A copy of a repository downloaded to your local machine. |
| **Pull** | A Git operation that fetches and merges changes from a remote repository. |
| **Fetch** | A Git operation that downloads changes from a remote repository without merging. |
| **Push** | A Git operation that uploads local commits to a remote repository. |
| **Head** | A reference to the current commit in a Git repository. |
| **Master/Main** | The default branch name in a Git repository. |
| **Develop** | A branch where integration happens for feature branches in Git Flow. |
| **Git Flow** | A branching model for Git that provides a strict framework for managing releases. |
| **Trunk-Based Development** | A Git branching strategy where developers commit directly to the main branch. |
| **Feature Branch** | A branch created for developing a new feature. |
| **Release Branch** | A branch created for preparing a new release. |
| **Hotfix Branch** | A branch created for fixing a critical issue in production. |

---

## Revision History

| Version | Date | Author | Description |
|---------|------|--------|-------------|
| 1.0 | 2026-04-21 | AI Auto-Generation | Initial Business Analysis document set generated from source code |

---

## Related Documents

### Internal Documents
- [README.md](../../README.md) - Repository overview and setup instructions
- [AGENTS.md](../../AGENTS.md) - Agent-specific usage guide
- [.junie/guidelines.md](../../.junie/guidelines.md) - Project coding guidelines
- [.windsurf/memories/commands-reference.md](../../.windsurf/memories/commands-reference.md) - Unified command reference
- [.windsurf/memories/tech-stack.md](../../.windsurf/memories/tech-stack.md) - Technology stack overview
- [.windsurf/memories/coding-standards.md](../../.windsurf/memories/coding-standards.md) - Coding standards reference
- [.windsurf/memories/testing-standards.md](../../.windsurf/memories/testing-standards.md) - Testing standards reference
- [.windsurf/memories/spring-angular-patterns.md](../../.windsurf/memories/spring-angular-patterns.md) - Framework patterns

### External References
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit message specification
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID) - Object-oriented design principles
- [DRY Principle](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) - Don't Repeat Yourself principle
- [AAA Pattern](https://martinfowler.com/bliki/GivenWhenThen.html) - Arrange-Act-Assert testing pattern
- [Java 21 Documentation](https://docs.oracle.com/en/java/javase/21/) - Java 21 official documentation
- [TypeScript Handbook](https://www.typescriptlang.org/docs/) - TypeScript official documentation
- [Python PEP 8](https://peps.python.org/pep-0008/) - Python style guide
- [Spring Boot Documentation](https://spring.io/projects/spring-boot) - Spring Boot official documentation
- [Angular Documentation](https://angular.dev/) - Angular official documentation
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/) - JUnit 5 documentation
- [Jest Documentation](https://jestjs.io/docs/getting-started) - Jest documentation
- [Git Documentation](https://git-scm.com/doc) - Git official documentation
- [Maven Documentation](https://maven.apache.org/guides/) - Maven documentation
- [Flyway Documentation](https://flywaydb.org/documentation/) - Flyway documentation
- [Oracle Documentation](https://docs.oracle.com/en/database/) - Oracle database documentation
- [MySQL Documentation](https://dev.mysql.com/doc/) - MySQL database documentation

---

## Contact Information

**Repository Maintainers**: TBD

**For Questions or Issues**: 
- Open an issue in the repository (if publicly accessible)
- Contact the engineering team (internal process TBD)

**For Contributions**: 
- See the repository contribution guidelines (if available)
- Follow the standard pull request process

---

## Appendix

### File Structure Reference

```
nossair-ai-skills/
├── .claude/skills/           # Claude Code slash commands
├── .junie/                   # Junie assets
│   ├── commands/             # Junie slash commands
│   ├── skills/               # Junie skill definitions
│   └── guidelines.md         # Project coding guidelines
├── .windsurf/                # Windsurf assets
│   ├── memories/             # Persistent context files
│   └── workflows/            # Windsurf slash commands
├── .aiassistant/             # JetBrains AI Assistant rules
│   └── rules/                # Project-specific rules
├── scripts/                  # Deployment and maintenance scripts
├── templates/                # Skill and command templates
├── docs/                     # Documentation
│   └── ba/                   # Business Analysis documents
└── README.md                 # Repository overview
```

### Supported AI Assistants

| Assistant | Deployment Type | Location |
|-----------|----------------|----------|
| Claude Code | Global | ~/.claude/skills/ |
| Codex | Global | $CODEX_HOME/skills/ or ~/.codex/skills/ |
| Junie | Per-project | <project>/.junie/ |
| Windsurf | Per-project | <project>/.windsurf/ |
| JetBrains AI Assistant | Per-project | <project>/.aiassistant/ |

### Supported Technologies

| Technology | Type | Skill File |
|------------|------|------------|
| Java | Language | .junie/skills/java/ |
| TypeScript | Language | .junie/skills/typescript/ |
| Python | Language | .junie/skills/python/ |
| Spring Boot | Framework | .junie/skills/spring-boot/ |
| Angular | Framework | .junie/skills/angular/ |
| Oracle | Database | .junie/skills/oracle/ |
| MySQL | Database | .junie/skills/mysql/ |
| Maven | Build Tool | .junie/skills/maven/ |
| Git | Version Control | .junie/skills/git/ |
| JUnit | Testing | .junie/skills/junit/ |
| Jest | Testing | .junie/skills/jest/ |
| Global | General | .junie/skills/global/ |
| Speckit | Toolkit | .junie/skills/speckit/ |

### Unified Commands

| Command | Purpose | Files |
|---------|---------|-------|
| /review | Review code against standards | .claude/skills/review.md, .junie/commands/review.md, .windsurf/workflows/review.md |
| /plan | Create implementation plan | .claude/skills/plan.md, .junie/commands/plan.md, .windsurf/workflows/plan.md |
| /test-generate | Generate unit tests | .claude/skills/test-generate.md, .junie/commands/test-generate.md, .windsurf/workflows/test-generate.md |
| /git-commit | Create conventional commit | .claude/skills/git-commit.md, .junie/commands/git-commit.md, .windsurf/workflows/git-commit.md |
| /speckit.specify | Create feature specification | .junie/commands/speckit.specify.md, .windsurf/workflows/speckit.specify.md |
| /speckit.plan | Create implementation plan | .junie/commands/speckit.plan.md, .windsurf/workflows/speckit.plan.md |
| /speckit.tasks | Generate task list | .junie/commands/speckit.tasks.md, .windsurf/workflows/speckit.tasks.md |
| /speckit.validate | Validate artifacts | .junie/commands/speckit.validate.md, .windsurf/workflows/speckit.validate.md |
| /speckit.analyze | Analyze gaps | .junie/commands/speckit.analyze.md, .windsurf/workflows/speckit.analyze.md |
| /speckit.implement | Generate runbook | .junie/commands/speckit.implement.md, .windsurf/workflows/speckit.implement.md |
| /speckit.clarify | Generate questions | .junie/commands/speckit.clarify.md, .windsurf/workflows/speckit.clarify.md |
| /speckit.checklist | Generate checklist | .junie/commands/speckit.checklist.md, .windsurf/workflows/speckit.checklist.md |
| /speckit.document-generate | Generate BA documents | .junie/commands/speckit.document-generate.md, .windsurf/workflows/speckit.document-generate.md |
| /speckit.constitution | Create constitution | .windsurf/workflows/speckit.constitution.md |

### Deployment Scripts

| Script | Purpose | Platform |
|--------|---------|----------|
| install.sh | Unified install for all agents | Linux/macOS |
| install.ps1 | Unified install for all agents | Windows |
| sync-claude.sh | Deploy skills to Claude Code | Linux/macOS |
| sync-claude.ps1 | Deploy skills to Claude Code | Windows |
| sync-codex.sh | Deploy skills to Codex | Linux/macOS |
| sync-codex.ps1 | Deploy skills to Codex | Windows |
| new-skill.sh | Scaffold new technology support | Linux/macOS |
| new-skill.ps1 | Scaffold new technology support | Windows |
| check-command-parity.sh | Validate unified command parity | Linux/macOS |
| check-command-parity.ps1 | Validate unified command parity | Windows |
