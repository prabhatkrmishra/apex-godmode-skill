# Phase 1 — Deep Reconnaissance

Read repository-local instructions first. Then trace the feature through the repository.

## Inspect as relevant

- entrypoints and public interfaces
- callers/consumers
- types/schemas/contracts
- state and data flow
- side effects/lifecycle
- configuration and environment
- tests and fixtures
- CI/build/deployment
- security boundaries
- observability/recovery paths

Do not literally read every file. Read the files and adjacent artifacts necessary to establish a reliable scope map. Expand outward when evidence shows coupling.

## Output

Create an internal map of:
- affected files
- dependencies
- contracts
- risks
- likely regression surfaces
- missing evidence

Run bundled detection helpers when useful; inspect their output before acting.
