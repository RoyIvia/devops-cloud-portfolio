# Linux Process Management

A process is an instance of a running program.

Every time you run a command, Linux creates a process.

Each process has:

- PID – Process ID (unique identifier)

- PPID – Parent Process ID

- Owner (user)

- Memory allocation

- CPU usage

- State (Running, Sleeping, Stopped, Zombie)

- Priority (Nice value)

Linux exposes process information through /proc.

# Process Management in Linux

A process is an instance of a running program. Linux provides multiple utilities to monitor, manage, and control processes effectively. Each process has a unique **Process ID (PID)** and belongs to a parent process.

## Index of Commands 

### Viewing Processes

- `ps aux` – Display all running processes in BSD format (includes CPU and memory usage).

- `ps -ef` – Display all running processes in full System V format (includes Parent Process ID – PPID).

- `ps -u username` – Display processes owned by a specific user.

- `ps -C processname` – Display processes by exact command name.

- `pgrep processname` – Search for processes by name and return their PID(s).

- `pidof processname` – Return the PID(s) of a running program by name.

### Process Output & Counting

- `ps aux | nl `– Number each line of the ps aux output.

- `ps aux | wc -l` – Count the total number of processes listed.

- `ps -ef | nl `– Number each line of the ps -ef output.
  

In Linux process management, both ps aux (BSD style - no dash) and ps -ef (System V style) are used to display running processes, but they differ in format and use case.

- `ps aux` provides detailed information including CPU and memory usage (%CPU, %MEM, VSZ, RSS). It is primarily used for performance monitoring and troubleshooting system resource consumption.

- `ps -ef` displays processes in full format and includes the Parent Process ID (PPID), making it useful for analyzing process hierarchies and debugging services.

Key Differences:

ps aux → Best for performance analysis (CPU & memory focus).

ps -ef → Best for tracing parent-child relationships and service debugging.


### Managing Processes
- `kill PID` – Terminate a process by PID
- `pkill processname` – Terminate a process by name
- `kill -9 PID` – Force kill a process
- `pkill -9 processname` – Kill all instances of a process
- `kill -STOP PID` – Stop a running process
- `kill -CONT PID` – Resume a stopped process
- `renice -n 10 -p PID` – Lower priority of a process; ranges from -20 (highest priority) to 19 (lowest priority)
- `renice -n -5 -p PID` – Increase priority of a process (requires root)

### Background & Foreground Processes
- `command &` – Run a command in the background
- `jobs` – List background jobs
- `fg %jobnumber` – Bring a job to the foreground
- `Ctrl + Z` – Suspend a running process
- `bg %jobnumber` – Resume a suspended process in the background

### Monitoring System Processes
- `top` – Interactive process viewer
- `htop` – User-friendly process viewer (requires installation)
- `nice -n 10 command` – Run a command with a specific priority
- `renice -n -5 -p PID` – Change priority of an existing process

### Daemon Process Management
- `systemctl list-units --type=service` – List all system daemons
- `systemctl start service-name` – Start a daemon/service
- `systemctl stop service-name` – Stop a daemon/service
- `systemctl enable service-name` – Enable a service at startup

## Viewing Process Details

### Using `ps`
Show processes for a specific user:
```bash
ps -u username
```
Show a process by name:
```bash
ps -C processname
```

### Using `pgrep`
Find a process by name and return its PID:
```bash
pgrep processname
```
`ps aux | grep processname` – Search the full list of running processes for a specific process name. This is useful for quickly finding whether a process is running and its associated PID(s).


### Using `pidof`
Find the PID of a running program:
```bash
pidof processname
```

## Managing Processes

### Killing Processes
To terminate a process by PID:
```bash
kill PID
```
To terminate using process name:
```bash
pkill processname
```
Force kill a process:
```bash
kill -9 PID
```
Kill all instances of a process:
```bash
pkill -9 processname
```
Sending Signals to Processes:

```bash
kill -3 PID
```
Sends the SIGQUIT signal to a process. Unlike kill -9 (force kill), SIGQUIT tells the process to terminate and optionally produce a core dump for debugging purposes.

Example:

```bash
kill -3 1234
```

- Here, 1234 is the PID of the process you want to signal.

Commonly used to debug Java processes, because many JVMs will print thread dumps when they receive SIGQUIT.

Unlike kill -9, the process can still perform cleanup before exiting.

Tip: Always prefer kill -15 (SIGTERM) or kill -3 for controlled termination before using kill -9 (SIGKILL) to avoid abrupt shutdowns.

### Stopping & Resuming Processes

Stop a running process:
```bash
kill -STOP PID
```
Resume a stopped process:
```bash
kill -CONT PID
```

### Changing Process Priority

Every Linux process has a priority that determines how the CPU schedules it relative to other processes. Higher-priority processes get more CPU time, while lower-priority processes may wait longer.

Nice Value (nice): Ranges from -20 (highest priority) to 19 (lowest priority).

Default is usually 0.

View process priorities:
```bash
top  # Look at the NI column
```
Change priority of a running process:
```bash
renice -n 10 -p PID  # Lower priority (positive values)
renice -n -5 -p PID  # Higher priority (negative values, root required)
```

### Running Processes in the Background
Run a command in the background:
```bash
command &
```
List background jobs:
```bash
jobs
```
Bring a job to the foreground:
```bash
fg %jobnumber
```
Send a running process to the background:
```bash
Ctrl + Z  # Suspend process
bg %jobnumber  # Resume in background
```

## Monitoring System Processes
### Using `top`
Interactive process viewer
Useful keys inside top:

- k → Kill process

- r → Renice process

- P → Sort by CPU

- M → Sort by memory

- q → Quit

### Using `htop`
A user-friendly alternative to `top`:
```bash
htop
```
Allows mouse-based interaction for process management.

### Using `nice` & `renice`
Run a command with a specific priority:
```bash
nice -n 10 command
```
Change the priority of an existing process:
```bash
renice -n -5 -p PID
```

## Daemon Processes
Daemon processes run in the background without user intervention.


List all system daemons:
```bash
systemctl list-units --type=service
```
Start a daemon:
```bash
systemctl start service-name
```
Stop a daemon:
```bash
systemctl stop service-name
```
Enable a service at startup:
```bash
systemctl enable service-name
```

## Conclusion
Process management is crucial for system performance and stability. By using tools like `ps`, `top`, `htop`, `kill`, and `nice`, you can efficiently control and monitor Linux processes.

#NOTE :

- Always try graceful termination first.

- Use kill -9 only when necessary.

- Learn to read top fluently.

- Understand process states.

- Treat services differently from temporary processes.

- Use kill -3 before killing Java apps in production.

- Use renice instead of killing when performance tuning.

- Think before acting on production servers.
