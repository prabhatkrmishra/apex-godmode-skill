# Observability / Recovery Reviewer

Review runtime behavior where relevant:
- errors are observable and actionable
- retries have bounded behavior
- timeouts/cancellation are handled
- state recovery is deterministic enough to diagnose
- metrics/logs/traces preserve useful failure evidence
- no secrets or sensitive payloads are leaked into logs

Focus on failure paths, not just happy-path instrumentation.
