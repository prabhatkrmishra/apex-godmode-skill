# Generated Code and Codegen

Determine whether changed files are generated, partially generated, or generator inputs.

Before editing generated output:
1. identify the generator and source-of-truth files
2. inspect repository instructions and CI generation checks
3. determine whether regeneration is deterministic
4. change the source-of-truth where possible
5. regenerate using the repository-native command
6. inspect the generated diff for unrelated churn
7. verify generated artifacts are consistent with the source inputs

If generated output must be edited directly, record why regeneration is unavailable or intentionally out of scope.

Never treat generated files as independent source-of-truth without evidence.
