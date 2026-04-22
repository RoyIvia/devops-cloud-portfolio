# Docker – Concepts, Architecture, and Practical Implementation

## Overview
This repository captures my understanding of Docker as a Cloud and DevOps Engineer.

It focuses on how containerization works under the hood, how Docker leverages core Linux primitives, and how containerized applications are built, executed, and managed in real environments.

---

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

---

## Containers vs Virtual Machines

| Feature            | Containers                         | Virtual Machines                  |
|-------------------|-----------------------------------|----------------------------------|
| OS Overhead       | Shares host kernel                | Full OS per VM                   |
| Startup Time      | Seconds                           | Minutes                          |
| Size              | MBs                               | GBs                              |
| Isolation         | Process-level                     | Hardware-level                   |
| Performance       | Near-native                       | Slight overhead                  |

Containers trade stronger isolation (VMs) for efficiency and speed.

---

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

---

## Docker

Docker is a platform that simplifies containerization by providing tooling for:
- Building images
- Running containers
- Managing networking and storage
- Distributing images via registries

**Key distinction:**
- Containerization → concept
- Docker → implementation

---

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

---

## Docker Lifecycle

The core workflow:

```
Dockerfile → Image → Container → Registry
```

Commands:

- `docker build` → creates an image from a Dockerfile
- `docker run` → creates and starts a container
- `docker push` → uploads image to a registry

---

## Core Docker Objects

### Dockerfile
Defines the instructions to build an image.

### Images
- Read-only templates
- Built in layers
- Optimized for reuse and caching

### Containers
- Running instances of images
- Ephemeral by default

---

## Installing Docker (Ubuntu)

```bash
sudo apt update
sudo apt install docker.io -y
```

---

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

---

## Granting User Access

Allow non-root usage:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in for changes to take effect.

---

## Verifying Installation

```bash
docker run hello-world
```

Successful output confirms:
- Docker daemon is running
- Image pull works
- Containers execute correctly

---

## Building and Running a First Container

This section demonstrates a minimal end-to-end workflow.

### Step 1: Create Application

```bash
nano app.py
```

```python
print("Hello from my first Docker container")
```

---

### Step 2: Create Dockerfile

```bash
nano Dockerfile
```

```Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY app.py .

CMD ["python", "app.py"]
```

---

### Step 3: Build Image

```bash
docker build -t my-first-image .
```

Verify:

```bash
docker images
```

---

### Step 4: Run Container

```bash
docker run my-first-image
```

Expected output:

```
Hello from my first Docker container
```

---

### Step 5: Inspect Containers

```bash
docker ps
docker ps -a
```

---

### Step 6: Cleanup

```bash
docker stop <container_id>
docker rm <container_id>
docker rmi my-first-image
```

