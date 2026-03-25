## Signal Handling and Cleanup in Bash using `trap`

### Overview

In Bash scripting, processes can be interrupted or terminated by signals such as user actions (e.g., pressing `Ctrl+C`) or system events. The `trap` command allows a script to intercept these signals and execute custom logic before exiting.

This is critical for:
- cleaning up temporary files
- stopping background processes
- releasing resources
- ensuring scripts fail safely and predictably

---

## What is `trap`?

The `trap` command defines actions to be executed when the shell receives specific signals or exits.

### Basic Syntax

```bash
trap '<command>' <signal>
```

---

## Common Signals

| Signal | Description |
|--------|------------|
| `SIGINT` | Interrupt (Ctrl+C) |
| `SIGTERM` | Termination signal |
| `EXIT` | Script exit (normal or error) |
| `SIGHUP` | Terminal closed |
| `SIGKILL` | Forced termination (cannot be trapped) |

---

## Example: Handle Ctrl+C (`SIGINT`)

```bash
trap 'echo "Interrupted. Exiting safely."; exit 1' SIGINT

while true; do
  echo "Running..."
  sleep 2
done
```

### What happens
- When the user presses `Ctrl+C`
- Instead of abruptly stopping
- The script prints a message and exits cleanly

---

## Example: Cleanup on Exit

```bash
TEMP_FILE="/tmp/data.tmp"

touch "$TEMP_FILE"

trap 'rm -f "$TEMP_FILE"; echo "Cleaned up temporary file."' EXIT

echo "Processing..."
sleep 5
```

### What happens
- Regardless of how the script exits (success or failure)
- The temporary file is deleted

---

## Why `trap EXIT` is Important

Without `trap`:
- temporary files may remain
- partial data may persist
- system state may become inconsistent

With `trap EXIT`:
- cleanup is guaranteed

---

## Example: Managing Background Processes

```bash
#!/bin/bash
set -euo pipefail

trap 'echo "Stopping background job..."; kill $PID' EXIT

sleep 100 &
PID=$!

echo "Background process started with PID $PID"
wait
```

### What this does
- Starts a background process
- Ensures it is terminated when the script exits

---

## Multiple Signals

You can handle multiple signals in one `trap`:

```bash
trap 'echo "Exiting..."; cleanup' SIGINT SIGTERM EXIT
```

---

## Removing a Trap

To reset a trap:

```bash
trap - SIGINT
```

---

## Practical DevOps Use Cases

- Cleaning up temporary files during deployments
- Stopping background jobs in automation scripts
- Ensuring logs or state files are consistent
- Handling script interruptions gracefully
- Preventing resource leaks in long-running scripts

---

## Important Limitations

- `SIGKILL` cannot be trapped
- `SIGSTOP` cannot be trapped
- Traps do not replace proper error handling (`set -euo pipefail`)
- Poorly written traps can hide real failures if not used carefully

---

## Best Practices

### 1. Always use `trap EXIT` for cleanup

```bash
trap 'cleanup_function' EXIT
```

---

### 2. Use functions for clarity

```bash
cleanup() {
  rm -f /tmp/file
  echo "Cleanup complete"
}

trap cleanup EXIT
```

---

### 3. Combine with strict mode

```bash
set -euo pipefail
```

---

### 4. Be explicit about what you clean

Avoid:
- deleting unintended files
- killing the wrong processes

---

## Example: Safer Script Pattern

```bash
#!/bin/bash
set -euo pipefail

TEMP_FILE="/tmp/app.log"

cleanup() {
  echo "Cleaning up..."
  rm -f "$TEMP_FILE"
}

trap cleanup EXIT

echo "Running script..."
touch "$TEMP_FILE"
sleep 3
```

This ensures:
- predictable execution
- guaranteed cleanup
- safer script behavior

---

## Key Takeaways

- `trap` allows scripts to respond to signals and exit events
- it is essential for safe cleanup and controlled shutdown
- `trap EXIT` ensures cleanup runs regardless of how the script ends
- combining `trap` with strict mode improves reliability
- proper signal handling is a hallmark of production-ready shell scripts

Understanding and using `trap` moves Bash scripting from simple automation to reliable system-level engineering.
