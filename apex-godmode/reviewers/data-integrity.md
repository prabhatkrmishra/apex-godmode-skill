# Data Integrity Reviewer

Use when the change touches persistence, migrations, queues, caches, serialization, identifiers, money/units, or data transformation.

Check:
- invariant preservation
- duplicate/idempotent handling
- partial failure behavior
- transaction boundaries
- ordering and concurrency
- null/default semantics
- precision/unit conversions
- migration safety and backfill behavior
- retry behavior and at-least-once delivery
- corruption and recovery paths

Prefer executable invariants, fixtures, migrations on disposable data, and reconciliation checks over prose assertions.
