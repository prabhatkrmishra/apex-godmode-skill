#!/usr/bin/env bash
set -euo pipefail
BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
fail=0

[ -f "$BASE/SKILL.md" ] || { echo "FAIL: missing SKILL.md"; fail=1; }
count=$(find "$BASE" -type f -name 'SKILL.md' | wc -l | tr -d ' ')
[ "$count" = 1 ] || { echo "FAIL: expected exactly 1 SKILL.md, found $count"; fail=1; }

if ! head -n 10 "$BASE/SKILL.md" | grep -q '^name: apex-godmode$'; then
  echo 'FAIL: SKILL.md name frontmatter missing'
  fail=1
fi
if ! head -n 10 "$BASE/SKILL.md" | grep -q '^description:'; then
  echo 'FAIL: SKILL.md description frontmatter missing'
  fail=1
fi
if ! head -n 10 "$BASE/SKILL.md" | grep -q '^version: 4\.1\.0$'; then
  echo 'FAIL: SKILL.md version must be 4.1.0'
  fail=1
fi

# Validate all Markdown references explicitly listed by the root controller.
while IFS= read -r rel; do
  [ -f "$BASE/$rel" ] || { echo "FAIL: referenced file missing: $rel"; fail=1; }
done < <(grep -oE '(modes|phases|references|reviewers|schemas|scripts)/[A-Za-z0-9._/-]+\.md' "$BASE/SKILL.md" | sort -u)

for script in "$BASE"/scripts/*.sh; do
  [ -f "$script" ] || continue
  bash -n "$script" || fail=1
done

# Deliberately scan content files, excluding this validator to avoid self-match.
for dir in modes phases references reviewers schemas; do
  while IFS= read -r f; do
    if grep -Eiq 'open[[:space:]]*code|opencode' "$f"; then
      echo "FAIL: excluded-platform reference in $f"
      fail=1
    fi
  done < <(find "$BASE/$dir" -type f -name '*.md')
done

[ "$fail" -eq 0 ] && echo 'PASS: skill structure, references, metadata, and shell syntax' || exit 1
