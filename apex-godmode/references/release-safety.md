# Release Safety and Reversibility

Before completing a change that can affect production behavior, determine whether it is safely reversible.

## Required assessment

Record:
- deployment unit(s)
- compatibility window
- rollback mechanism
- data/schema reversibility
- configuration rollback
- feature-flag capability
- migration forward/backward compatibility
- cache/session invalidation risk
- queue/message compatibility
- external API compatibility

## Rules

Prefer additive and backward-compatible changes when the system cannot atomically roll back code and data together.

For destructive schema/data changes, do not declare complete without an explicit migration/rollback decision. A rollback of application code does not imply rollback of persisted data.

For public APIs/events, assess consumers outside the repository. Unknown consumers are an uncertainty, not proof of safety.

For configuration changes, verify defaults and startup behavior in the deployed environment when practical.

## Evidence

A release-safety check must state whether rollback was:
- tested
- simulated
- documented only
- unavailable

Never claim a rollback is safe merely because `git revert` exists.
