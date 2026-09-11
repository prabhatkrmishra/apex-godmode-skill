# Git and Change Safety

Protect user work and keep diffs attributable.

Before edits:
- inspect `git status` when in a Git repository
- do not overwrite unrelated user changes
- identify generated/vendor/build directories that should not be hand-edited

During edits:
- prefer surgical changes
- inspect diff after each material unit
- keep unrelated formatting churn out
- track newly created files

Before delivery:
- inventory tracked + untracked changes
- inspect diff/stat
- confirm no accidental secrets, credentials, dumps, build artifacts, or private logs were added
- confirm intended files are included

Never reset, clean, checkout, rebase, force-push, or discard unrelated work without explicit authorization.
