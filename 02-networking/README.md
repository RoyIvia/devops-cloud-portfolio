# Networking Fundamentals for DevOps & Cloud Engineering

This section documents my foundational understanding of networking concepts required to design, deploy, and troubleshoot modern distributed systems.

This module focuses on how networking directly impacts:
- Cloud infrastructure (AWS VPC design)
- Containerised workloads (Docker & Kubernetes networking)
- System reliability and debugging
- Security boundaries and access control

Networking is a core competency in DevOps. Misconfigured networking is one of the most common causes of system failure in production environments.

## Learning Objectives

By completing this section, I can:

- Explain how data moves across systems using the OSI and TCP/IP models
- Design IP addressing schemes using CIDR and subnetting
- Differentiate between TCP and UDP based on system requirements
- Debug connectivity issues using Linux networking tools
- Understand and design cloud networking architectures (VPCs, subnets, routing)
- Apply security controls using firewalls (Security Groups, NACLs)

##  Core Concepts

### 1. OSI Model (System-Level Understanding)

The OSI model provides a mental framework for debugging and designing systems.

| Layer | Responsibility |
|------|----------------|
| Application | User-facing protocols (HTTP, DNS) |
| Transport | Reliable vs fast delivery (TCP/UDP) |
| Network | Routing and IP addressing |
| Data Link | Local network communication (MAC) |
| Physical | Hardware transmission |

**Engineering Insight:**  
When debugging a failure (e.g., service not reachable), I use the OSI model to isolate the issue:
- DNS issue → Application layer  
- Port blocked → Transport layer  
- Routing issue → Network layer  

---

### 2. IP Addressing & Network Design

- IPv4 and IPv6 addressing
- Public vs Private IPs
- NAT for controlled internet access

**Example:**
```
192.168.1.0/24
```

- Defines a network range using CIDR notation
- Enables efficient allocation of IP space

**Engineering Insight:**  
Proper IP planning prevents overlapping networks and ensures scalability in cloud environments.

---

### 3. Subnetting & Network Segmentation

Subnetting allows logical separation of infrastructure.

**Use Cases:**
- Public subnet → Load balancers, bastion hosts
- Private subnet → Databases, internal services

**Engineering Insight:**  
Segmentation improves:
- Security (reduced attack surface)
- Fault isolation
- Traffic control

---

### 4. TCP vs UDP (Protocol Trade-offs)

| Feature | TCP | UDP |
|--------|-----|-----|
| Reliability | High | Low |
| Speed | Slower | Faster |
| Use Cases | HTTP, SSH | Streaming, DNS |

**Engineering Insight:**  
Protocol choice depends on system requirements:
- Use TCP when correctness matters
- Use UDP when latency matters

---

### 5. DNS (Service Discovery)

DNS translates human-readable domains into IP addresses.

**Key Records:**
- A → IPv4 mapping
- AAAA → IPv6 mapping
- CNAME → Alias
- MX → Mail routing

**Engineering Insight:**  
DNS failures often appear as application failures. Always verify resolution before debugging deeper layers.

---

### 6. Ports & Service Communication

Ports enable multiple services to run on a single machine.

**Common Ports:**
- 22 → SSH
- 80 → HTTP
- 443 → HTTPS

**Engineering Insight:**  
If a service is unreachable:
- Verify process is running
- Check port binding
- Confirm firewall rules

---

### 7. Cloud Networking (AWS Focus)

Core components of a production-grade VPC:

- **VPC** → Isolated network
- **Subnets** → Logical segmentation
- **Internet Gateway** → Public access
- **NAT Gateway** → Outbound internet for private resources
- **Route Tables** → Traffic control

**Engineering Insight:**  
A secure architecture always places critical resources (databases, internal APIs) in private subnets.

---

### 8. Network Security

#### Security Groups
- Stateful
- Instance-level control
- Allow rules only

#### Network ACLs
- Stateless
- Subnet-level control
- Allow and deny rules

**Engineering Insight:**  
Security groups handle most use cases. NACLs are used for stricter, network-wide policies.

---

## Practical Commands & Debugging

These are essential tools I use when troubleshooting:

```bash
# Check IP address
ip a

# Test connectivity
ping <host>

# Check listening ports
ss -tuln

# DNS resolution
nslookup <domain>
dig <domain>

# Trace network path
traceroute <host>
```

**Debugging Approach:**

1. Check DNS resolution
2. Verify network connectivity (ping)
3. Confirm port availability
4. Inspect firewall rules
5. Validate routing

---

## Practical Application (DevOps Context)

This knowledge directly applies to:

- Kubernetes networking (pods, services, ingress)
- CI/CD pipelines communicating across environments
- Debugging failed deployments
- Designing secure cloud architectures
- Observability systems (metrics/logs/traces transport)

---

## Common Failure Scenarios

| Issue | Root Cause |
|------|-----------|
| Cannot SSH into server | Port 22 blocked / wrong security group |
| Application not accessible | Port not exposed / service not running |
| DNS failure | Incorrect records / resolver issue |
| Slow response | Network congestion / latency |
| Service timeout | Routing or firewall misconfiguration |

