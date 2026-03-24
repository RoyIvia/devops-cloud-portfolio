
# CIDR Notation (Classless Inter-Domain Routing)

**CIDR (Classless Inter-Domain Routing)** is an IP addressing method used to allocate IP addresses more efficiently and describe ranges of IP addresses using a compact notation.

CIDR replaces the older **class-based IP addressing system (Class A, B, C)** and allows networks to be divided or aggregated with far more flexibility.

CIDR notation combines:

- an **IP address**
- a **prefix length**

Example:

```
192.168.1.0/24
```

The `/24` indicates that the first **24 bits** of the IP address represent the **network portion**, while the remaining bits represent the **host portion**.


# Why CIDR Exists

The original class-based addressing system caused major problems:

- large amounts of unused IP space
- inefficient IP allocation
- difficulty scaling the internet

CIDR was introduced to solve these problems by:

- allocating IP addresses more efficiently
- allowing flexible subnet sizes
- supporting route aggregation

CIDR allows networks to be split into **smaller networks (subnetting)** or combined into **larger networks (supernetting)**.


# CIDR Notation Format

CIDR notation is written as:

```
IP_address / prefix_length
```

Example:

```
192.168.1.0/24
```

Where:

- **192.168.1.0** = base network address  
- **24** = number of bits used for the network portion

IPv4 addresses contain **32 bits**, so the remaining bits are used for hosts.

```
Total bits = 32
Network bits = 24
Host bits = 8
```


# CIDR Binary Example

Example network:

```
192.168.1.0/24
```

Binary representation:

```
IP Address:
11000000.10101000.00000001.00000000

Network Portion (24 bits):
11111111.11111111.11111111.00000000
```

This means:

- first **24 bits are fixed**
- last **8 bits are flexible**


# Calculating Number of IP Addresses

The number of addresses in a CIDR block can be calculated using:

```
2^(host_bits)
```

Example:

```
192.168.1.0/24
```

Calculation:

```
32 - 24 = 8 host bits
2^8 = 256 addresses
```

Total addresses:

```
256
```

However, two addresses are reserved:

- **network address**
- **broadcast address**

Usable addresses:

```
254 hosts
```

# Common CIDR Prefix Examples

| CIDR | Subnet Mask | Total Addresses | Usable Hosts |
|-----|-------------|---------------|--------------|
| /8 | 255.0.0.0 | 16,777,216 | 16,777,214 |
| /16 | 255.255.0.0 | 65,536 | 65,534 |
| /24 | 255.255.255.0 | 256 | 254 |
| /25 | 255.255.255.128 | 128 | 126 |
| /26 | 255.255.255.192 | 64 | 62 |
| /27 | 255.255.255.224 | 32 | 30 |
| /28 | 255.255.255.240 | 16 | 14 |
| /29 | 255.255.255.248 | 8 | 6 |
| /30 | 255.255.255.252 | 4 | 2 |

These smaller CIDR blocks are often used for point-to-point connections or very small networks.


# CIDR Range Example

Example:

```
192.168.1.0/24
```

Range of addresses:

```
Network address:   192.168.1.0
First usable:      192.168.1.1
Last usable:       192.168.1.254
Broadcast address: 192.168.1.255
```

Total:

```
256 addresses
```

# Subnetting with CIDR

CIDR allows networks to be divided into smaller networks.

Example:

Original network:

```
192.168.1.0/24
```

Split into two subnets:

```
192.168.1.0/25
192.168.1.128/25
```

Each subnet contains:

```
128 addresses
```

# Supernetting with CIDR

CIDR can also combine multiple networks into a **larger network block**.

Example:

```
192.168.0.0/24
192.168.1.0/24
```

Can be summarized as:

```
192.168.0.0/23
```

This technique is called **route aggregation** or **supernetting**.

It helps reduce the size of internet routing tables.


# CIDR in Cloud Networking

CIDR is heavily used in cloud infrastructure.

Example AWS VPC:

```
VPC CIDR: 10.0.0.0/16
```

Subnets inside the VPC:

```
10.0.1.0/24   → Public Subnet
10.0.2.0/24   → Private Subnet
10.0.3.0/24   → Application Subnet
```

Architecture example:

```
Internet
   │
   ▼
VPC (10.0.0.0/16)
   │
   ├── Public Subnet (10.0.1.0/24)
   │       └── Load Balancer
   │
   └── Private Subnet (10.0.2.0/24)
           └── Application Servers
```

CIDR blocks help cloud engineers control:

- network segmentation
- routing
- security policies
- infrastructure scaling


# Why CIDR Matters for DevOps Engineers

CIDR notation is critical when designing and troubleshooting infrastructure.

DevOps engineers encounter CIDR when working with:

- VPC network design
- Kubernetes networking
- security groups and firewall rules
- load balancers
- container networking
- routing tables

Understanding CIDR allows engineers to:

- design scalable cloud networks
- prevent IP address conflicts
- efficiently allocate network space
- debug connectivity issues between services


CIDR is a core concept in modern networking and is heavily used in cloud platforms and distributed infrastructure.
