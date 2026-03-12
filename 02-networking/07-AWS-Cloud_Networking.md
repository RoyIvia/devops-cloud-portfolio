
# Networking in the AWS Cloud

Cloud networking follows the same fundamental principles as traditional networking in on-premises data centers. However, in cloud environments the physical infrastructure is replaced by **virtualized networking components** that can be created and managed programmatically.

AWS provides these networking capabilities primarily through **Amazon Virtual Private Cloud (Amazon VPC)**.

---

# Traditional Networking vs AWS Networking

Many AWS networking components correspond to familiar infrastructure components found in traditional data centers.

| Traditional Infrastructure | AWS Equivalent |
|---|---|
| Data Center | Amazon VPC |
| Router | Route Tables |
| Switches | Subnets |
| Firewall | Security Groups / Network ACLs |
| Servers | EC2 Instances |
| Modem / ISP Gateway | Internet Gateway |

Although the implementations differ, the architectural concepts remain very similar.

For example:

```
Traditional Data Center

Internet
   │
 Router
   │
 Switch
   │
 Servers
```

```
AWS Cloud Networking

Internet
   │
Internet Gateway
   │
Route Table
   │
Subnet
   │
EC2 Instances
```

---

# What is Amazon VPC

**Amazon Virtual Private Cloud (Amazon VPC)** is a service that allows you to create a **logically isolated virtual network** inside the AWS Cloud.

Within a VPC you can launch and manage AWS resources such as:

- EC2 instances
- load balancers
- databases
- storage services

A VPC allows you to define your own:

- IP address ranges
- subnets
- routing rules
- gateways
- security policies

In essence, a VPC functions like a **virtual data center inside AWS**.

---

# Why Use Amazon VPC

Amazon VPC provides several benefits compared to traditional on-premises networking.

### Rapid Provisioning

Entire network environments can be created in minutes instead of requiring physical infrastructure setup.

### Cost Efficiency

Organizations only pay for the resources they use rather than maintaining physical networking equipment.

### Scalability

Cloud networks can scale automatically as applications grow.

### Security

Multiple security layers are available, including:

- Security Groups
- Network ACLs
- private networking
- encrypted communication

### Multiple Environments

You can create multiple VPCs for:

- development
- testing
- staging
- production

---

# Key Features of Amazon VPC

An Amazon VPC has several defining characteristics.

### Account Scoped

A VPC belongs to a specific AWS account.

### Regional Resource

A VPC exists within a single **AWS Region**.

### Multi-Availability Zone Support

A VPC can span multiple **Availability Zones** within that region.

### Logical Isolation

Each VPC is isolated from other VPCs unless explicitly connected.

Example:

```
AWS Region
   │
   ├── VPC A
   ├── VPC B
   └── VPC C
```

Each VPC functions as an independent network.

---

# IP Addressing in Amazon VPC

When creating a VPC, you must define an **IPv4 CIDR block** that determines the address space of the network.

Example:

```
10.0.0.0/16
```

This CIDR block defines the range of IP addresses available inside the VPC.

Allowed CIDR sizes for a VPC range from:

```
/16  (65,536 addresses)
to
/28  (16 addresses)
```

---

# Private IP Address Ranges (RFC 1918)

AWS recommends using private IPv4 address ranges defined in **RFC 1918**.

| Private Range | Example VPC CIDR |
|---|---|
| 10.0.0.0 – 10.255.255.255 | 10.0.0.0/16 |
| 172.16.0.0 – 172.31.255.255 | 172.31.0.0/16 |
| 192.168.0.0 – 192.168.255.255 | 192.168.0.0/16 |

Using private ranges prevents conflicts with publicly routable internet addresses.

---

# Reserved IP Addresses in AWS Subnets

Within each subnet, AWS reserves **five IP addresses**.

Example subnet:

```
10.0.0.0/24
```

Reserved addresses:

| Address | Purpose |
|---|---|
| 10.0.0.0 | Network address |
| 10.0.0.1 | VPC router |
| 10.0.0.2 | DNS server |
| 10.0.0.3 | Reserved for future use |
| 10.0.0.255 | Broadcast address |

