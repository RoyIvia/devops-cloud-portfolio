# Linux Logging and Log Management

Logging is one of the most important aspects of operating Linux systems in production environments. Logs provide visibility into system behavior, application activity, service failures, security events, and performance issues.

For DevOps engineers and system administrators, the ability to locate, read, analyze, and troubleshoot logs is essential for maintaining reliable infrastructure.

Linux systems typically store logs in the `/var/log` directory and manage them using tools such as:

- `journalctl` (systemd logs)
- `rsyslog` (traditional logging system)
- `logrotate` (log rotation and cleanup)

Understanding how to work with logs is critical for debugging production systems and monitoring server health.

---

# Linux Log Directory

Most Linux log files are stored in:

```
/var/log
```

View the contents of the log directory:

```bash
ls /var/log
```

Common log files include:

| Log File | Purpose |
|------|------|
| `/var/log/syslog` | General system logs |
| `/var/log/auth.log` | Authentication and SSH login attempts |
| `/var/log/kern.log` | Kernel logs |
| `/var/log/dmesg` | Boot and hardware logs |
| `/var/log/nginx/` | Nginx web server logs |
| `/var/log/mysql/` | MySQL database logs |
| `/var/log/docker.log` | Docker daemon logs |

---

# Viewing Log Files

## Using `cat`

Display the entire log file:

```bash
cat /var/log/syslog
```

This prints the full file, which may be very large.

---

## Using `less`

View logs interactively:

```bash
less /var/log/syslog
```

Useful navigation keys:

| Key | Action |
|----|----|
| `q` | quit |
| `space` | next page |
| `b` | previous page |
| `/keyword` | search |

This is commonly used for inspecting logs safely.

---

## Using `tail`

View the last lines of a log file:

```bash
tail /var/log/syslog
```

View the last 50 lines:

```bash
tail -n 50 /var/log/syslog
```

---

## Live Log Monitoring

Follow logs in real time:

```bash
tail -f /var/log/syslog
```

This is extremely useful for monitoring logs while debugging services.

Example:

```bash
tail -f /var/log/nginx/access.log
```

---

# Searching Logs

Large logs require filtering tools.

## Using `grep`

Search for specific events:

```bash
grep "error" /var/log/syslog
```

Example:

```bash
grep "Failed password" /var/log/auth.log
```

This is useful for detecting SSH brute-force attempts.

---

## Combine `tail` and `grep`

```bash
tail -f /var/log/syslog | grep error
```

This shows only error messages in real time.

---

# System Logs with journalctl

Modern Linux systems using **systemd** store logs in the system journal.

The `journalctl` command allows you to query and filter system logs.

---

## View All Logs

```bash
journalctl
```

---

## View Logs from Current Boot

```bash
journalctl -b
```

---

## View Logs from Previous Boot

```bash
journalctl -b -1
```

---

## View Logs for a Specific Service

```bash
journalctl -u nginx
```

Example:

```bash
journalctl -u docker
```

---

## Follow Logs in Real Time

```bash
journalctl -f
```

Follow logs for a specific service:

```bash
journalctl -u nginx -f
```

---

## Show Recent Logs

Display the last 50 entries:

```bash
journalctl -n 50
```

---

# Kernel Logs

Kernel messages can be viewed using:

```bash
dmesg
```

Example output includes:

- hardware initialization
- device drivers
- system boot messages

View in readable format:

```bash
dmesg | less
```

---

# Log Rotation

Logs grow continuously and can eventually consume disk space.

Linux uses **logrotate** to manage log files.

Logrotate:

- compresses old logs
- deletes outdated logs
- creates new log files
- prevents disks from filling up

---

## Logrotate Configuration

Main configuration file:

```
/etc/logrotate.conf
```

Additional service configurations:

```
/etc/logrotate.d/
```

Example:

```
/etc/logrotate.d/nginx
```

---

## Manual Log Rotation

Force log rotation:

```bash
sudo logrotate -f /etc/logrotate.conf
```

---

# Example Troubleshooting Workflow

Example scenario: a web server is failing.

### Step 1: Check service status

```bash
systemctl status nginx
```

### Step 2: Inspect logs

```bash
journalctl -u nginx -n 50
```

### Step 3: Inspect web logs

```bash
tail -f /var/log/nginx/error.log
```

### Step 4: Search for errors

```bash
grep error /var/log/nginx/error.log
```

---

# Example: Investigating Failed SSH Logins

Check authentication logs:

```bash
cat /var/log/auth.log
```

Search failed login attempts:

```bash
grep "Failed password" /var/log/auth.log
```

Count attack attempts:

```bash
grep "Failed password" /var/log/auth.log | wc -l
```

---

# Useful Log Commands Summary

| Command | Purpose |
|------|------|
| `cat` | display entire log file |
| `less` | scroll through logs |
| `tail` | view last lines |
| `tail -f` | monitor logs live |
| `grep` | search logs |
| `journalctl` | query systemd logs |
| `dmesg` | kernel logs |

---

# Why Logging Matters for DevOps

Logs are the **primary source of truth** when diagnosing problems in distributed systems.

DevOps engineers rely on logs to:

- debug application failures
- investigate outages
- detect security incidents
- monitor system behavior
- analyze production issues

Without logs, troubleshooting production systems becomes nearly impossible.
