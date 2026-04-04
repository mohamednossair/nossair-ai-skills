---
description: Help with Maven POM, dependency management, build configuration, and multi-module projects
---
Help with the described Maven problem or review the provided POM.

## Dependency Issues
- Declare all versions in `<properties>` — flag inline hardcoded versions
- Identify conflicting transitive dependencies via `dependency:tree`
- Recommend `<dependencyManagement>` in parent POM for shared versions
- Check `scope`: `compile` (default), `test`, `provided`, `runtime`
- Use Spring Boot BOM for Spring ecosystem deps — no manual version management needed

## Build Configuration
- `maven-compiler-plugin`: verify Java version matches `<java.version>` property
- `spring-boot-maven-plugin`: required for executable JAR
- `maven-surefire-plugin`: JUnit 5 requires `>=2.22.x`
- `maven-failsafe-plugin`: for integration tests (`*IT.java`)

## Multi-Module
- Parent POM: `<packaging>pom</packaging>`, no production code
- `<modules>` section lists child modules
- Child modules inherit parent `<properties>` and `<dependencyManagement>`
- Build specific module: `mvn install -pl module-name -am`

## Common Commands to Suggest
```bash
mvn dependency:tree -Dincludes=groupId:artifactId   # find specific dep
mvn dependency:analyze                               # unused/undeclared
mvn versions:display-dependency-updates              # outdated deps
mvn versions:display-plugin-updates                 # outdated plugins
mvn clean install -DskipTests                        # fast build
mvn clean package -P prod                            # with profile
```

## Profiles
- Use profiles for environment-specific config: `<profiles><profile><id>prod</id>...`
- Activate by default or by `-P profile-name`
- Never put secrets in POM — use CI env vars

Provide the corrected/recommended POM snippet with explanation.
