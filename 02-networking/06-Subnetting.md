
# Subnetting

**Subnetting** is the process of dividing a large network into smaller, more manageable networks called **subnets (subnetworks)**.

A subnet is essentially a **network inside another network**.

Subnetting allows organizations to logically partition a single physical network into multiple smaller networks.

```
Before Subnetting

        Internet
            │
            ▼
        Router
            │
        144.28.0.0
```

```
After Subnetting

        Internet
            │
            ▼
        Router
           / \
          /   \
144.28.16.0   144.28.32.0
```

Instead of one large network, the network is divided into multiple smaller segments.



## Why Organizations Use Subnets

Organizations implement subnetting for several reasons:

### Reduce Network Traffic

Subnetting limits broadcast traffic to smaller groups of devices.

Smaller networks mean fewer devices receiving unnecessary traffic.


### Increase Network Performance

By dividing large networks into smaller subnets, data travels through **more efficient paths**, improving overall network speed.


### Improve Security

Subnets allow administrators to apply **security policies between network segments**.

For example:

```
Web Servers Subnet
        │
        ▼
Firewall / Security Group
        │
        ▼
Database Subnet
```

This segmentation prevents unauthorized access between systems.


### Improve IP Address Efficiency

Subnetting prevents organizations from allocating unnecessarily large address ranges.

Instead, networks can be sized according to actual needs.


### Support Large Distributed Networks

Subnetting allows organizations to manage networks across **multiple locations and geographic regions**, which is especially important in **cloud environments such as AWS**.


## Example of Subnet Benefits

Consider a network where multiple employees share a printer.

Without subnetting:

```
Network
   │
   ├── User A
   ├── User B
   ├── User C
   ├── User D
   ├── User E
   └── Printer
```

All users compete for the same network resources.

With subnetting:

```
Subnet A              Subnet B
   │                     │
   ├── User A            ├── User D
   ├── User B            ├── User E
   ├── Printer A         └── Printer B
   └── User C
```

Network traffic is reduced and systems operate more efficiently.


## How Subnetting Works

IPv4 addresses contain **32 bits**.

These bits are divided into two components:

1. **Network ID**
2. **Host ID**

```
|------ Network Portion ------|---- Host Portion ----|
```

The number of bits assigned to the network portion determines:

- how many subnets can exist
- how many hosts each subnet can support

Increasing the network portion increases the number of subnets but reduces available host addresses.


#3 IP Address Classes

Historically, IPv4 addresses were divided into classes.

| Class | First Octet Range | Network Bits |
|------|------------------|-------------|
| Class A | 0–126 | 8 |
| Class B | 128–191 | 16 |
| Class C | 192–223 | 24 |
| Class D | 224–239 | Multicast |
| Class E | 240–255 | Experimental |

### Example

| Class | Example Address |
|------|----------------|
| A | 34.126.35.125 |
| B | 134.23.45.123 |
| C | 212.11.123.3 |

Classes A, B, and C are commonly used for subnetting.

Class D is used for **multicast communication**, and Class E is reserved for experimental purposes.

Modern networks now rely primarily on **CIDR notation** rather than strict class-based addressing.


## Components of a Subnet

Every subnet includes several important elements.

### Network ID

The **Network ID** uniquely identifies the network itself.

Example:

```
192.168.1.0
```

This identifies the subnet.


### Subnet Mask

A **subnet mask** separates the network portion of the IP address from the host portion.

Example:

```
IP Address:   192.168.1.15
Subnet Mask:  255.255.255.0
```

Binary representation:

```
IP Address   11000000.10101000.00000001.00001111
Subnet Mask  11111111.11111111.11111111.00000000
```

The mask identifies which bits represent the network.


### Host Range

The **host range** contains the usable IP addresses available to devices.

Example:

```
Network Address:   192.168.1.0
Usable Host Range: 192.168.1.1 – 192.168.1.254
Broadcast Address: 192.168.1.255
```


### Broadcast Address

The **broadcast address** sends a message to every device on the subnet.

Example:

```
192.168.1.255
```

When a packet is sent to this address, all devices on the network receive it.


# Subnet Masks

A **subnet mask** is a 32-bit number used to divide an IP address into:

- network portion
- host portion

Subnet masks use:

- **1s for network bits**
- **0s for host bits**

Example subnet mask:

```
255.255.255.0
```

Binary representation:

```
11111111.11111111.11111111.00000000
```

This indicates the first **24 bits** represent the network.


### Common Subnet Masks

| Subnet Mask | CIDR | Hosts per Network |
|-------------|------|------------------|
| 255.0.0.0 | /8 | 16,777,214 |
| 255.255.0.0 | /16 | 65,534 |
| 255.255.255.0 | /24 | 254 |

The usable host count is always calculated as:

```
2^host_bits - 2
```

Two addresses are reserved:

- network address
- broadcast address


## Why Subnet Masks Are Important

Subnet masks help determine:

- which devices are on the same network
- which devices require routing through a gateway
- how traffic should be segmented

Devices on the **same subnet communicate directly**, while devices on different networks communicate through a **router**.


## Subnetting in Cloud Environments

Subnetting is heavily used in **cloud networking**.

Example AWS architecture:

```
VPC (10.0.0.0/16)
│
├── Public Subnet (10.0.1.0/24)
│       └── Load Balancer
│
└── Private Subnet (10.0.2.0/24)
        └── Application Servers
```

Benefits in cloud infrastructure include:

- network segmentation
- improved security
- controlled traffic routing
- scalable infrastructure design


## Why Subnetting Matters for DevOps

Subnetting is essential for designing **secure and scalable infrastructure**.

DevOps engineers use subnetting when:

- designing VPC networks
- deploying microservices
- creating private and public subnets
- configuring load balancers
- controlling traffic flow between services

Understanding subnetting helps engineers:

- optimize network performance
- improve security architecture
- design scalable cloud environments
