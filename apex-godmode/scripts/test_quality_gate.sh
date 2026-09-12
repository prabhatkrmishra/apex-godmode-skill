#!/usr/bin/env bash
set -euo pipefail
BASE="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
GATE="$BASE/quality_gate.sh"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/unknown"
echo '# Unknown project' > "$TMP/unknown/README.md"
status=0
(cd "$TMP/unknown" && "$GATE" >/dev/null 2>&1) || status=$?
[ "$status" -eq 3 ] || { echo "FAIL: expected 3 for no checks, got $status"; exit 1; }

mkdir -p "$TMP/spring"
cat > "$TMP/spring/pom.xml" <<'EOF'
<project><parent><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-parent</artifactId><version>3.5.16</version></parent></project>
EOF
cat > "$TMP/spring/mvnw" <<'EOF'
#!/usr/bin/env bash
[ "${1:-}" = test ]
EOF
chmod +x "$TMP/spring/mvnw"
(cd "$TMP/spring" && "$GATE" >/dev/null)


mkdir -p "$TMP/mixed/modules/node" "$TMP/mixed/modules/python"
cat > "$TMP/mixed/package.json" <<'JSON'
{"name":"root-only","private":true}
JSON
cat > "$TMP/mixed/modules/node/package.json" <<'JSON'
{"scripts":{"test":"node -e \"process.exit(0)\""}}
JSON
cat > "$TMP/mixed/modules/python/pyproject.toml" <<'TOML'
[project]
name = "fixture"
TOML
# Stub tools so this regression test is deterministic and offline.
mkdir -p "$TMP/bin"
cat > "$TMP/bin/npm" <<'EOF'
#!/usr/bin/env bash
[ "${1:-}" = test ]
EOF
cat > "$TMP/bin/pytest" <<'EOF'
#!/usr/bin/env bash
exit 0
EOF
chmod +x "$TMP/bin/npm" "$TMP/bin/pytest"
status=0
out=$(cd "$TMP/mixed" && PATH="$TMP/bin:$PATH" "$GATE" 2>&1) || status=$?
[ "$status" -eq 0 ] || { echo "FAIL: nested Node/Python modules were not verified, status=$status"; printf '%s\n' "$out"; exit 1; }
printf '%s\n' "$out" | grep -Fq '==> npm test' || { echo 'FAIL: nested Node module did not execute'; exit 1; }
printf '%s\n' "$out" | grep -Fq '==> pytest -q' || { echo 'FAIL: nested Python module did not execute'; exit 1; }

echo 'PASS: quality_gate ecosystem matrix'

# A repository with a root test script plus an independent nested module must
# not suppress nested-module verification.
mkdir -p "$TMP/rootplus/modules/python"
cat > "$TMP/rootplus/package.json" <<'JSON'
{"scripts":{"test":"true"}}
JSON
cat > "$TMP/rootplus/modules/python/pyproject.toml" <<'TOML'
[project]
name = "nested"
TOML
status=0
out=$(cd "$TMP/rootplus" && PATH="$TMP/bin:$PATH" "$GATE" 2>&1) || status=$?
[ "$status" -eq 0 ] || { echo "FAIL: nested module coverage regressed, status=$status"; printf '%s\n' "$out"; exit 1; }
printf '%s\n' "$out" | grep -Fq '==> npm test' || { echo 'FAIL: root test was not executed'; exit 1; }
printf '%s\n' "$out" | grep -Fq '==> pytest -q' || { echo 'FAIL: nested Python test was suppressed'; exit 1; }

# A real test failure must remain a FAIL (exit 1), not become missing-tool UNVERIFIED (exit 3).
mkdir -p "$TMP/failing" "$TMP/fail-bin"
cat > "$TMP/failing/package.json" <<'JSON'
{"scripts":{"test":"anything"}}
JSON
cat > "$TMP/fail-bin/npm" <<'EOF'
#!/usr/bin/env bash
[ "${1:-}" = test ] && exit 7
exit 2
EOF
chmod +x "$TMP/fail-bin/npm"
status=0
out=$(cd "$TMP/failing" && PATH="$TMP/fail-bin:$PATH" "$GATE" 2>&1) || status=$?
[ "$status" -eq 1 ] || { echo "FAIL: command failure misclassified as unavailable, status=$status"; printf '%s\n' "$out"; exit 1; }
if printf '%s\n' "$out" | grep -Fq 'UNVERIFIED:'; then
  echo 'FAIL: failed executable check was mislabeled UNVERIFIED'; exit 1
fi

echo 'PASS: failed-command classification regression'
