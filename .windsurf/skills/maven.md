# Maven Skill

## Key Principles
- **Dependency Management**: Use `<dependencyManagement>` for consistent versions across modules.
- **Properties**: Use properties for version numbers and build settings.
- **Profiles**: Use profiles for environment-specific configurations (dev, test, prod).
- **Plugins**: Use standard plugins for build, test, and package phases.

## Best Practices
- Avoid hardcoded versions in dependencies; use properties or dependency management.
- Minimize transitive dependencies using `<exclusions>` when necessary.
- Use `mvn dependency:analyze` to find unused/undeclared dependencies.
- Keep `pom.xml` clean and well-structured.

## Common Commands
- `mvn clean install`: Build and install to local repository.
- `mvn test`: Run unit tests.
- `mvn dependency:tree`: Display the dependency hierarchy.
- `mvn spring-boot:run`: Run a Spring Boot application.

## Checklist
- [ ] Are versions centralized in properties or `<dependencyManagement>`?
- [ ] Are there any unused dependencies?
- [ ] Is the `pom.xml` following the standard structure?
- [ ] Are plugins configured with explicit versions?
