#!/usr/bin/env bash
set -u
fail=0
run(){ printf '\n==> %s\n' "$*"; "$@" || fail=1; }

# Prefer explicit repository scripts; fall back only when the project clearly exposes a conventional tool.
if [ -f package.json ] && command -v npm >/dev/null 2>&1; then
  if node -e "const p=require('./package.json'); process.exit(p.scripts?.test?0:1)" 2>/dev/null; then run npm test; fi
  if node -e "const p=require('./package.json'); process.exit(p.scripts?.build?0:1)" 2>/dev/null; then run npm run build; fi
fi
if [ -f pyproject.toml ] && command -v pytest >/dev/null 2>&1; then run pytest -q; fi
if [ -f go.mod ] && command -v go >/dev/null 2>&1; then run go test ./...; fi
if [ -f Cargo.toml ] && command -v cargo >/dev/null 2>&1; then run cargo test; fi
exit "$fail"
