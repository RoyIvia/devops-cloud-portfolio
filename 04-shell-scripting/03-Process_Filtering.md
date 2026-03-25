## Process Filtering and Command Chaining in Bash

When working with Linux systems, it is common to inspect running processes and filter relevant information. One of the most widely used tools for this is `grep`, often combined with `ps` to search for specific processes.

### Understanding `grep` with Process Listing

The `ps -ef` command lists all running processes on a system. By piping (`|`) its output into `grep`, we can filter processes based on a search term.

### Example

```bash
ps -ef | grep "amazon"
```

This command:
- Lists all processes
- Filters only those containing the string `"amazon"`

### Case Sensitivity in `grep`

By default, `grep` is case sensitive.

```bash
ps -ef | grep -i "amazon"
```

With the `-i` flag, `grep` performs a case-insensitive search.

This will match:
- amazon
- Amazon
- AMAZON
- AmaZon

### Common Issue: `grep` Matching Itself

The following command:

```bash
ps -ef | grep amazon
```

will also include the `grep` process itself in the output, for example:

```bash
root     1234  ... grep amazon
```

This happens because the search term `"amazon"` appears in the `grep` command itself.


### Solutions

#### Option 1: Exclude `grep`
```bash
ps -ef | grep -i "amazon" | grep -v grep
```

This removes lines containing `"grep"` from the output.


#### Option 2: Use `pgrep` (Preferred)
```bash
pgrep -af amazon
```

`pgrep` is specifically designed for process searching:
- Avoids matching itself
- Provides cleaner and more reliable output
- Better suited for scripting and production use
  
## Understanding Pipes vs Command Substitution in Bash

While working with shell commands, I explored how pipes (`|`) behave when chaining commands together, and an important distinction emerged.

### Example
```bash
date | echo "Today"
```

### Output
```bash
Today
```
At first glance, it may seem like this command should combine the output of `date` with the string `"Today"`. However, this is not the case.

### date is a system default command, it sends its output to stdin but pipe (|)  does not receive output from stdin thus only the echo command gives an output.

- The pipe (`|`) sends the output of `date` to the next command
- `echo` does not read input from standard input (stdin)
- Instead, `echo` only prints the argument provided (`"Today"`)

As a result, the output from `date` is ignored.

### Key Insight
Not all commands accept input from stdin.

Commands that read from stdin:
- `grep`
- `awk`
- `sed`
- `xargs`

Commands that ignore stdin:
- `echo`
- `ls`
- `mkdir`

Understanding this distinction is critical when chaining commands in Bash.


### Correct Approach: Command Substitution

To combine text with command output, command substitution should be used:

```bash
echo "Today: $(date)"
```

### Output
```bash
Today: Wed Mar 25 12:34:56 EAT 2026
```

## Text Processing with `awk`

`awk` is a powerful command-line tool used for processing and analyzing structured text data. It is commonly used in Linux environments to extract, transform, and report data from command outputs and files.


### How `awk` Works

`awk` processes input line by line and splits each line into fields.

By default:
- Each line is treated as a record
- Fields are separated by whitespace (spaces or tabs)

Each field is assigned a variable:
- `$1` → first field
- `$2` → second field
- `$3` → third field
- `$0` → entire line


### Basic Syntax

```bash
awk '{print $N}' <input>
```

Where:
- `$N` represents the field number

### Example: Extracting Process IDs

```bash
ps -ef | grep "amazon" | awk '{print $2}'
```

This command:
- Lists all running processes
- Filters processes containing `"amazon"`
- Uses `awk` to extract the second column

In `ps -ef` output:
- `$1` → User
- `$2` → PID (Process ID)
- `$3` → Parent PID
- `$8+` → Command

Output:
```bash
1234
5678
```

This is useful for:
- process monitoring
- automation scripts
- system diagnostics

### Custom Field Separators

`awk` allows defining a custom delimiter using the `-F` option.

#### Example: Parsing `/etc/passwd`
```bash
awk -F":" '{print $1}' /etc/passwd
```

This extracts usernames because:
- `/etc/passwd` uses `:` as a separator

### Filtering with Conditions

`awk` can filter data based on conditions.

```bash
awk '$3 > 1000 {print $1}' /etc/passwd
```

This prints users with UID greater than 1000.


### Combining `awk` with Pipelines

`awk` is often used with other commands:

```bash
ps -ef | grep -i amazon | grep -v grep | awk '{print $2}'
```

This pipeline:
- filters processes
- removes unwanted matches
- extracts PIDs for further use

In DevOps workflows, `awk` is especially useful for:
- parsing logs
- extracting specific fields from command output
- transforming data for automation scripts