These addresses cannot be assigned to instances.

---

# Core Amazon VPC Components

Several components work together to provide networking inside a VPC.

Key components include:

- VPC
- Subnets
- Route tables
- Internet gateway
- NAT gateway
- Security groups
- Network ACLs
- VPC endpoints

---

# Subnets

A **subnet** is a range of IP addresses inside a VPC.

Each subnet:

- exists in **one Availability Zone**
- cannot span multiple zones
- is used to group resources logically

Subnets are commonly categorized as:

### Public Subnet

A subnet with a route to an **Internet Gateway**.

Resources inside can be accessed from the internet.

Example resources:

- load balancers
- bastion hosts
- public web servers

---

### Private Subnet

A subnet without direct internet access.

Resources inside are typically internal services such as:

- databases
- application servers
- internal microservices

Private subnets can still reach the internet using a **NAT gateway**.

---

# Route Tables

A **route table** defines how traffic moves within the VPC.

Each route table contains:

- **destination** (CIDR block)
- **target** (gateway or interface)

Example:

| Destination | Target |
|---|---|
| 10.0.0.0/16 | local |
| 0.0.0.0/0 | Internet Gateway |

Route tables are associated with subnets to control how their traffic is routed.

---

# Internet Gateway

An **Internet Gateway (IGW)** allows resources in a VPC to communicate with the internet.

Characteristics:

- horizontally scalable
- highly available
- managed by AWS

To enable internet access:

1. Attach an Internet Gateway to the VPC
2. Add a route in the route table

Example route:

```
Destination: 0.0.0.0/0
Target: Internet Gateway
```

Instances must also have a **public IP address** or **Elastic IP** to communicate with the internet.

---

# NAT Gateway

A **NAT Gateway** allows instances in private subnets to access the internet **without exposing them to inbound internet traffic**.

Key characteristics:

- placed inside a **public subnet**
- assigned an **Elastic IP**
- used by **private subnets**

Example architecture:

```
Internet
   │
Internet Gateway
   │
Public Subnet
   │
NAT Gateway
   │
Private Subnet
   │
Application Servers
```

This allows private instances to download updates or access external APIs without being publicly reachable.

---

# Security Groups

**Security Groups** act as firewalls at the **instance level**.

Characteristics:

- stateful
- allow rules only (no explicit deny)
- applied to EC2 instances

Example rule:

| Protocol | Port | Source |
|---|---|---|
| TCP | 22 | 192.168.1.0/24 |

If an outbound request is allowed, the response traffic is automatically allowed back.

---

# Network ACLs

**Network Access Control Lists (NACLs)** act as firewalls at the **subnet level**.

Characteristics:

- stateless
- support allow and deny rules
- separate inbound and outbound rules

Example rule:

| Rule | Action |
|---|---|
| Allow TCP 443 | Allow |
| Deny All | Deny |

Because they are stateless, return traffic must also be explicitly allowed.

---

# Example Amazon VPC Architecture

A typical production VPC architecture might look like:

```
Internet
   │
Internet Gateway
   │
Public Subnet
   │
Load Balancer
   │
Private Subnet
   │
Application Servers
   │
Database Subnet
   │
RDS Database
```

Security groups and network ACLs protect each layer.

---

# AWS Services That Use Amazon VPC

Many AWS services integrate with VPC networking.

Examples include:

- **Amazon EC2** – compute instances
- **Elastic Load Balancing** – traffic distribution
- **Amazon RDS** – relational databases
- **Amazon DynamoDB** – NoSQL databases
- **Amazon S3** – object storage
- **Auto Scaling** – dynamic instance scaling
- **Amazon EFS** – shared file storage

Because VPC is a foundational service, understanding it is essential to designing and operating AWS infrastructure.

---

# Why VPC Networking Matters for DevOps

DevOps engineers frequently work with VPC networking when:

- designing cloud infrastructure
- deploying microservices
- securing internal services
- configuring load balancers
- troubleshooting connectivity issues

Understanding VPC components enables engineers to build **secure, scalable, and resilient cloud architectures**.
