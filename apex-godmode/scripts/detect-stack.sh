#!/usr/bin/env bash
set -u

printf '%s\n' '## Apex stack detection v3'
ROOT="${1:-.}"
cd "$ROOT" 2>/dev/null || { echo 'ERROR unable to enter repository root' >&2; exit 2; }

find_repo() {
  find . \
    \( -name .git -o -name node_modules -o -name .venv -o -name venv -o -name target \
       -o -name build -o -name dist -o -name out -o -name vendor -o -name .gradle \
       -o -name coverage -o -name .next -o -name .turbo -o -name __pycache__ \
       -o -name .idea -o -name .vscode -o -name .gradle-cache \
    \) -prune -o "$@" 2>/dev/null
}

has_repo_file() { find_repo -type f -name "$1" -print -quit | grep -q .; }
repo_grep() {
  local pattern="$1"; shift
  find_repo -type f "$@" -print0 | xargs -0 -r grep -liE "$pattern" 2>/dev/null | head -n 1
}
repo_grep_any() {
  local pattern="$1"; shift
  find_repo -type f "$@" -print0 | xargs -0 -r grep -liE "$pattern" 2>/dev/null | grep -q .
}

printf '%s\n' '### Manifests / toolchain files'
find_repo -type f \( \
  -name 'package.json' -o -name 'pnpm-workspace.yaml' -o -name 'yarn.lock' -o -name 'pnpm-lock.yaml' -o -name 'package-lock.json' -o -name 'bun.lock' -o -name 'bun.lockb' -o \
  -name 'pyproject.toml' -o -name 'requirements.txt' -o -name 'Pipfile' -o -name 'Pipfile.lock' -o -name 'poetry.lock' -o -name 'uv.lock' -o -name 'pdm.lock' -o -name 'setup.py' -o -name 'setup.cfg' -o \
  -name 'go.mod' -o -name 'go.work' -o -name 'Cargo.toml' -o -name 'Cargo.lock' -o \
  -name 'pom.xml' -o -name 'build.gradle' -o -name 'build.gradle.kts' -o -name 'settings.gradle' -o -name 'settings.gradle.kts' -o -name 'gradle.properties' -o -name 'gradle-wrapper.properties' -o \
  -name '*.csproj' -o -name '*.fsproj' -o -name '*.sln' -o -name '*.slnx' -o -name 'Directory.Build.props' -o -name 'Directory.Packages.props' -o \
  -name 'composer.json' -o -name 'composer.lock' -o -name 'Gemfile' -o -name 'Gemfile.lock' -o -name 'mix.exs' -o -name 'mix.lock' -o \
  -name 'pubspec.yaml' -o -name 'pubspec.lock' -o -name 'Package.swift' -o -name 'Package.resolved' -o \
  -name 'CMakeLists.txt' -o -name 'meson.build' -o -name 'Dockerfile' -o -name 'compose.yaml' -o -name 'docker-compose.yml' -o \
  -name 'Chart.yaml' -o -name 'terragrunt.hcl' -o -name '*.tf' -o -name '*.tfvars' -o -name '.nvmrc' -o -name '.python-version' -o -name '.tool-versions' -o -name 'runtime.txt' \
\) | sort | while IFS= read -r f; do printf 'MANIFEST %s\n' "$f"; done

