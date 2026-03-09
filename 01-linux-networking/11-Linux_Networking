# 11 - Linux Networking


Networking is a core skill for DevOps engineers. Modern infrastructure relies heavily on network communication between servers, containers, services, and cloud environments.

Understanding Linux networking tools allows engineers to troubleshoot connectivity issues, inspect traffic, debug service failures, and configure systems running in environments such as AWS, Kubernetes, and container platforms.

This section documents essential Linux networking commands used in real-world operations.

---

# Viewing Network Interfaces

## Display Network Interfaces

```bash
ip addr
```

Shows all network interfaces and their assigned IP addresses.

Example output includes:

* interface name
* IPv4 address
* IPv6 address
* network state

Older command (deprecated but still common):

```bash
ifconfig
```

---

# Checking IP Address

To quickly see the system's IP:

```bash
hostname -I
```

or

```bash
ip addr show
```

---

# Viewing Routing Table

The routing table determines where network packets are sent.

```bash
ip route
```

Example output:

```
default via 172.31.0.1 dev eth0
172.31.0.0/20 dev eth0 proto kernel scope link src 172.31.75.61
```

---

# Testing Connectivity

## Ping

Used to test network connectivity between systems.

```bash
ping google.com
```

Ping sends ICMP packets to check reachability.

Stop with:

```
Ctrl + C
```

---

# Checking Open Ports

## Using ss (recommended)

```bash
ss -tulnp
```

Options:

| Flag | Meaning                |
| ---- | ---------------------- |
| t    | TCP sockets            |
| u    | UDP sockets            |
| l    | listening ports        |
| n    | numeric addresses      |
| p    | process using the port |

Example output:

```
tcp LISTEN 0 128 0.0.0.0:22
```

---

# Checking Listening Services

Another useful command:

```bash
lsof -i
```

Shows processes using network connections.

---

# DNS Lookup

## Using dig

```bash
dig google.com
```

Shows DNS resolution details.

Alternative:

```bash
nslookup google.com
```

---

# Tracing Network Routes

## traceroute

Used to determine the path packets take to reach a host.

```bash
traceroute google.com
```

Shows each network hop between your machine and the destination.

---

# Checking Network Connections

```bash
netstat -tulnp
```

Note: `netstat` is older and largely replaced by `ss`.

---

# Testing Ports

## telnet

Test if a port is reachable:

```bash
telnet google.com 80
```

## nc (netcat)

```bash
nc -zv google.com 80
```

Useful for verifying service availability.

---

# Downloading Data From the Internet

## curl

```bash
curl https://example.com
```

Common DevOps use cases:

* testing APIs
* checking service responses
* downloading files

Download file:

```bash
curl -O https://example.com/file.zip
```

---

# Monitoring Network Traffic

## tcpdump

Used for packet capture and debugging.

Example:

```bash
sudo tcpdump -i eth0
```

Capture traffic for a specific port:

```bash
sudo tcpdump port 80
```

---

# Viewing Bandwidth Usage

## iftop

Shows real-time network bandwidth usage.

```bash
sudo iftop
```

---

# Firewall Management

Linux systems use firewall services to control network access.

## Using firewalld

Check status:

```bash
sudo systemctl status firewalld
```

Open a port:

```bash
sudo firewall-cmd --add-port=80/tcp --permanent
```

Reload firewall:

```bash
sudo firewall-cmd --reload
```

In cloud environments like AWS, firewall rules are often handled by **security groups** instead of local firewalls.

---

# Network Troubleshooting Workflow

When diagnosing connectivity issues, DevOps engineers typically follow this sequence:

1. Check IP address

```bash
ip addr
```

2. Verify routing

```bash
ip route
```

3. Test connectivity

```bash
ping host
```

4. Check listening services

```bash
ss -tulnp
```

5. Test specific ports

```bash
nc -zv host port
```

6. Inspect traffic

```bash
tcpdump
```

---

# Networking in Cloud Environments

In cloud platforms such as AWS, networking includes additional layers:

* Virtual Private Cloud (VPC)
* Subnets
* Security Groups
* Network ACLs
* Load Balancers

Linux networking tools are still essential for debugging issues within these environments.

---

# Key Takeaways

Networking knowledge is critical for troubleshooting distributed systems. DevOps engineers must be comfortable inspecting interfaces, testing connectivity, monitoring ports, and debugging traffic.

Mastering Linux networking tools enables engineers to diagnose issues quickly in cloud infrastructure, containerized workloads, and microservice architectures.
