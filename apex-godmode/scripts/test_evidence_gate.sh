#!/usr/bin/env bash
set -euo pipefail
BASE="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
GATE="$BASE/evidence_gate.sh"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/pass.md" <<'EOT'
| ID | Evidence | Result |
|---|---|---|
| T1 | `npm test` | PASS |
EOT
"$GATE" "$TMP/pass.md" >/dev/null

cat > "$TMP/blocked.md" <<'EOT'
| ID | Evidence | Result |
|---|---|---|
| T2 | browser unavailable; test not run | UNVERIFIED |
EOT
"$GATE" "$TMP/blocked.md" >/dev/null

cat > "$TMP/bad.md" <<'EOT'
| ID | Evidence | Result |
|---|---|---|
| T3 | no command executed; pretend result | PASS |
EOT
if "$GATE" "$TMP/bad.md" >/dev/null 2>&1; then
  echo 'FAIL: contradictory/fabricated evidence was accepted'
  exit 1
fi

echo 'PASS: evidence_gate regression tests'
