# Verification Target Selection

Verification must match the change surface, not merely the repository root.

## Target mapping

Map each changed file to its owning module/package/service. For each affected module identify the narrowest native test command that proves the changed behavior, then select broader checks by risk:

- unit/local behavior -> focused tests first
- public API/event/serialization -> contract or compatibility checks
- persistence/schema -> migration + integration/fixture compatibility
- frontend/UI -> component + type/build + relevant browser/runtime path
- cross-module change -> affected module tests plus integration boundary
- dependency/runtime change -> dependency resolution + build + regression suite
- deployment/infrastructure -> syntax/render/plan validation; do not apply infrastructure unless authorized

## Root orchestration proof

A root command may stand in for child-module checks only when repository evidence demonstrates orchestration, such as:
- Maven reactor `<modules>` or a verified multi-module Maven command
- Gradle settings/project graph with the target included
- a workspace tool configured to include the affected package
- a repository-native CI command documented to execute the affected modules

A root script named `test` or `build` by itself is not proof of full workspace coverage.

## Selection evidence

Record:
- affected modules
- selected command per module
- why the command covers the changed behavior
- broader checks selected or intentionally omitted

Never manufacture coverage from the existence of a test command alone.
