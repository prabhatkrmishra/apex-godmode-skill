#!/usr/bin/env bash
set -euo pipefail

# Validate the minimum structure of a factual evidence ledger.
# This intentionally does not decide whether evidence is true; it checks that
# each entry records a status, command/evidence, and result when applicable.
# Usage: evidence_gate.sh <evidence-file>

file="${1:-}"
if [ -z "$file" ]; then
  echo 'usage: evidence_gate.sh <evidence-file>' >&2
  exit 2
fi
[ -f "$file" ] || { echo "FAIL: evidence file not found: $file"; exit 1; }

fail=0

# Require at least one valid status token somewhere in the evidence file.
if ! grep -Eiq '\b(PASS|FAIL|BLOCKED|UNVERIFIED|SKIPPED)\b' "$file"; then
  echo 'FAIL: evidence file contains no recognized gate status'
  fail=1
fi

# The ledger format requires an Evidence/command field and a Result field.
# Accept markdown tables and key/value-style records.
if ! grep -Eiq '\b(command|evidence)\b' "$file"; then
  echo "FAIL: evidence file does not contain an 'evidence' or 'command' field"
  fail=1
fi
if ! grep -Eiq '\bresult\b' "$file"; then
  echo "FAIL: evidence file does not contain a 'result' field"
  fail=1
fi

# 'not run' or similar is a legitimate factual disclosure and must not fail
# the checker by itself. What is forbidden is claiming a PASS without evidence.
if grep -Eiq '\bPASS\b' "$file" && grep -Eiq '\b(pretend|fabricat(e|ed|ion))\b' "$file"; then
  echo 'FAIL: evidence file pairs PASS with fabrication/pretend language'
  fail=1
fi

# A PASS must not be accompanied by an explicit statement that the same
# check was not run. This is a lightweight contradiction detector.
if grep -Eiq '\bPASS\b' "$file" && grep -Eiq '\b(not run|did not run|not executed|never executed)\b' "$file"; then
  echo 'FAIL: evidence file contains PASS together with an unexecuted-check claim'
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo 'PASS: evidence structure is internally consistent enough for review'
else
  exit 1
fi
