# Spring Boot Detection and Research Profile

Spring Boot must be detected as a framework, not merely as “Java + Maven/Gradle”. Use repository evidence before implementation.

## Strong fingerprints

Treat the repository as Spring Boot when any of these are found:

- Maven `pom.xml` contains `org.springframework.boot`, a Spring Boot starter, `spring-boot-starter-parent`, or `spring-boot-maven-plugin`.
- Gradle `build.gradle` / `build.gradle.kts` contains the `org.springframework.boot` plugin, a Spring Boot starter, or Boot dependency-management configuration.
- Source contains `@SpringBootApplication` or imports from `org.springframework.boot`.

Check **all modules**; do not inspect only the repository root. Multi-module Maven and Gradle projects commonly place Boot configuration in a parent/build-conventions project while application code lives elsewhere.

## Build and version detection

Record:
- Spring Boot version, if explicitly declared or resolved locally
- Spring Framework version when material
- Java version/toolchain
- Maven or Gradle version/wrapper
- Spring Cloud version when present
- material starters/libraries
- changed subsystem: MVC/WebFlux, Security, Data/JPA/JDBC, Kafka, Batch, Actuator, scheduling, configuration, testing, etc.

Prefer wrapper/version-manager evidence (`mvnw`, `gradlew`, toolchains, lockfiles, dependency reports) over a globally installed version.

## Version-resolution rules

If the version is inherited, use the effective build configuration or dependency report when available. Do not infer a precise Boot version from a starter artifact name alone.

For Maven, inspect parent/BOM/plugin configuration and, when practical, use the project wrapper to inspect effective dependency/plugin information.

For Gradle, inspect plugin declarations, version catalogs, convention plugins, dependency management/BOMs, and dependency insight/reporting when practical.

If the exact version remains unknown, record `unknown` and research the nearest applicable official documentation without inventing a version.

## Spring Boot anti-pattern research

Before implementation, research the exact Boot version and affected subsystem. Minimum source set when web access exists:

1. Spring Boot reference documentation for the exact major/minor line.
2. Spring Boot system requirements / release notes / migration guide as relevant.
3. A subsystem-specific official guide (for example Spring Security, Spring Data, Actuator, Web MVC/WebFlux) when that subsystem is changed.
4. Security advisory or CVE information when the change touches security-sensitive dependencies or exposed endpoints.

Current official Spring Boot guidance should be checked at runtime for the detected Boot line. In particular, verify the release's system requirements, supported build tooling, dependency-management conventions, and migration/deprecation guidance. Do not manually override Boot-managed dependency versions without repository-specific justification.

## Common verification targets

The agent should look for, as applicable:

- dependency-version overrides that fight Spring Boot dependency management
- deprecated APIs/configuration for the detected Boot line
- incorrect bean lifecycle or proxy assumptions
- transaction boundary mistakes
- blocking work on reactive stacks
- lazy-loading / N+1 query hazards
- unsafe actuator endpoint exposure
- configuration binding/default-value mistakes
- incorrect exception-to-HTTP mapping
- insecure Spring Security defaults or obsolete configuration APIs
- test slices that omit required infrastructure and create false confidence

These are investigation targets, not unconditional findings. Only report an anti-pattern when repository evidence and current sources support the claim.

## Required output

Write the framework record before planning:

```text
framework: Spring Boot
version: <exact|unknown>
build: Maven|Gradle|unknown
java: <version|unknown>
material_spring_modules: <list>
subsystem: <affected area>
research_sources: <URLs/titles>
antipattern_constraints: <concise rules>
verification_checks: <commands/tests/observations>
```
