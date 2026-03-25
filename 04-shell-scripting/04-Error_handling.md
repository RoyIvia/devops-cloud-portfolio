## Bash Script Safety and Debugging Options

Bash provides built-in options that improve script reliability, debuggability, and failure handling. These options are critical in 
production environments where silent failures or hidden errors can lead to system issues.

The most commonly used options are:
- `set -x` → debugging
- `set -e` → exit on error
- `set -o pipefail` → proper error handling in pipelines

These are often combined to enforce strict and predictable script behavior.


### `set -x` (Debug Mode)

Enables command tracing.

```bash
set -x
```

When enabled, Bash prints each command before executing it.

#### Example
```bash
set -x
echo "Hello"
```

Output:
```bash
+ echo Hello
Hello
```

#### Use Case
- Debugging scripts
- Understanding execution flow
- Identifying where failures occur


### `set -e` (Exit on Error)

Forces the script to exit immediately if any command returns a non-zero status.

```bash
set -e
```

#### Example
```bash
set -e
mkdir test
cd test
cd non_existent_directory   # Script exits here
echo "This will not run"
```

#### Use Case
- Prevents scripts from continuing after failure
- Ensures safer automation
- Avoids cascading errors


### `set -o pipefail` (Pipeline Error Handling)

By default, Bash only checks the exit status of the **last command** in a pipeline.

```bash
command1 | command2
```

If `command1` fails but `command2` succeeds, the pipeline appears successful.

`pipefail` fixes this:

```bash
set -o pipefail
```

Now:
- The pipeline fails if **any command fails**

#### Example
```bash
set -o pipefail
cat nonexistent.txt | grep "test"
```

Without `pipefail`:
- Script may continue silently

With `pipefail`:
- Script correctly fails


### Combining Options: `set -exo pipefail`

These options are commonly combined for robust scripting:

```bash
set -exo pipefail
```

This enables:
- `-e` → exit on error
- `-x` → debug output
- `pipefail` → proper pipeline error handling


### Recommended Usage Pattern

At the top of a script:

```bash
#!/bin/bash
set -euo pipefail
```

(Optional debug mode during development)
```bash
set -x
```

#### Note:
- `-u` (optional but recommended) → treats unset variables as errors


### Practical Impact

Using these options ensures:
- Immediate failure on errors
- No hidden failures in pipelines
- Easier debugging during development
- More predictable script behavior in production

