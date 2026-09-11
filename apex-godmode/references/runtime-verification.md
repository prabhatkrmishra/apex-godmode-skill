# Runtime Verification Matrix

Use actual runtime behavior when the task changes externally observable behavior.

## Select the strongest feasible check

CLI/tool:
- invoke the command
- capture exit code
- inspect stdout/stderr

HTTP/API:
- start the service if safe
- call the affected endpoint
- verify status, response shape, headers, auth behavior, and failure cases

Web UI:
- navigate to the affected flow
- exercise success and failure paths
- verify visible state, persistence, navigation, and console/runtime errors when tooling allows

Worker/queue:
- submit an input
- observe processing
- verify success, retry, timeout, cancellation, and duplicate behavior as relevant

Database/migration:
- verify schema/data before and after where safe
- verify indexes/constraints/query behavior
- test rollback or failure semantics when feasible

## Rule

Do not substitute a unit test for an integration/runtime property that the unit test does not establish. Use the strongest check that is safe and available.
