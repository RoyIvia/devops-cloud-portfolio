# Networking Fundamentals

Networking is a foundational concept in modern computing. Cloud infrastructure, distributed systems, container orchestration platforms, and DevOps tooling all depend on reliable communication between systems.

Understanding networking fundamentals allows engineers to design scalable systems, troubleshoot infrastructure issues, and build secure cloud environments.

This document introduces the core networking concepts including network components, communication models, the OSI model, transmission media, network topology, and how these concepts translate into modern cloud infrastructure.


# What is a Computer Network

A **computer network** is a collection of interconnected devices that communicate with each other and share resources using standardized communication protocols.

These devices may include:

- servers
- laptops
- mobile devices
- routers
- switches
- cloud instances
- IoT devices

Networks allow systems to exchange information such as files, API requests, database queries, and web pages.

Without networking, distributed computing and the internet would not exist.


# Nodes and Hosts

## Node

A **node** is any device connected to a network that can send, receive, or forward data.

Examples include:

- computers
- routers
- switches
- printers
- servers
- virtual machines

Any device participating in network communication is considered a node.


## Host

A **host** is a node that performs a specific function or service within a network.

Examples include:

- web servers
- database servers
- DNS servers
- application servers

In cloud environments, hosts are commonly virtual machines or containers running inside cloud infrastructure.


# Basic Network Communication

A simple network communication path may look like:

Node A → NIC → Switch → Router → Switch → NIC → Node B

Example:

Laptop → Switch → Router → Internet → Router → Switch → Server

Each component forwards data toward its destination.

Switches manage communication within local networks, while routers connect different networks together.


# Network Interface Card (NIC)

A **Network Interface Card (NIC)** is a hardware component that allows a device to connect to a network.

Every network-enabled device contains at least one NIC.

Functions of a NIC include:

- connecting a device to a network
- sending and receiving data
- converting digital signals into network signals
- storing a unique hardware identifier known as a **MAC address**

NICs may exist as:

- physical hardware
- virtual network interfaces in virtual machines
- virtual interfaces in containers


# MAC Address

A **MAC address (Media Access Control address)** is a unique identifier assigned to a network interface.

Example:

```
00:1A:2B:3C:4D:5E
```

Characteristics:

- unique per network interface
- assigned by the hardware manufacturer
- operates at **Layer 2 (Data Link Layer)** of the OSI model
- used for communication inside local networks

Switches rely on MAC addresses to determine where to forward frames within a LAN.


# The OSI Model

The **OSI (Open Systems Interconnection) Model** is a conceptual framework used to understand how data moves across a network.

It divides communication into **seven layers**, each responsible for a specific function.

| Layer | Name |
|------|------|
| 7 | Application |
| 6 | Presentation |
| 5 | Session |
| 4 | Transport |
| 3 | Network |
| 2 | Data Link |
| 1 | Physical |

Each layer interacts with the layer above and below it.


# OSI Layers Explained

## Layer 7 – Application Layer

The Application Layer is where user applications interact with the network.

Examples include:

- web browsers
- email clients
- APIs

Protocols include:

- HTTP
- HTTPS
- FTP
- SMTP


## Layer 6 – Presentation Layer

Responsible for formatting data so it can be properly transmitted.

Functions include:

- encryption and decryption
- compression
- data translation

For example, encrypted HTTPS communication occurs here.


## Layer 5 – Session Layer

The Session Layer manages communication sessions between systems.

Responsibilities include:

- session establishment
- session management
- session termination


## Layer 4 – Transport Layer

The Transport Layer ensures reliable communication between hosts.

Protocols include:

- TCP (Transmission Control Protocol)
- UDP (User Datagram Protocol)

Responsibilities include:

- segmentation of data
- reliability
- flow control
- error handling


## Layer 3 – Network Layer

The Network Layer handles **logical addressing and routing**.

This is where **IP addresses operate**.

Routers function primarily at this layer.

Protocols include:

- IPv4
- IPv6
- ICMP


## Layer 2 – Data Link Layer

The Data Link Layer manages communication within a local network.

Responsibilities include:

- framing
- MAC addressing
- error detection

Switches operate primarily at this layer.


## Layer 1 – Physical Layer

The Physical Layer represents the actual transmission of raw bits across physical media.

Examples include:

- electrical signals
- fiber optic signals
- network cables
- wireless signals


# Data Encapsulation

As data travels down the OSI model, each layer adds its own header. This process is called **encapsulation**.

```
Application Data
↓
Segment (Transport Layer)
↓
Packet (Network Layer)
↓
Frame (Data Link Layer)
↓
Bits (Physical Layer)
```

The receiving system processes these layers in reverse order.


# Network Transmission Media

## Twisted Pair Cable

The most common cable used in Ethernet networks.

Examples include:

- Cat5
- Cat6
- Cat7

Characteristics:

- inexpensive
- flexible
- widely used in LAN environments


## Coaxial Cable

Coaxial cables use a single copper conductor surrounded by insulation.

Historically used in:

