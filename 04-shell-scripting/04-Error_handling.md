## Bash Script Safety and Debugging Options

Bash provides built-in execution options that improve script reliability, visibility, and error handling. These options are essential in automation because shell scripts often interact with files, processes, networks, and infrastructure where silent failures can cause real operational problems.

The most important options are:

- `set -x` → print commands as they execute
- `set -e` → exit when a command fails
- `set -o pipefail` → fail a pipeline if any command in it fails

These options are commonly combined to make scripts easier to debug and safer to run.

## `set -x` — Debug Mode

```bash
set -x
```

This enables command tracing. Bash prints each command before executing it.

### Example
```bash
set -x
echo "Hello"
date
```

### Output
```bash
+ echo Hello
Hello
+ date
Wed Mar 25 13:00:00 EAT 2026
```

### Why it matters
`set -x` is useful when:
- debugging a script
- understanding execution order
- finding the exact command that caused an issue

### Important note
`set -x` can expose sensitive values such as:
- passwords
- API tokens
- secret environment variables

For that reason, it should be used carefully in production scripts, especially when logs are stored or shared.


## `set -e` — Exit on Error

```bash
set -e
```

This tells Bash to exit immediately if a command returns a non-zero exit status.

### Example
```bash
set -e

echo "Step 1"
mkdir demo_dir
cd demo_dir
cd does_not_exist
echo "This will not run"
```

### What happens
The script stops at:

```bash
cd does_not_exist
```

because that command fails.

### Why it matters
Without `set -e`, a script may continue after an error and produce:
- incomplete results
- corrupted state
- misleading output
- cascading failures

`set -e` helps stop execution early before further damage is done.


## Where `set -e` Can Behave Unexpectedly

`set -e` does not mean “exit on every failure in every situation.” Bash has exceptions. Some failed commands do not terminate the script when they appear in certain contexts.

That makes `set -e` useful, but not sufficient by itself.



### 1. Failures inside `if` tests do not exit the script

```bash
set -e

if grep "amazon" missing_file.txt; then
  echo "Found"
fi

echo "Script continues"
```

Even though `grep` fails, the script continues.

### Why
Because the command is being used as part of the `if` condition. Bash expects commands in conditions to succeed or fail as part of the logic.

### Meaning
A failure inside `if` is treated as control flow, not necessarily as a fatal script error.


### 2. Failures inside `while` or `until` conditions may not stop the script

```bash
set -e

while grep "amazon" missing_file.txt; do
  echo "Looping"
done

echo "Script continues"
```

Again, the script may continue because the command is part of a loop condition.


### 3. Failures in commands combined with `&&` and `||` can be tricky

```bash
set -e

grep "amazon" file.txt || echo "Pattern not found"
echo "Still running"
```

If `grep` fails, the shell may continue because the failure is part of an expected conditional chain.

### Why
Commands used with `||` and `&&` are often interpreted as part of branching logic rather than fatal errors.


### 4. Pipelines are a major trap without `pipefail`

```bash
set -e

cat missing.txt | grep "amazon"
echo "Script continues"
```

By default, Bash only checks the exit code of the **last command** in the pipeline.

If:
- `cat missing.txt` fails
- but the final command does not make the pipeline fail in a visible way

the script may continue unexpectedly.

This is why `set -o pipefail` is critical.


### 5. Command substitutions can hide failures

```bash
set -e

result=$(grep "amazon" missing_file.txt)
echo "Done"
```

Failures inside command substitution may not behave the way beginners expect, depending on context and Bash behavior.

### Why this matters
Many scripts use command substitution heavily:
- `$(date)`
- `$(grep ...)`
- `$(aws ...)`

If you assume every failure inside `$(...)` will always terminate the script cleanly, you can be wrong.


### 6. Subshells and grouped commands can behave differently

```bash
set -e

(
  cd missing_dir
  echo "Inside subshell"
)

echo "Outside subshell"
```

Depending on how the code is structured, errors inside subshells or grouped commands may not always affect the parent shell the way you expect.


## `set -o pipefail` — Correct Pipeline Failure Handling

```bash
set -o pipefail
```

This changes pipeline behavior so the pipeline fails if **any command** in it fails.

### Example
```bash
set -e
set -o pipefail

cat missing.txt | grep "amazon"
echo "This will not run"
```

With `pipefail`, the pipeline correctly fails because `cat` failed.

### Why it matters
Without `pipefail`, pipelines can hide upstream failures and make broken scripts appear healthy.

This is especially dangerous in DevOps tasks such as:
- log parsing
- backups
- API calls
- deployment pipelines
- infrastructure checks


## `set -exo pipefail` — Combined Usage

```bash
set -exo pipefail
```

This combines:
- `-e` → exit on failure
- `-x` → print commands during execution
- `pipefail` → fail pipelines correctly

This is useful during development and troubleshooting.


## Safer Professional Pattern: `set -euo pipefail`

A more complete and widely recommended pattern is:

```bash
set -euo pipefail
```

This adds:

- `-u` → treat unset variables as errors

### Example
```bash
set -euo pipefail

echo "$USERNAME"
```

If `USERNAME` is not defined, the script exits instead of silently using an empty value.

### Why `-u` matters
Unset variables can cause:
- broken paths
- incorrect API requests
- accidental deletion targets
- confusing runtime behavior


## Practical Meaning of Each Option

| Option | Purpose | Benefit |
|--------|---------|---------|
| `set -x` | Trace commands | Easier debugging |
| `set -e` | Exit on error | Prevents cascading failures |
| `set -u` | Fail on unset variables | Prevents hidden variable bugs |
| `set -o pipefail` | Fail pipelines correctly | Prevents silent pipeline errors |


## Important Limitations

Even with `set -euo pipefail`, Bash is **not foolproof**.

These options improve safety, but they do not replace:
- careful script design
- explicit error handling
- validation checks
- testing edge cases

The shell “strict mode” reduces risk, but does not eliminate it.


## Best Practices

### 1. Use strict mode at the top of serious scripts
```bash
#!/bin/bash
set -euo pipefail
```



### 2. Use `set -x` only when debugging
```bash
set -x
```

Disable it later if needed:
```bash
set +x
```



### 3. Do not rely blindly on `set -e`
For critical operations, use explicit checks:

```bash
if ! cp source.txt backup.txt; then
  echo "Backup failed"
  exit 1
fi
```

This is clearer and more predictable than assuming Bash will always exit where you expect.


### 4. Be careful with pipelines
Prefer:

```bash
set -o pipefail
```

whenever your script uses pipes.


### 5. Validate important assumptions
Check:
- files exist
- variables are set
- commands are installed
- directories are accessible

Example:
```bash
[ -f config.txt ] || { echo "config.txt not found"; exit 1; }
```


## Example of a Safer Script Header

```bash
#!/bin/bash
set -euo pipefail

LOG_FILE="app.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found: $LOG_FILE"
  exit 1
fi

grep "ERROR" "$LOG_FILE" | awk '{print $1}'
```

This pattern is safer because it:
- fails on real errors
- handles pipelines correctly
- checks assumptions before continuing


## Key Takeaways

- `set -x` helps trace execution
- `set -e` stops scripts on many errors, but not all
- `set -e` has exceptions in conditions, logic chains, and some shell contexts
- `set -o pipefail` is necessary to catch failures inside pipelines
- `set -u` helps catch unset-variable mistakes
- `set -euo pipefail` is the standard starting point for safer Bash scripting
- serious scripts still need explicit checks and thoughtful error handling

Understanding these options is important because production shell scripts should not only run successfully when everything is perfect, they must also fail safely and predictably when something goes wrong.
