# Linux System Monitoring

Monitoring system resources is essential to ensure optimal performance, detect issues, and troubleshoot problems in Linux. Various tools allow us to monitor CPU, memory, disk usage, network activity, and running processes.

### CPU and Memory Monitoring
- `top` – Real-time system monitoring
- `htop` – Interactive process viewer (requires installation)
- `vmstat` – Report system performance statistics
- `free -m` – Show memory usage
- `free -h` – Show memory usage- more user friendly
- `nproc` - used to display the number of processing units (CPU cores) available to the current process.

### Disk Monitoring
- `df -h` – Check disk space usage
- `du -sh /path` – Show disk usage of a specific directory
- `iostat` – Display CPU and disk I/O statistics

### Network Monitoring
- `ifconfig` – Show network interfaces (deprecated, use `ip a`)
- `ip a` – Show network interface details
- `netstat -tulnp` – Show active connections and listening ports
- `ss -tulnp` – Alternative to `netstat` for socket statistics
- `ping hostname` – Test network connectivity
- `traceroute hostname` – Show network path to a host
- `nslookup domain` – Get DNS resolution details

### Log Monitoring
- `tail -f /var/log/syslog` – Live monitoring of system logs
- `journalctl -f` – Live system logs for systemd-based distros
- `dmesg | tail` – View kernel logs

## CPU and Memory Monitoring
### Using `top`
To view real-time CPU and memory usage:
```bash
top
```
Press `q` to quit.

### Using `htop`
A user-friendly alternative:
```bash
htop
```
Use arrow keys to navigate and `F9` to kill processes.

### Using `vmstat`
To check CPU, memory, and I/O stats:
```bash
vmstat 1 5  # Update every 1 sec, show 5 updates
```

### Checking Memory Usage
```bash
free -m
```
Shows free and used memory in megabytes.

```bash
free -h
```
Shows free and used memory in a more user friendly way.

## Disk Monitoring
### Using `df`
Check available disk space:
```bash
df -h
```
### Using `du`
Find the size of a directory:
```bash
du -sh /var/log
```
### Using `iostat`
Check disk and CPU usage:
```bash
iostat
```

## Network Monitoring
### Checking Network Interfaces
```bash
ip a  # Show IP addresses and interfaces
```
### Viewing Open Ports and Connections
```bash
netstat -tulnp  # Show listening ports
ss -tulnp  # Alternative to netstat
```
### Testing Connectivity
```bash
ping google.com  # Test internet connection
traceroute google.com  # Trace the path to Google
```
### Checking DNS Resolution
```bash
nslookup example.com
```

## Log Monitoring
### Live Monitoring of System Logs
```bash
tail -f /var/log/syslog  # Follow logs in real-time
journalctl -f  # Systemd logs
```
### Checking Kernel Logs
```bash
dmesg | tail
```

The commands covered in this module (top, free, df, ss, iostat, journalctl, etc.) are primarily used for:

- Quick troubleshooting

- On-the-spot performance checks

- Investigating resource spikes

- Debugging production issues directly on a server

These tools are essential for immediate, manual diagnostics when logged into a Linux machine.

## Monitoring in Real DevOps Scenarios

In modern DevOps and production environments, Linux servers are typically integrated with centralized monitoring systems rather than relying only on manual commands.

Common industry-standard tools include:

- Prometheus – Collects and stores time-series metrics from servers and applications.

- Grafana – Visualizes metrics through dashboards and alerts.

- Nagios – Infrastructure monitoring and alerting.

- Zabbix – Enterprise-grade monitoring platform.

## How It Works in Production

Instead of manually running top:

- Metrics are automatically collected

- Dashboards display CPU, memory, disk, and network usage

- Alerts are triggered when thresholds are exceeded

- Teams receive notifications via Slack, email, or PagerDuty
