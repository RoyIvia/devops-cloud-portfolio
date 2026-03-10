#  Linux Service Management

## Overview

Linux service management is a critical skill for system administrators, cloud engineers, and DevOps engineers. Most production workloads run as services, including web servers, databases, container runtimes, monitoring agents, and CI/CD runners.

Being able to start, stop, restart, enable, inspect, and troubleshoot services is essential when managing Linux systems in real environments.

Modern Linux distributions primarily use **systemd** as the init and service manager. Understanding `systemctl` and `journalctl` is therefore fundamental for operating and debugging Linux servers.

---

## What Is a Service?

A **service** is a background process managed by the operating system. Services typically run continuously and start automatically when the system boots.

Examples of common Linux services:

- `sshd` – SSH server  
- `nginx` – web server  
- `docker` – container runtime  
- `cron` / `crond` – job scheduler  
- `mysql` / `mariadb` – database server  

---

## What Is systemd?

`systemd` is the default **init system and service manager** used by most modern Linux distributions.

Examples include:

- Ubuntu  
- Debian  
- Amazon Linux  
- RHEL / Rocky / AlmaLinux  

systemd is responsible for:

- starting the operating system  
- managing background services  
- tracking service states  
- handling dependencies  
- collecting service logs  

The primary command used to interact with systemd is:

```bash
systemctl
```

---

## Checking Service Status

Inspect the status of a service:

```bash
systemctl status nginx
```

This command shows:

- whether the service is running
- whether it is enabled at boot
- the process ID
- recent logs for the service

---

## Starting a Service

```bash
sudo systemctl start nginx
```

Starts the service immediately but **does not enable it at boot**.

---

## Stopping a Service

```bash
sudo systemctl stop nginx
```

Stops the service.

---

## Restarting a Service

```bash
sudo systemctl restart nginx
```

Commonly used after:

- configuration changes
- updates
- troubleshooting

---

## Reloading a Service

```bash
sudo systemctl reload nginx
```

Reloads configuration **without restarting the service**.

---

## Enabling a Service at Boot

```bash
sudo systemctl enable nginx
```

Ensures the service starts automatically when the system boots.

---

## Disabling a Service

```bash
sudo systemctl disable nginx
```

Prevents the service from starting at boot.

---

## Checking Service State

```bash
systemctl is-active nginx
```

Possible outputs:

```
active
inactive
failed
```

Check if enabled at boot:

```bash
systemctl is-enabled nginx
```

---

## Listing Services

List running services:

```bash
systemctl list-units --type=service
```

List all service files:

```bash
systemctl list-unit-files --type=service
```

---

## Viewing Failed Services

```bash
systemctl --failed
```

Displays services that failed during startup.

---

## Reloading systemd

After modifying service files:

```bash
sudo systemctl daemon-reload
```

---

# Logging with journalctl

systemd stores logs using **journald**.

View all logs:

```bash
journalctl
```

View logs for a specific service:

```bash
journalctl -u nginx
```

Follow logs in real time:

```bash
journalctl -u nginx -f
```

Recent logs:

```bash
journalctl -u nginx -n 50
```

Logs from current boot:

```bash
journalctl -b
```

Previous boot:

```bash
journalctl -b -1
```

---

# Common Troubleshooting Workflow

1. Check service status

```bash
systemctl status nginx
```

2. Inspect logs

```bash
journalctl -u nginx -n 50
```

3. Validate configuration

```bash
sudo nginx -t
```

4. Restart service

```bash
sudo systemctl restart nginx
```

5. Verify it is running

```bash
systemctl is-active nginx
```

---

# Example: Troubleshooting Docker

Check service:

```bash
systemctl status docker
```

Check logs:

```bash
journalctl -u docker -n 50
```

Restart Docker:

```bash
sudo systemctl restart docker
```

Verify service:

```bash
systemctl is-active docker
```

---

# systemd Service Files

Service files are stored in:

```
/etc/systemd/system/
/usr/lib/systemd/system/
```

Files end with:

```
.service
```

Examples:

```
nginx.service
docker.service
```

---

# Example Service File

```ini
[Unit]
Description=Custom Python Application
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

After creating the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl start myapp
```

---

# Key systemctl Commands

| Command | Purpose |
|------|------|
| start | start service |
| stop | stop service |
| restart | restart service |
| reload | reload configuration |
| enable | start service at boot |
| disable | disable service at boot |

---

# Why This Matters for DevOps

DevOps engineers constantly interact with services in production environments.

Typical tasks include:

- restarting applications
- debugging failed services
- inspecting logs
- enabling services on servers
- managing container runtimes
- running monitoring agents

Understanding `systemctl` and `journalctl` is therefore **a fundamental Linux skill**.

---

# Key Takeaways

Linux service management is essential for operating production systems.

By mastering systemd tools such as `systemctl` and `journalctl`, engineers can:

- control service lifecycles
- debug system failures
- inspect logs
- automate service startup
- maintain reliable infrastructure
