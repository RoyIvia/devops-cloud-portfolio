## Control Flow in Bash: Loops and Conditional Statements

### Overview

Control flow structures in Bash allow scripts to make decisions, repeat actions, and respond dynamically to system state. These constructs are essential for automation, especially in DevOps workflows where scripts must handle varying inputs, system conditions, and failures.

This section covers:
- conditional statements (`if`, `case`)
- loops (`for`, `while`, `until`, `select`)
- control keywords (`break`, `continue`)

---

## Conditional Statements

### `if`, `elif`, `else`

Used to execute commands based on conditions.

```bash
if [ -f "file.txt" ]; then
  echo "File exists"
elif [ -d "file.txt" ]; then
  echo "It is a directory"
else
  echo "Not found"
fi
```

### Common Conditions

| Test | Meaning |
|------|--------|
| `-f file` | file exists |
| `-d dir` | directory exists |
| `-z var` | string is empty |
| `-n var` | string is not empty |
| `-eq` | equal (numbers) |
| `-ne` | not equal |

---

### `case` Statement

Useful for handling multiple conditions cleanly.

```bash
case "$1" in
  start)
    echo "Starting service"
    ;;
  stop)
    echo "Stopping service"
    ;;
  restart)
    echo "Restarting service"
    ;;
  *)
    echo "Invalid option"
    ;;
esac
```

---

## Loops

### 1. `for` Loop

Used when iterating over a list or range.

#### Example: Iterate over items
```bash
for service in nginx docker ssh; do
  echo "Checking $service"
done
```

#### Example: Range
```bash
for i in {1..5}; do
  echo "Iteration $i"
done
```

#### Use Cases
- iterating over files
- looping through services
- batch operations

---

### 2. `while` Loop

Runs as long as a condition is true.

```bash
count=1

while [ $count -le 5 ]; do
  echo "Count: $count"
  ((count++))
done
```

#### Use Cases
- polling system state
- reading files line by line
- monitoring loops

---

### 3. `until` Loop

Runs until a condition becomes true (opposite of `while`).

```bash
count=1

until [ $count -gt 5 ]; do
  echo "Count: $count"
  ((count++))
done
```

#### Use Cases
- retry logic
- waiting for services to become available

---

### 4. `select` Loop

Creates a simple interactive menu.

```bash
select option in start stop exit; do
  echo "You selected $option"
  break
done
```

#### Use Cases
- CLI menus
- interactive scripts

---

## Loop Control

### `break`
Exits the loop immediately.

```bash
for i in {1..10}; do
  if [ $i -eq 5 ]; then
    break
  fi
  echo $i
done
```

---

### `continue`
Skips the current iteration.

```bash
for i in {1..5}; do
  if [ $i -eq 3 ]; then
    continue
  fi
  echo $i
done
```

---

## Practical DevOps Examples

### Example: Check running services

```bash
for service in nginx docker ssh; do
  if systemctl is-active --quiet $service; then
    echo "$service is running"
  else
    echo "$service is not running"
  fi
done
```

---

### Example: Monitor until service is up

```bash
until curl -s http://localhost:8080 > /dev/null; do
  echo "Waiting for service..."
  sleep 2
done

echo "Service is up"
```

---

### Example: Read file line by line

```bash
while read line; do
  echo "Processing: $line"
done < logfile.log
```

---

## Key Takeaways

- `if` and `case` control decision-making
- `for`, `while`, and `until` handle repetition
- `select` enables interactive scripts
- `break` and `continue` control loop execution
- control flow is essential for building automation and handling real-world conditions

Understanding these constructs allows scripts to move beyond static commands into dynamic, production-ready automation.
