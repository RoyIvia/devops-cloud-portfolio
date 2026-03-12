
# Internet Protocol (IP)

The **Internet Protocol (IP)** is a core networking protocol responsible for defining how data is addressed and routed across networks.

IP establishes the rules for **relaying and routing packets across the internet**.

Key responsibilities of IP include:

- identifying devices on a network using IP addresses
- routing packets between networks
- enabling communication between devices across the internet
- supporting subnetting to divide networks into smaller segments

IP operates at **Layer 3 (Network Layer)** of the OSI model.

IP itself does **not guarantee delivery** of packets. It simply determines how packets move across networks.

Because of this, IP is commonly paired with **Transmission Control Protocol (TCP)** as part of the **TCP/IP protocol suite**, which forms the foundation of internet communication.



# IP Addresses

An **IP address** uniquely identifies a device on a network.

Every device connected to a network must have an IP address in order to send or receive data.

An IP address serves two primary functions:

1. **Host Identification** – identifies a specific device on a network
2. **Location Addressing** – identifies the network where the device resides

IP addresses operate at **Layer 3 (Network Layer)** of the OSI model.

---

# Dynamic vs Static IP Addresses

IP addresses can be assigned either **dynamically** or **statically**.

## Dynamic IP Address

A **dynamic IP address** is automatically assigned by a service such as DHCP and can change over time.

Dynamic addressing is useful for devices such as:

- laptops
- mobile devices
- temporary network clients

These devices frequently join and leave networks.

---

## Static IP Address

A **static IP address** does not change once it has been assigned.

Static addresses are commonly used for devices that must always be reachable at the same address, such as:

- servers
- network routers
- printers
- databases

---

# Public vs Private IP Addresses

IP addresses can also be categorized as **public** or **private**.

## Public IP Address

A **public IP address** is globally unique and can be accessed over the internet.

Example:

```
54.239.28.85
```

Any device connected to the internet can communicate with a public IP address.

Public IPs are typically assigned to:

- websites
- cloud servers
- internet-facing applications

---

## Private IP Address

A **private IP address** is used within a private network and cannot be accessed directly from the internet.

Private IP ranges are defined by **RFC 1918**.

| Private Range | CIDR Block |
|---------------|------------|
| 10.0.0.0 – 10.255.255.255 | 10.0.0.0/8 |
| 172.16.0.0 – 172.31.255.255 | 172.16.0.0/12 |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

Private IP addresses are commonly used for:

- internal servers
- databases
- corporate networks
- cloud VPC infrastructure

---

# IP Addresses in AWS (Example: EC2)

In cloud environments such as AWS, compute resources such as **EC2 instances** may have both:

- **Private IP addresses** (used inside the VPC)
- **Public IP addresses** (used for internet access)

Example architecture:

```
Internet
   │
   ▼
Public IP
   │
   ▼
EC2 Instance
   │
   ▼
Private IP
```

Private IPs handle internal communication within the VPC, while public IPs enable internet connectivity.

AWS also provides **Elastic IP addresses (EIP)**, which are static public IP addresses that remain associated with an instance even after restarts.

---

# Special Purpose IP Addresses

Within a network range, some IP addresses have special purposes.

### Default Gateway

The **default gateway** is typically the router address used by devices to access other networks.

Example:

```
10.0.0.1
```

It is the address of the network router.

---

### Broadcast Address

The **broadcast address** is used to send data to all devices on a network.

Example:

```
10.255.255.255
```

When a packet is sent to a broadcast address, every device on that network receives it.

---

# IPv4 Address Structure

An **IPv4 address** is a **32-bit number** represented as four decimal numbers separated by periods.

Example:

```
10.100.20.5
```

Each number represents **8 bits**, also known as an **octet**.

```
8 bits + 8 bits + 8 bits + 8 bits = 32 bits
```

Each octet can range from **0 to 255**.

This format is called a **dotted decimal notation**.

---

# Network Portion vs Host Portion

An IPv4 address consists of two components:

1. **Network portion**
2. **Host portion**

Example:

```
10.0.0.1
```

```
Network: 10.0.0
Host:    1
```

The **network portion** identifies the network, while the **host portion** identifies the device within that network.

Subnetting determines how these portions are divided.

---

# IPv6 Addressing

IPv6 was developed to address the limitations of IPv4 address exhaustion.

IPv6 addresses use **128 bits** instead of 32 bits.

Example IPv6 address:

```
2600:1f18:22ba:8c00:ba86:a05e:a5ba:00ff
```

Advantages of IPv6 include:

- significantly larger address space
- improved routing efficiency
- better support for modern networking
- improved security features

IPv4 supports approximately **4.3 billion addresses**, while IPv6 supports approximately **340 undecillion addresses**.

---

# Binary Representation of IP Addresses

IPv4 addresses are stored as binary numbers.

Each decimal number in the IP address corresponds to **8 binary bits**.

Example IP:

```
219.103.21.59
```

Binary conversion:

```
219 = 11011011
103 = 01100111
21  = 00010101
59  = 00111011
```

Final binary representation:

```
11011011.01100111.00010101.00111011
```

Total bits:

```
32 bits
```

---

# Port Numbers

A **port number** identifies a specific application or service running on a device.

While an **IP address identifies a device**, a **port identifies the application endpoint**.

Example analogy:

- IP address = phone number
- port number = phone extension

Example endpoint:

```
192.168.1.10:80
```

Where:

- 192.168.1.10 = device
- 80 = web server

---

# Common Port Numbers

| Port | Protocol | Use |
|-----|------|------|
| 22 | SSH | Secure remote access |
| 53 | DNS | Domain name resolution |
| 80 | HTTP | Web traffic |
| 443 | HTTPS | Secure web traffic |
| 3389 | RDP | Remote desktop connection |

Port numbers allow a computer to handle multiple types of network communication simultaneously.

For example, a computer may:

- host a website
- download files
- stream video
- receive email

All at the same time, using different ports.

---

# Troubleshooting Layer 3 Issues

Layer 3 problems often involve:

- unreachable hosts
- latency
- routing failures
- incorrect IP assignments

Common troubleshooting commands include:

### Ping

Tests connectivity between devices.

```
ping 8.8.8.8
```

---

### Traceroute

Shows the path packets take across networks.

```
traceroute google.com
```

Each device in the path is called a **hop**.

Traceroute helps identify where packet loss or delays occur.

---

# Why IP Addressing Matters for DevOps

Understanding IP addressing is essential for DevOps engineers because modern infrastructure relies heavily on network communication.

Examples include:

- designing VPC networks
- configuring load balancers
- troubleshooting microservices
- debugging connectivity issues
- configuring security groups and firewalls

Understanding how IP addressing works allows engineers to **trace problems across distributed systems and cloud infrastructure**.