printf '%s\n' '### Languages'
for spec in \
  'Java:*.java' 'Kotlin:*.kt' 'Groovy:*.groovy' 'TypeScript:*.ts' 'TSX:*.tsx' 'JavaScript:*.js' 'JSX:*.jsx' \
  'Python:*.py' 'Go:*.go' 'Rust:*.rs' 'CSharp:*.cs' 'FSharp:*.fs' 'PHP:*.php' 'Ruby:*.rb' 'Elixir:*.ex' 'Elixir:*.exs' \
  'Dart:*.dart' 'Swift:*.swift' 'ObjectiveC:*.m' 'C:*.c' 'CXX:*.cpp'; do
  lang=${spec%%:*}; pat=${spec#*:}
  if find_repo -type f -name "$pat" -print -quit | grep -q .; then printf 'LANGUAGE %s\n' "$lang"; fi
done

printf '%s\n' '### Project-declared toolchains'
for f in .nvmrc .python-version runtime.txt .tool-versions; do
  path=$(find_repo -type f -name "$f" -print -quit)
  if [ -n "$path" ]; then printf 'VERSION_FILE %s %s\n' "$f" "$path"; fi
done
if has_repo_file pom.xml; then printf '%s\n' 'BUILD Maven confidence=high'; fi
if has_repo_file mvnw; then printf '%s\n' 'BUILD Maven-wrapper confidence=high'; fi
if has_repo_file build.gradle || has_repo_file build.gradle.kts; then printf '%s\n' 'BUILD Gradle confidence=high'; fi
if has_repo_file gradlew; then printf '%s\n' 'BUILD Gradle-wrapper confidence=high'; fi
if has_repo_file go.mod; then printf '%s\n' 'BUILD Go-mod confidence=high'; fi
if has_repo_file Cargo.toml; then printf '%s\n' 'BUILD Cargo confidence=high'; fi
if has_repo_file '*.csproj' || has_repo_file '*.sln' || has_repo_file '*.slnx'; then printf '%s\n' 'BUILD Dotnet confidence=high'; fi
if has_repo_file composer.json; then printf '%s\n' 'BUILD Composer confidence=high'; fi
if has_repo_file Gemfile; then printf '%s\n' 'BUILD Bundler confidence=high'; fi
if has_repo_file mix.exs; then printf '%s\n' 'BUILD Mix confidence=high'; fi
if has_repo_file pubspec.yaml; then printf '%s\n' 'BUILD Dart/Flutter-pub confidence=high'; fi
if has_repo_file Package.swift; then printf '%s\n' 'BUILD SwiftPM confidence=high'; fi
if has_repo_file CMakeLists.txt; then printf '%s\n' 'BUILD CMake confidence=high'; fi

printf '%s\n' '### Framework fingerprints'
# JVM
if repo_grep_any 'org\.springframework\.boot|spring-boot-starter|@SpringBootApplication' \( -name 'pom.xml' -o -name 'build.gradle' -o -name 'build.gradle.kts' -o -name '*.java' -o -name '*.kt' -o -name '*.groovy' \); then printf '%s\n' 'FRAMEWORK Spring Boot confidence=high'; fi
if repo_grep_any 'io\.quarkus|io\.quarkus:quarkus-' \( -name 'pom.xml' -o -name 'build.gradle' -o -name 'build.gradle.kts' \); then printf '%s\n' 'FRAMEWORK Quarkus confidence=high'; fi
if repo_grep_any 'io\.micronaut|micronaut-' \( -name 'pom.xml' -o -name 'build.gradle' -o -name 'build.gradle.kts' \); then printf '%s\n' 'FRAMEWORK Micronaut confidence=high'; fi
if repo_grep_any 'com\.android\.application|com\.android\.library|com\.android\.tools\.build:gradle' \( -name 'build.gradle' -o -name 'build.gradle.kts' -o -name 'settings.gradle' -o -name 'settings.gradle.kts' \); then printf '%s\n' 'FRAMEWORK Android-Gradle-Plugin confidence=high'; fi
if repo_grep_any 'io\.ktor|ktor-server|ktor\(' \( -name 'build.gradle' -o -name 'build.gradle.kts' \); then printf '%s\n' 'FRAMEWORK Ktor confidence=high'; fi

# JS/TS
if repo_grep_any '"next"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Next.js confidence=high'; fi
if repo_grep_any '"react"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK React confidence=high'; fi
if has_repo_file angular.json || repo_grep_any '"@angular/' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Angular confidence=high'; fi
if repo_grep_any '"vue"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Vue confidence=high'; fi
if repo_grep_any '"nuxt"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Nuxt confidence=high'; fi
if repo_grep_any '"vite"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'BUILD Vite confidence=high'; fi
if repo_grep_any '"@nestjs/' -name 'package.json'; then printf '%s\n' 'FRAMEWORK NestJS confidence=high'; fi
if repo_grep_any '"express"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Express confidence=high'; fi
if repo_grep_any '"fastify"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Fastify confidence=high'; fi
if repo_grep_any '"svelte"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Svelte confidence=high'; fi
if repo_grep_any '"@sveltejs/kit"' -name 'package.json'; then printf '%s\n' 'FRAMEWORK SvelteKit confidence=high'; fi
if repo_grep_any '"astro"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'FRAMEWORK Astro confidence=high'; fi

# Python
if repo_grep_any '(^|[^[:alnum:]_-])django([^[:alnum:]_-]|$)' \( -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'poetry.lock' -o -name 'uv.lock' \); then printf '%s\n' 'FRAMEWORK Django confidence=high'; fi
if repo_grep_any 'from flask|import flask|Flask\(' \( -name '*.py' -o -name 'pyproject.toml' -o -name 'requirements*.txt' \); then printf '%s\n' 'FRAMEWORK Flask confidence=high'; fi
if repo_grep_any 'from fastapi|import fastapi|FastAPI\(' \( -name '*.py' -o -name 'pyproject.toml' -o -name 'requirements*.txt' \); then printf '%s\n' 'FRAMEWORK FastAPI confidence=high'; fi

# Go
if repo_grep_any 'github\.com/gin-gonic/gin' \( -name 'go.mod' -o -name '*.go' \); then printf '%s\n' 'FRAMEWORK Gin confidence=high'; fi
if repo_grep_any 'github\.com/labstack/echo' \( -name 'go.mod' -o -name '*.go' \); then printf '%s\n' 'FRAMEWORK Echo confidence=high'; fi
if repo_grep_any 'github\.com/gofiber/fiber' \( -name 'go.mod' -o -name '*.go' \); then printf '%s\n' 'FRAMEWORK Fiber confidence=high'; fi
if repo_grep_any 'github\.com/go-chi/chi' \( -name 'go.mod' -o -name '*.go' \); then printf '%s\n' 'FRAMEWORK Chi confidence=high'; fi

# Rust/.NET/PHP/Ruby/etc.
if repo_grep_any '(axum|tokio)' \( -name 'Cargo.toml' -o -name '*.rs' \); then printf '%s\n' 'FRAMEWORK/Runtime Axum/Tokio confidence=high'; fi
if repo_grep_any 'actix-web' \( -name 'Cargo.toml' -o -name '*.rs' \); then printf '%s\n' 'FRAMEWORK Actix-Web confidence=high'; fi
if repo_grep_any 'Microsoft\.NET\.Sdk\.Web' -name '*.csproj'; then printf '%s\n' 'FRAMEWORK ASP.NET-Core confidence=high'; fi
if repo_grep_any 'laravel/framework' -name 'composer.json'; then printf '%s\n' 'FRAMEWORK Laravel confidence=high'; fi
if repo_grep_any 'symfony/' -name 'composer.json'; then printf '%s\n' 'FRAMEWORK Symfony confidence=high'; fi
if repo_grep_any 'gem[[:space:]]+rails' -name 'Gemfile'; then printf '%s\n' 'FRAMEWORK Rails confidence=high'; fi
if repo_grep_any ':phoenix|phoenix' -name 'mix.exs'; then printf '%s\n' 'FRAMEWORK Phoenix confidence=high'; fi
if repo_grep_any '^([[:space:]]*)flutter:' -name 'pubspec.yaml'; then printf '%s\n' 'FRAMEWORK Flutter confidence=high'; fi
if has_repo_file Package.swift; then printf '%s\n' 'BUILD SwiftPM confidence=high'; fi

printf '%s\n' '### Infrastructure / application boundaries'
if has_repo_file Dockerfile; then printf '%s\n' 'INFRA Docker confidence=high'; fi
if has_repo_file compose.yaml || has_repo_file docker-compose.yml; then printf '%s\n' 'INFRA Docker-Compose confidence=high'; fi
if has_repo_file '*.tf' || has_repo_file terragrunt.hcl; then printf '%s\n' 'INFRA Terraform confidence=high'; fi
if has_repo_file Chart.yaml; then printf '%s\n' 'INFRA Helm confidence=high'; fi
if repo_grep_any '^[[:space:]]*apiVersion:' \( -name '*.yaml' -o -name '*.yml' \); then printf '%s\n' 'INFRA Kubernetes-manifests confidence=medium'; fi
if repo_grep_any 'github\.actions|actions/checkout@|runs-on:' -path '*/.github/*' -name '*.yml'; then printf '%s\n' 'CI GitHub-Actions confidence=high'; fi
if has_repo_file Jenkinsfile; then printf '%s\n' 'CI Jenkins confidence=high'; fi
if has_repo_file .gitlab-ci.yml; then printf '%s\n' 'CI GitLab confidence=high'; fi

printf '%s\n' '### Persistence / messaging / observability fingerprints'
if repo_grep_any 'postgres|postgresql|psycopg|pgx' \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'DATA PostgreSQL-related confidence=medium'; fi
if repo_grep_any 'mysql|mariadb' \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'DATA MySQL/MariaDB-related confidence=medium'; fi
if repo_grep_any 'mongodb|mongoose|pymongo|mongo-driver' \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'DATA MongoDB-related confidence=medium'; fi
if repo_grep_any 'redis|lettuce|jedis' \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'INFRA Redis-related confidence=medium'; fi
if repo_grep_any 'kafka|spring-kafka|sarama|kafkajs' \( -name 'package.json' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'MESSAGING Kafka-related confidence=medium'; fi
if repo_grep_any 'opentelemetry|micrometer|prometheus|sentry' \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'requirements*.txt' -o -name 'pom.xml' -o -name 'build.gradle*' -o -name 'go.mod' \); then printf '%s\n' 'OBSERVABILITY telemetry-related confidence=medium'; fi

printf '%s\n' '### Test tooling'
if repo_grep_any '"(jest|vitest|playwright|cypress)"[[:space:]]*:' -name 'package.json'; then printf '%s\n' 'TEST_TOOL Node-test-stack confidence=high'; fi
if repo_grep_any 'pytest|hypothesis' \( -name 'pyproject.toml' -o -name 'requirements*.txt' \); then printf '%s\n' 'TEST_TOOL pytest/Hypothesis confidence=high'; fi
if repo_grep_any 'junit|testng|spring-boot-starter-test' \( -name 'pom.xml' -o -name 'build.gradle*' \); then printf '%s\n' 'TEST_TOOL JVM-test-stack confidence=high'; fi
if repo_grep_any 'Microsoft.NET.Test.Sdk|xunit|nunit|MSTest' \( -name '*.csproj' -o -name 'Directory.Packages.props' \); then printf '%s\n' 'TEST_TOOL Dotnet-test-stack confidence=high'; fi
if has_repo_file mix.exs; then printf '%s\n' 'TEST_TOOL mix-test-available confidence=medium'; fi
if has_repo_file go.mod; then printf '%s\n' 'TEST_TOOL go-test-available confidence=medium'; fi
if has_repo_file Cargo.toml; then printf '%s\n' 'TEST_TOOL cargo-test-available confidence=medium'; fi

printf '%s\n' '### Repository shape'
if has_repo_file pnpm-workspace.yaml || has_repo_file lerna.json || has_repo_file nx.json || has_repo_file turbo.json || has_repo_file rush.json; then printf '%s\n' 'REPO_SHAPE JS-workspace/monorepo confidence=high'; fi
if has_repo_file go.work; then printf '%s\n' 'REPO_SHAPE Go-workspace confidence=high'; fi
if [ "$(find_repo -type f -name pom.xml | wc -l | tr -d ' ')" -gt 1 ] 2>/dev/null; then printf '%s\n' 'REPO_SHAPE Maven-multi-module-candidate confidence=medium'; fi
if has_repo_file settings.gradle || has_repo_file settings.gradle.kts; then printf '%s\n' 'REPO_SHAPE Gradle-multi-module-candidate confidence=medium'; fi

exit 0
