#!/usr/bin/env bash
set -euo pipefail
BASE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
fail=0

[ -f "$BASE/SKILL.md" ] || { echo 'FAIL: missing SKILL.md'; fail=1; }
count=$(find "$BASE" -type f -name SKILL.md | wc -l | tr -d ' ')
[ "$count" = 1 ] || { echo "FAIL: expected one SKILL.md, found $count"; fail=1; }

refs=$(grep -RhoE '(modes|phases|references|reviewers|schemas|scripts)/[A-Za-z0-9._/-]+\.(md|sh)' "$BASE/SKILL.md" | sort -u || true)
while IFS= read -r ref; do
  [ -z "$ref" ] && continue
  [ -f "$BASE/$ref" ] || { echo "FAIL: missing referenced file $ref"; fail=1; }
done <<< "$refs"

for f in $(find "$BASE" -type f -name '*.sh' -print); do bash -n "$f" || fail=1; done

# Validate path-like references used inside all Markdown support files.
while IFS= read -r ref; do
  [ -z "$ref" ] && continue
  [ -f "$BASE/$ref" ] || { echo "FAIL: missing internal Markdown/script reference $ref"; fail=1; }
done < <(grep -RhoE '(modes|phases|references|reviewers|schemas|scripts)/[A-Za-z0-9._/-]+\.(md|sh)' "$BASE" --include='*.md' | sort -u || true)

# Self-reference note: this validator contains scan patterns by design; package-level scans exclude this validator.
# Detect leaked session-specific artifacts in skill content.
if grep -RniE 'turn[0-9]+file[0-9]+|sandbox:/|/mnt/data/|file_[0-9]{8,}' "$BASE" --exclude='audit_skill.sh' >/dev/null 2>&1; then
  echo 'FAIL: session-specific/container artifact found'; fail=1
fi

# Detect obviously unsafe direct secret handling patterns in instructions.
if grep -RniE 'echo .*(API_KEY|TOKEN|PASSWORD|SECRET)|cat .*(API_KEY|TOKEN|PASSWORD|SECRET)' "$BASE" --include='*.md' >/dev/null 2>&1; then
  echo 'FAIL: possible secret disclosure instruction found'; fail=1
fi

if [ "$fail" -eq 0 ]; then echo 'PASS: Apex deep self-audit'; else exit 1; fi
