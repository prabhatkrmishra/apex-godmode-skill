#!/usr/bin/env bash
set -euo pipefail
BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
fail=0

[ -f "$BASE/SKILL.md" ] || { echo "FAIL: missing SKILL.md"; fail=1; }
count=$(find "$BASE" -type f -name 'SKILL.md' | wc -l | tr -d ' ')
[ "$count" = 1 ] || { echo "FAIL: expected exactly 1 SKILL.md, found $count"; fail=1; }

for f in "$BASE"/SKILL.md "$BASE"/modes/*.md "$BASE"/phases/*.md "$BASE"/references/*.md "$BASE"/reviewers/*.md "$BASE"/schemas/*.md; do
  [ -f "$f" ] || continue
  # Keep the validator's own check expression out of the scanned Markdown set.
  # The package-level CI scan should inspect the complete archive separately.
  if grep -Eiq 'open[[:space:]]*code' "$f"; then
    echo "FAIL: excluded-platform reference in $f"
    fail=1
  fi
done

if ! head -n 8 "$BASE/SKILL.md" | grep -q '^name: apex-godmode$'; then
  echo 'FAIL: SKILL.md name frontmatter missing'
  fail=1
fi
if ! head -n 8 "$BASE/SKILL.md" | grep -q '^description:'; then
  echo 'FAIL: SKILL.md description frontmatter missing'
  fail=1
fi

for script in "$BASE"/scripts/*.sh; do
  [ -f "$script" ] || continue
  bash -n "$script" || fail=1
done

if [ "$fail" -eq 0 ]; then echo 'PASS: skill structure and shell syntax'; else exit 1; fi
