# Workspace Isolation and Rollback

Protect unrelated user work while implementing changes.

## Baseline

Capture repository status, current branch/commit, and relevant uncommitted changes before editing.

Do not discard, reset, stash, clean, or overwrite unrelated user changes without explicit authorization.

## Isolation preference

When the host supports safe isolated worktrees, clones, or equivalent sandboxes, prefer them for broad, high-risk, or autonomous changes. When isolation is unavailable, operate in place but preserve a precise before/after diff and avoid broad cleanup commands.

## Rollback

Prefer targeted revert of the current change rather than repository-wide reset. For data/schema changes, code rollback is not assumed to restore data compatibility; use the release-safety assessment.

## Generated and temporary artifacts

Keep temporary artifacts outside the repository when practical. Before finalization, distinguish intentional outputs from incidental tool/cache files and remove only artifacts created by the current run when safe.
