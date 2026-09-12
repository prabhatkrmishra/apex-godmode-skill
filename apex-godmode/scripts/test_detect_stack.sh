#!/usr/bin/env bash
set -eu
SCRIPT="$(cd "$(dirname "$0")" && pwd)/detect-stack.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

mk() { mkdir -p "$1"; }
contains() { printf '%s\n' "$1" | grep -Fq "$2"; }

mk "$TMP/spring/p1/src/main/java"
cat > "$TMP/spring/pom.xml" <<'XML'
<project><parent><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-parent</artifactId><version>3.5.16</version></parent></project>
XML
printf '@SpringBootApplication class App {}\n' > "$TMP/spring/p1/src/main/java/App.java"

mk "$TMP/react"
cat > "$TMP/react/package.json" <<'JSON'
{"dependencies":{"react":"19.1.0","vite":"7.0.0"}}
JSON

mk "$TMP/angular"
cat > "$TMP/angular/angular.json" <<'JSON'
{"version":1,"projects":{}}
JSON

mk "$TMP/python"
cat > "$TMP/python/pyproject.toml" <<'TOML'
[project]
dependencies=["fastapi>=0.1"]
TOML
printf 'from fastapi import FastAPI\napp = FastAPI()\n' > "$TMP/python/app.py"

mk "$TMP/dotnet"
cat > "$TMP/dotnet/App.csproj" <<'XML'
<Project Sdk="Microsoft.NET.Sdk.Web"><PropertyGroup><TargetFramework>net8.0</TargetFramework></PropertyGroup></Project>
XML

mk "$TMP/go"
printf 'module example.com/app\n\ngo 1.24\n' > "$TMP/go/go.mod"
printf 'package main\nimport _ "github.com/gin-gonic/gin"\n' > "$TMP/go/main.go"

mk "$TMP/unknown"
echo 'hello' > "$TMP/unknown/README.md"

mk "$TMP/nodeproj/node_modules/fake"
printf '{"dependencies":{"react":"999.0.0"}}\n' > "$TMP/nodeproj/node_modules/fake/package.json"
mk "$TMP/nodeproj/src"
printf '{"dependencies":{"vite":"7.0.0"}}\n' > "$TMP/nodeproj/package.json"
printf 'const x = 1\n' > "$TMP/nodeproj/src/a.js"
out=$(cd "$TMP/nodeproj" && "$SCRIPT")
if printf '%s\n' "$out" | grep -q '999.0.0'; then echo 'unexpected dependency-directory traversal'; exit 1; fi

out=$(cd "$TMP/spring" && "$SCRIPT")
contains "$out" 'FRAMEWORK Spring Boot confidence=high'
contains "$out" 'MANIFEST ./pom.xml'

out=$(cd "$TMP/react" && "$SCRIPT")
contains "$out" 'FRAMEWORK React confidence=high'
contains "$out" 'BUILD Vite confidence=high'

out=$(cd "$TMP/angular" && "$SCRIPT")
contains "$out" 'FRAMEWORK Angular confidence=high'

out=$(cd "$TMP/python" && "$SCRIPT")
contains "$out" 'FRAMEWORK FastAPI confidence=high'

out=$(cd "$TMP/dotnet" && "$SCRIPT")
contains "$out" 'FRAMEWORK ASP.NET-Core confidence=high'

out=$(cd "$TMP/go" && "$SCRIPT")
contains "$out" 'FRAMEWORK Gin confidence=high'
contains "$out" 'REPO_SHAPE' || true

out=$(cd "$TMP/unknown" && "$SCRIPT")
if printf '%s\n' "$out" | grep -Eq 'FRAMEWORK |LANGUAGE '; then
  echo 'unexpected strong framework/language detection for unknown repo' >&2
  exit 1
fi

echo 'detect-stack broad matrix: PASS'
