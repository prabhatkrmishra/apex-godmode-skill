#!/usr/bin/env bash
set -u
printf '%s\n' '## Stack hints'
for f in package.json pyproject.toml requirements.txt go.mod Cargo.toml pom.xml build.gradle settings.gradle composer.json Gemfile mix.exs; do
  if [ -f "$f" ]; then printf '%s\n' "FOUND $f"; fi
done
[ -f package.json ] && command -v node >/dev/null 2>&1 && node --version || true
[ -f package.json ] && command -v npm >/dev/null 2>&1 && npm --version || true
[ -f go.mod ] && command -v go >/dev/null 2>&1 && go version || true
[ -f Cargo.toml ] && command -v rustc >/dev/null 2>&1 && rustc --version || true
[ -f pyproject.toml ] && command -v python >/dev/null 2>&1 && python --version || true