- cable television networks
- early Ethernet systems


## Fiber Optic Cable

Fiber optic cables transmit data using **light signals** instead of electrical signals.

Advantages include:

- extremely high speed
- long-distance communication
- resistance to electromagnetic interference

Fiber optic networks form the backbone of internet infrastructure and cloud data centers.


# Types of Computer Networks

## Local Area Network (LAN)

A **LAN** connects devices within a small geographic area.

Examples include:

- home networks
- office networks
- campus networks

Characteristics:

- high speed
- low latency
- locally managed


## Wide Area Network (WAN)

A **WAN** connects multiple LANs across large geographic distances.

Examples include:

- the internet
- global enterprise networks
- cloud provider infrastructure


# Network Topology

Network topology describes how network devices are arranged and connected.

Two categories exist:

- physical topology
- logical topology

# Physical Topology

Physical topology describes the **actual layout of devices and cables** in a network.

It shows how nodes, switches, and routers are physically connected.

Common physical network topologies include:

- Bus
- Star
- Mesh (Full and Partial)
- Hybrid


## Bus Topology

In a **Bus topology**, all devices connect to a single central cable called the backbone.

```
Computer A ────┐
               │
Computer B ────┼──────── Backbone Cable ───────
               │
Computer C ────┘
```

### Characteristics

- simple design
- inexpensive
- easy to install

### Disadvantages

- if the backbone cable fails, the entire network fails
- difficult to troubleshoot
- limited scalability

Bus topology was common in early Ethernet networks but is rarely used today.


## Star Topology

In a **Star topology**, all devices connect to a central device such as a switch or hub.

```
        Computer A
            │
            │
Computer B ── Switch ── Computer C
            │
            │
        Computer D
```

### Characteristics

- most common modern LAN topology
- easy to manage and troubleshoot
- easy to add or remove devices

### Disadvantages

- failure of the central switch disconnects all nodes

Modern Ethernet networks typically use star topology with switches.


## Mesh Topology

In a **Mesh topology**, devices connect to multiple other devices to provide redundancy and fault tolerance.

### Full Mesh Topology

Every device connects directly to every other device.

```
      Computer A
       /   |   \
      /    |    \
Computer B─┼────Computer C
      \    |    /
       \   |   /
      Computer D
```

### Characteristics

- very reliable
- no single point of failure
- multiple paths for data

### Disadvantages

- expensive
- complex to maintain
- large number of connections required

Full mesh networks are common in **core internet infrastructure** and **data center backbones**.


### Partial Mesh Topology

In **Partial Mesh**, only critical devices have redundant connections.

```
        Router A
        /     \
       /       \
  Router B     Router C
       \         /
        \       /
        Router D
```

### Characteristics

- balance between redundancy and cost
- commonly used in enterprise networks


## Hybrid Topology

A **Hybrid topology** combines multiple topology types.

Example: Star + Mesh

```
             Core Router
           /      |      \
        Switch   Switch   Switch
         /  \      |      /  \
       PC   PC    PC    PC   PC
```

Most real-world enterprise and cloud networks use hybrid topology.


# Logical Topology

Logical topology describes **how data flows through a network**, regardless of the physical connections.

Cloud networking relies heavily on logical network design.

For example, in AWS:

```
VPC
 ├── Public Subnet
 │    └── Web Server
 │
 └── Private Subnet
      └── Database
```

Even though infrastructure may run on many physical machines, networking is logically controlled through software.

# Virtual Private Cloud (VPC)

A **Virtual Private Cloud (VPC)** is a logically isolated network within a cloud provider.

Example AWS structure:

```
AWS Account
   ↓
VPC
   ↓
Subnets
   ↓
EC2 Instances
```

A VPC allows organizations to define:

- IP address ranges
- routing rules
- network segmentation
- internet connectivity
- security policies


# Traditional Networking vs Cloud Networking

| Traditional Networking | Cloud Equivalent |
|---|---|
| Isolated Network | VPC |
| Network Segment | Subnet |
| Firewall | Security Groups / NACL |
| Server | EC2 Instance |

Cloud platforms abstract physical networking infrastructure while maintaining the same networking principles.


# Network Management Models

## Client-Server Model

In this model, clients request services from centralized servers.

Example:

```
Client → Web Server → Database
```

Examples include:

- web applications
- APIs
- email systems
- cloud services

Most modern systems use the client-server architecture.


## Peer-to-Peer Model

In peer-to-peer networks, devices communicate directly with each other without centralized servers.

Examples include:

- file sharing networks
- blockchain networks
- distributed storage systems

Peer-to-peer networks distribute workloads across multiple nodes.


# Why Networking Matters for DevOps

Networking knowledge is essential for DevOps engineers because modern infrastructure relies on distributed systems.

Networking concepts appear in areas such as:

- cloud VPC architecture
- container networking
- Kubernetes networking
- load balancing
- DNS resolution
- firewall configuration
- microservice communication

Understanding networking fundamentals enables engineers to design secure, scalable, and reliable infrastructure.

