# Change Impact Analysis

Detection answers what exists. Impact analysis answers what the proposed change can affect.

## Required before implementation

Build an impact map from the current diff/task plus repository evidence:
- directly edited files
- public APIs/types/events
- callers/importers/consumers
- persistence schemas and serialized formats
- configuration/env vars
- background jobs/queues
- network boundaries
- auth/security boundaries
- observability/alerts/dashboards
- deployment/infra manifests
- tests and fixtures
- generated code or codegen inputs

Classify each edge as:
- direct
- transitive
- runtime-only
- operational
- uncertain

## Blast-radius rules

A change is high-impact when it crosses a public contract, persistence boundary, deployment boundary, auth boundary, or more than one independently executed component.

Do not infer impact solely from file count. A one-line change to a shared contract can exceed the risk of a 20-file local refactor.

## Verification mapping

For every high-impact edge, record at least one verification method. Examples:
- API contract -> contract/integration test
- schema -> migration + compatibility check
- auth -> negative authorization test
- queue -> retry/idempotency test
- deployment -> config/render/plan validation
- serialization -> backward/forward compatibility fixture

## Final re-check

After implementation, compare the actual diff to the predicted impact map. Any newly discovered affected boundary must trigger re-routing and additional verification before completion.
