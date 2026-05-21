# Virtual Machines (VMs)

A **Virtual Machine (VM)** is a logically isolated environment that acts like a separate computer running on top of a physical server. Each VM has its own **CPU, memory, storage, and network interface**, allowing multiple VMs to run independently on the same physical hardware.

VMs provide:
- **Isolation**: Each VM is independent; one VM cannot directly interfere with another.
- **Efficient resource utilisation**: Large physical servers are often underutilised. VMs allow these resources to be shared across multiple workloads.
- **Flexibility**: Teams or organisations can deploy their applications without requiring dedicated hardware.
- **Scalability**: VMs can be created, resized, or destroyed quickly based on demand.


## How Virtual Machines Work

Virtualisation is enabled by a **Hypervisor**, which is software that creates and manages VMs on a physical server (also called **bare-metal**).

### Types of Hypervisors
1. **Type 1 (Bare-metal)**: Runs directly on the physical server hardware. Examples:
   - VMware ESXi
   - Xen
   - Microsoft Hyper-V
2. **Type 2 (Hosted)**: Runs on top of an existing operating system. Examples:
   - VirtualBox
   - VMware Workstation

The hypervisor manages:
- CPU allocation
- Memory
- Storage
- Network connectivity
- Isolation between VMs



## VMs in the Cloud
Cloud providers like AWS, Azure, and GCP rely heavily on virtualisation:

- **AWS uses Nitro Hypervisor** to run EC2 instances.
- Large **data centres** are divided into regions and availability zones, each containing thousands of physical servers.
- Users create VMs (instances) in regions close to their customers to reduce latency.
- Cloud VMs provide:
  - Pay-as-you-go pricing
  - Rapid provisioning
  - High availability

**Example Scenario**:

- A physical server has 64 CPU cores and 256 GB RAM.
- Without virtualisation, only one team uses the server; the rest of the resources remain idle.
- With virtualisation, 8 VMs can run, each with 8 CPUs and 32 GB RAM, allowing multiple teams or applications to share the same hardware efficiently.


## Why Virtual Machines Matter for DevOps

- **Development and Testing**: Each team can have its own VM environment identical to production.
- **Isolation**: Bugs in one VM don’t affect others.
- **Automation**: VMs can be created, destroyed, and scaled programmatically using infrastructure-as-code tools like Terraform.
- **Foundation for Containers and Cloud**: Understanding VMs is essential before moving to containers (Docker) and cloud infrastructure.


