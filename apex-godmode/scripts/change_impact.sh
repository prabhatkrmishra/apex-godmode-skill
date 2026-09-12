#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
cd "$ROOT" 2>/dev/null || { echo 'ERROR unable to enter repository root' >&2; exit 2; }

echo '## Apex change-impact baseline'

git status --short 2>/dev/null || true
git diff --name-status 2>/dev/null || true

echo '### High-impact file classes'
git diff --name-only 2>/dev/null | grep -E '(^|/)(pom.xml|build.gradle(\.kts)?|package.json|go.mod|Cargo.toml|.*\.csproj|.*\.fsproj|.*\.slnx?|pyproject.toml|Gemfile|mix.exs|pubspec.yaml|Package.swift|Dockerfile|compose\.ya?ml|Chart.yaml|.*\.tf|.*migration.*|.*schema.*|.*openapi.*|.*graphql.*)$' || true

echo '### Contract-like source changes'
git diff --name-only 2>/dev/null | grep -Ei '(api|controller|route|handler|schema|model|entity|dto|event|message|proto|graphql|openapi|migration|config|security|auth|middleware|queue|worker|job|serializer|deserial)' || true
