# API and Contract Compatibility

For public APIs, events, schemas, serialized objects, RPCs, CLI interfaces, or externally consumed configuration:

1. identify consumers inside and outside the repository when evidence is available
2. classify the change as additive, compatible-with-defaults, behavior-changing, or breaking
3. check versioning/deprecation policy and current framework guidance
4. test old/new representation compatibility where relevant
5. verify error/status semantics, defaults, nullability, ordering, and idempotency where contractually visible
6. document migration requirements for deliberate breaking changes

Unknown consumers are uncertainty, not proof of safety.
