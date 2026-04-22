# Docker Fundamentals – From Zero to First Container


The goal is not just to run containers, but to understand:
- How containers actually work
- How Docker interacts with the Linux kernel
- How to build, run, and distribute container images

---

## What is a Container?

A container is an isolated runtime environment that packages:
- Application code
- Dependencies (libraries, binaries)
- Runtime

Unlike virtual machines, containers **do not include a full operating system**. Instead, they share the host kernel while maintaining isolation.

**Mental model:**
```
Container = Process + Namespaces + cgroups
```

---

## Containers vs Virtual Machines

| Feature            | Containers                         | Virtual Machines                  |
|-------------------|-----------------------------------|----------------------------------|
| OS Overhead       | None (shares host kernel)          | Full OS per VM                   |
| Startup Time      | Seconds                            | Minutes                          |
| Size              | MBs                                | GBs                              |
| Isolation         | Process-level                      | Hardware-level                   |
| Performance       | Near-native                        | Slight overhead                  |

---

## Why Containers Are Lightweight

Containers leverage core Linux features:

- **Namespaces** → isolate processes (PID, network, filesystem)
- **cgroups** → limit CPU, memory, I/O
- **Union FS** → layered filesystem (image layers)

This eliminates the need for a full OS per workload.

---

## Docker – The Tooling Layer

Docker is a platform that simplifies container usage.

It provides:
- Image building
- Container runtime
- Networking
- Image distribution (Docker Hub)

---

## Docker Architecture

- **Docker Client (`docker`)** → CLI interface
- **Docker Daemon (`dockerd`)** → runs containers, manages images
- **Docker Registry** → stores images (e.g., Docker Hub)

Flow:
```
docker CLI → Docker Daemon → Container Runtime
```

---

## Docker Lifecycle

```
Dockerfile → Image → Container → Registry
```

Commands:
- `docker build` → create image
- `docker run` → start container
- `docker push` → share image

---

## Installing Docker (Ubuntu)

```bash
sudo apt update
sudo apt install docker.io -y
```

---

## Step 1: Start and Enable Docker

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Verify:
```bash
sudo systemctl status docker
```

---

## Step 2: Fix Permissions (Important)

By default, Docker requires sudo.

Allow your user to run Docker:

```bash
sudo usermod -aG docker $USER
```

Then log out and log back in.

---

## Step 3: Verify Installation

```bash
docker run hello-world
```

Expected output:
```
Hello from Docker!
```

This confirms:
- Docker daemon is running
- Images can be pulled
- Containers can be executed

---

## Step 4: Create Your First Application

Create a simple Python app:

```bash
nano app.py
```

```python
print("Hello from my first Docker container")
```

---

## Step 5: Create a Dockerfile

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

## Step 6: Build Your First Image

```bash
docker build -t my-first-image .
```

Verify:
```bash
docker images
```

---

## Step 7: Run Your First Container

```bash
docker run my-first-image
```

Output:
```
Hello from my first Docker container
```

---

## Step 8: Inspect Running Containers

```bash
docker ps
docker ps -a
```

---

## Step 9: Clean Up

```bash
docker stop <container_id>
docker rm <container_id>
docker rmi my-first-image
```

---

## Key Concepts Learned

- Containers are just isolated processes
- Docker images are built in layers
- Containers are ephemeral (stateless by default)
- Docker abstracts low-level Linux primitives

---

## What I Would Do Next

- Multi-container apps using Docker Compose
- Networking between containers
- Persistent storage (volumes)
- Writing optimized Dockerfiles
- Moving to Kubernetes


