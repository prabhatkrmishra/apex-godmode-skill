#!/usr/bin/env bash
set -u
printf '%s\n' '## Changed files'
git status --short 2>/dev/null || true
printf '%s\n' '' '## Diff stat'
git diff --stat 2>/dev/null || true
printf '%s\n' '' '## Untracked files'
git ls-files --others --exclude-standard 2>/dev/null || true
