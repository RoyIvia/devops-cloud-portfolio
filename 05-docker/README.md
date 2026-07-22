# Docker & Containerization – Concepts, Architecture, and Practical Implementation

This repository focuses on how containerization works under the hood, how Docker leverages core Linux primitives, and how containerised applications are built, executed, 
and managed in real environments.

## What is a Container?

A container is an isolated runtime environment that packages:
- Application code
- Dependencies (libraries, binaries)
- Runtime

Containers run as processes on the host system while maintaining isolation through kernel features.

**Mental model:**


```
Container = Process + Namespaces + cgroups
```


## Containers vs Virtual Machines


| Feature            | Containers                         | Virtual Machines                 |
|-------------------|-----------------------------------|----------------------------------|
| OS Overhead       | Shares host kernel                | Full OS per VM                   |
| Startup Time      | Seconds                           | Minutes                          |
| Size              | MBs                               | GBs                              |
| Isolation         | Process-level                     | Hardware-level                   |
| Performance       | Near-native                       | Slight overhead                  |


Containers trade stronger isolation (VMs) for efficiency and speed.

<img width="1662" height="718" alt="image" src="https://github.com/user-attachments/assets/23790ebd-d0dc-476c-9bae-6ef8edac6d42" />





Containers and virtual machines are both technologies used to isolate applications and their dependencies, but they have some key differences:

 1. Resource Utilization: Containers share the host operating system kernel, making them lighter and faster than VMs. VMs have a full-fledged OS and hypervisor, making them more  resource-intensive.

 2. Portability: Containers are designed to be portable and can run on any system with a compatible host operating system. VMs are less portable as they need a compatible hypervisor to run.

 3. Security: VMs provide a higher level of security as each VM has its own operating system and can be isolated from the host and other VMs. Containers provide less isolation, as they share the host operating system.

    
## Why Containers Are Lightweight

Containers are lightweight because they rely on Linux kernel features instead of bundling a full operating system.

Core components:

- **Namespaces** → isolate processes (PID, network, mount, etc.)
- **cgroups** → control resource usage (CPU, memory, I/O)
- **Layered filesystem (UnionFS)** → efficient image construction

This results in:
- Smaller image sizes
- Faster startup times
- Efficient resource utilization


Files and Folders in containers base images:

 ```
   /bin: contains binary executable files, such as the ls, cp, and ps commands.

    /sbin: contains system binary executable files, such as the init and shutdown commands.

    /etc: contains configuration files for various system services.

    /lib: contains library files that are used by the binary executables.

    /usr: contains user-related files and utilities, such as applications, libraries, and documentation.

    /var: contains variable data, such as log files, spool files, and temporary files.

    /root: is the home directory of the root user.
```

Files and Folders that containers use from host operating system:

 ```
- The host's file system: Docker containers can access the host file system using bind mounts, which allow the container to read and write files in the host file system.

- Networking stack: The host's networking stack is used to provide network connectivity to the container. Docker containers can be connected to the host's network directly or through a virtual network.

- System calls: The host's kernel handles system calls from the container, which is how the container accesses the host's resources, such as CPU, memory, and I/O.

- Namespaces: Docker containers use Linux namespaces to create isolated environments for the container's processes. Namespaces provide isolation for resources such as the file system, process ID, and network.

- Control groups (cgroups): Docker containers use cgroups to limit and control the amount of resources, such as CPU, memory, and I/O, that a container can access.
    
```

It's important to note that while a container uses resources from the host operating system, it is still isolated from the host and other containers, so changes to the container do not affect the host or other containers.


## Docker

Docker is a platform that simplifies containerization by providing tooling for:
- Building images
- Running containers
- Managing networking and storage
- Distributing images via registries

**Key distinction:**
- Containerization → concept
- Docker → implementation


## Docker Architecture

Docker operates using a client-server model:

- **Docker Client (`docker`)** → CLI interface
- **Docker Daemon (`dockerd`)** → manages containers, images, networks
- **Docker Registry** → stores images (e.g., Docker Hub)

**Flow:**
```
docker CLI → Docker Daemon → Container Runtime
```

If the Docker daemon is not running, Docker operations fail.


## Docker Lifecycle

The core workflow:

```
Dockerfile → Image → Container → Registry
```

Commands:

- `docker build` → creates an image from a Dockerfile
- `docker run` → creates and starts a container
- `docker push` → uploads image to a registry


## Core Docker Objects

### Dockerfile
Defines the instructions/comands to build an image.

### Images
- Read-only templates
- Built in layers
- Optimised for reuse and caching

### Containers
- Running instances of images
- Ephemeral by default


## Installing Docker (Ubuntu)

```bash
sudo apt update
sudo apt install docker.io -y
```


## Starting and Verifying Docker

Start Docker:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Verify:

```bash
sudo systemctl status docker
```


## Granting User Access

Allow non-root usage:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in for changes to take effect.


## Verifying Installation

```bash
docker run hello-world
```

Successful output confirms:
- Docker daemon is running
- Image pull works
- Containers execute correctly



