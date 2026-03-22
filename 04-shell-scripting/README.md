# Shell Scripting

Shell scripting is a fundamental DevOps skill used to automate system tasks, deployments, monitoring, and infrastructure operations. This section focuses on building production-ready scripts with an emphasis on portability, reliability, and correctness.

In real-world environments such as CI/CD pipelines, Docker containers, and cloud systems, scripts are often executed using minimal shells like `sh` (commonly `dash`), not `bash`. For this reason, writing POSIX-compliant scripts is essential to ensure consistency across different systems.

---

## Shell Types

### sh
`sh` represents the original Bourne shell standard. It is a portable interface, not a specific implementation. On many systems, `/bin/sh` is linked to a lightweight shell such as `dash`.

### bash
`bash` (Bourne Again Shell) is an extended version of `sh` that provides additional features such as arrays, advanced conditionals, and improved scripting capabilities. It is commonly used for local development and complex scripting.

### dash
`dash` (Debian Almquist Shell) is a minimal, fast, POSIX-compliant shell used as `/bin/sh` on many systems. It does not support bash-specific features, making it strict but reliable in production environments.

---

## Why POSIX Compliance Matters

Shell scripts in DevOps environments often run in:

- Docker containers (e.g., Alpine Linux)
- CI/CD pipelines (GitHub Actions, Jenkins, AWS CodeBuild)
- Remote production servers

These environments often:

- Do not include `bash`
- Default to `/bin/sh` (typically `dash`)

To avoid failures, scripts should follow POSIX standards so they are:

- Portable across systems  
- Predictable in behavior  
- Compatible with minimal environments  
- Safe for production use  

---

## POSIX vs Bash

| Feature | POSIX (sh / dash) | Bash |
|--------|-------------------|------|
| Portability | High | Limited |
| Performance | Fast | Slower |
| Arrays | Not supported | Supported |
| `[[ ]]` | Not supported | Supported |
| Brace expansion `{1..5}` | Not supported | Supported |
| Intended use | Production scripts | Advanced/local scripting |

---

## Writing Portable Scripts

### Script Header

 for portable scripts:

```sh
#!/bin/sh
```
when bash-specific features are required:

```
#!/bin/bash

```

Conditionals:

```
if [ "$a" = "$b" ]; then
  echo "Equal"
fi
```

Loops:

```
for item in one two three
do
  echo "$item"
done
```

Portable alternative:
```
i=1
while [ "$i" -le 3 ]
do
  echo "$i"
  i=$((i + 1))
done

```

Functions:

```
greet() {
  echo "Hello"
}

```

Arithmetic:

```
count=$((count + 1))
```

Command Substitution:

```
current_date=$(date)
```

File Checks:

```
if [ -f "file.txt" ]; then
  echo "File exists"
fi
```

Output

Prefer:

```
printf "Hello\n"
```

Over:

```
echo "Hello\n"
```

Debugging and Safety;

```
set -e → Exit on error
set -x → Debug output

```

Common Pitfalls:

```
#!/bin/sh
[[ condition ]]
arr=(1 2 3)
for i in {1..5}
do
  echo "$i"
done
function test() {
  echo "test"
}
```
These are not portable because:

[[ ]] is bash-only
Arrays are not supported in POSIX
Brace expansion is bash-only
function keyword is bash-specific

Such scripts may work locally but fail in production environments.


