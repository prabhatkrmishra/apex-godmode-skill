# Dependency and Supply-Chain Review

For dependency-impacting work, inspect the manifest, lockfile, package manager configuration, registries, overrides/resolutions, and install/build scripts.

Check for:
- unpinned or unexpectedly broad dependency ranges;
- lockfile drift;
- dependency confusion or unexpected registries;
- post-install/pre-install scripts with sensitive capabilities;
- abandoned/deprecated packages when alternatives are material;
- known security advisories applicable to the exact resolved version;
- transitive dependency changes caused by an upgrade.

Do not upgrade unrelated dependencies merely to clean up the tree. When a dependency update is necessary, record old and new resolved versions and the reason for the change.

Use the project's native audit mechanism where available (for example ecosystem-native audit/check commands) and preserve raw results in the evidence ledger.
