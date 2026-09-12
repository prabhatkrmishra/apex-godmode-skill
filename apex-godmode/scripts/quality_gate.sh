#!/usr/bin/env bash
set -u
ROOT="${1:-.}"
cd "$ROOT" 2>/dev/null || { echo 'FAIL: repository root unavailable' >&2; exit 2; }
fail=0
missing_tools=0
ran=0

run(){
  ran=$((ran + 1))
  printf '\n==> %s\n' "$*"
  "$@" || fail=1
}
missing(){ printf 'UNVERIFIED: %s\n' "$1" >&2; missing_tools=1; }
require_and_run(){
  local label="$1"; shift
  local exe="$1"
  if ! command -v "$exe" >/dev/null 2>&1; then
    missing "$label"
    return 3
  fi
  run "$@"
}
run_in_dir(){ local d="$1"; shift; local old="$PWD"; cd "$d" || { missing "cannot enter module $d"; return 3; }; run "$@"; local rc=$?; cd "$old" || exit 2; return $rc; }

# Run root-native orchestration where it exists. Root checks never imply that
# arbitrary nested modules are covered; module-native checks below fill gaps.
if [ -f package.json ] && command -v node >/dev/null 2>&1; then
  if node -e "const p=require('./package.json');process.exit(p.scripts?.test?0:1)" 2>/dev/null; then run npm test; fi
  if node -e "const p=require('./package.json');process.exit(p.scripts?.build?0:1)" 2>/dev/null; then run npm run build; fi
fi
if [ -x ./mvnw ]; then run ./mvnw test
elif [ -f pom.xml ]; then require_and_run 'Maven project detected but mvn is unavailable' mvn mvn test; fi
if [ -x ./gradlew ]; then run ./gradlew test
elif [ -f build.gradle ] || [ -f build.gradle.kts ]; then require_and_run 'Gradle project detected but gradle is unavailable' gradle gradle test; fi
if find . -maxdepth 1 -type f \( -name '*.sln' -o -name '*.slnx' -o -name '*.csproj' -o -name '*.fsproj' \) -print -quit 2>/dev/null | grep -q .; then require_and_run '.NET project detected but dotnet is unavailable' dotnet dotnet test; fi
if [ -f go.mod ]; then require_and_run 'Go project detected but go is unavailable' go go test ./...; fi
if [ -f Cargo.toml ]; then require_and_run 'Rust project detected but cargo is unavailable' cargo cargo test; fi
if [ -f mix.exs ]; then require_and_run 'Elixir project detected but mix is unavailable' mix mix test; fi
if [ -f Gemfile ] && [ -f Rakefile ]; then require_and_run 'Ruby project detected but bundle is unavailable' bundle bundle exec rake test; fi
if [ -f pubspec.yaml ]; then
  if grep -Eq '^([[:space:]]*)flutter:' pubspec.yaml 2>/dev/null; then require_and_run 'Flutter project detected but flutter is unavailable' flutter flutter test
  else require_and_run 'Dart project detected but dart is unavailable' dart dart test; fi
fi
if [ -f Package.swift ]; then require_and_run 'SwiftPM project detected but swift is unavailable' swift swift test; fi
if [ -f pyproject.toml ] || [ -f setup.cfg ] || [ -f requirements.txt ]; then require_and_run 'Python project detected but pytest is unavailable' pytest pytest -q; fi

# Always inspect bounded nested modules. Do not skip this merely because a root
# command exists. Root orchestration may be partial (especially in JS workspaces).
while IFS= read -r -d '' f; do
  d="$(dirname "$f")"
  [ "$d" = "." ] && continue
  case "$f" in
    */pom.xml)
      if [ -x "$d/mvnw" ]; then run_in_dir "$d" ./mvnw test
      elif command -v mvn >/dev/null 2>&1; then run_in_dir "$d" mvn test
      else missing "Maven module $d cannot be verified"; fi ;;
    */build.gradle|*/build.gradle.kts) : ;; # Gradle module coverage is handled by root settings/selected task when available.
    */package.json)
      if command -v node >/dev/null 2>&1 && node -e "const p=require(process.argv[1]);process.exit(p.scripts?.test?0:1)" "$f" 2>/dev/null; then
        if command -v npm >/dev/null 2>&1; then run_in_dir "$d" npm test; else missing "Node module $d has a test script but npm is unavailable"; fi
      fi ;;
    */go.mod)
      if command -v go >/dev/null 2>&1; then run_in_dir "$d" go test ./...; else missing "Go module $d cannot be verified"; fi ;;
    */Cargo.toml)
      if command -v cargo >/dev/null 2>&1; then run_in_dir "$d" cargo test; else missing "Rust module $d cannot be verified"; fi ;;
    */mix.exs)
      if command -v mix >/dev/null 2>&1; then run_in_dir "$d" mix test; else missing "Elixir module $d cannot be verified"; fi ;;
    */pubspec.yaml)
      if command -v dart >/dev/null 2>&1; then run_in_dir "$d" dart test; else missing "Dart module $d cannot be verified"; fi ;;
    */Package.swift)
      if command -v swift >/dev/null 2>&1; then run_in_dir "$d" swift test; else missing "Swift module $d cannot be verified"; fi ;;
    */pyproject.toml|*/requirements.txt)
      if command -v pytest >/dev/null 2>&1; then run_in_dir "$d" pytest -q; else missing "Python module $d cannot be verified"; fi ;;
    */csproj|*/fsproj)
      if command -v dotnet >/dev/null 2>&1; then run_in_dir "$d" dotnet test; else missing ".NET module $d cannot be verified"; fi ;;
  esac
done < <(find . -maxdepth 5 \( -type d \( -name .git -o -name node_modules -o -name target -o -name build -o -name dist -o -name .venv -o -name venv -o -name vendor -o -name coverage -o -name .gradle -o -name .next -o -name .turbo -o -name out \) -prune \) -o \( -type f \( -name pom.xml -o -name go.mod -o -name Cargo.toml -o -name mix.exs -o -name pubspec.yaml -o -name Package.swift -o -name package.json -o -name pyproject.toml -o -name requirements.txt -o -name '*.csproj' -o -name '*.fsproj' \) -print0 \) 2>/dev/null)

if [ "$ran" -eq 0 ]; then echo 'UNVERIFIED: no recognized automated quality checks were executed' >&2; exit 3; fi
if [ "$missing_tools" -ne 0 ]; then exit 3; fi
exit "$fail"
