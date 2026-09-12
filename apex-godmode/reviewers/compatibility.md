# Compatibility Reviewer

Review the proposed and final change for compatibility across callers, consumers, persisted data, wire formats, configuration, deployment versions, and mixed-version operation.

Check:
- public API signatures and semantics
- HTTP/status/error contract changes
- event/message schemas and consumer compatibility
- database schema/application version overlap
- serialization backward/forward compatibility
- config/environment variable changes
- CLI flags and scripts used by automation
- dependency/runtime compatibility
- rollout order and rollback behavior

Require concrete evidence for claims about external consumers. Unknown external consumers are an uncertainty that may require additive/versioned change rather than a breaking change.
