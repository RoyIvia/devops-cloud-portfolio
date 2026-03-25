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

## date is a system default command, it sends its output to stdin but pipe (|)  does not receive output from stdin thus only the echo command gives an output.

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

### Takeaway
- Pipes (`|`) pass output between commands
- Not all commands consume piped input
- Command substitution (`$(...)`) is the correct method for embedding command output within strings

This distinction is essential for writing reliable shell scripts and avoiding subtle bugs in command chaining.
