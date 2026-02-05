# Setup Linux Environment on Windows and macOS

A Linux environment is foundational for DevOps, Cloud, and Backend Engineering.  
This guide covers **multiple ways to run Linux on Windows and macOS**, with a strong recommendation for **Docker-based Linux containers** for long-term, cost-free, and reproducible environments.

---

## Available Methods to Run Linux

You can set up Linux using several approaches:

- **Docker Containers (Recommended)**
- **WSL2 (Windows Subsystem for Linux)**
- **Virtual Machines (VirtualBox / VMware)**
- **Cloud Virtual Machines (AWS, GCP, Azure)**
- **HyperKit (macOS)**

Each method has trade-offs, which are compared later in this document.

---

## Recommended Approach: Linux Using Docker Containers

Using Docker gives you:
- A lightweight Linux environment
- No VM overhead
- No cloud cost
- Persistent storage
- Easy teardown and recreation

### Prerequisites

- Install **Docker Desktop**
  - Windows: https://www.docker.com/products/docker-desktop/
  - macOS: https://www.docker.com/products/docker-desktop/
- Ensure Docker is running before proceeding

---

## Docker Method (Persistent & Long-Term Linux Environment)

### Windows Host Setup

#### Step 1: Create a Data Directory

Create a folder to persist Linux data:

```powershell
mkdir C:\Users\<your-username>\Downloads\ubuntu-data


Step 2: Run Ubuntu Linux Container (Windows)

Open PowerShell and run the command below
(make sure to replace your-username accordingly):
```
docker run -dit `
  --name ubuntu-container `
  --hostname ubuntu-dev `
  --restart unless-stopped `
  --cpus="2" `
  --memory="4g" `
  --mount type=bind,source="C:/Users/your-username/Downloads/ubuntu-data",target=/data `
  -v /var/run/docker.sock:/var/run/docker.sock `
  -p 2222:22 `
  -p 8080:80 `
  --env TZ=Asia/Kolkata `
  --env LANG=en_US.UTF-8 `
  ubuntu: latest /bin/bash
```
macOS or Linux Host Setup
Step 1: Create a Data Directory
```
mkdir -p ~/ubuntu-data
```

Step 2: Run Ubuntu Linux Container (macOS/Linux)
```
docker run -dit \
  --name ubuntu-container \
  --hostname ubuntu-dev \
  --restart unless-stopped \
  --cpus="2" \
  --memory="4g" \
  --mount type=bind,source=~/ubuntu-data,target=/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 2222:22 \
  -p 8080:80 \
  --env TZ=Asia/Kolkata \
  --env LANG=en_US.UTF-8 \
  ubuntu:latest /bin/bash
```
Step 3: Access the Linux Container
```
docker exec -it ubuntu-container bash
```

Step 4: Update Linux Packages
```
apt update && apt upgrade -y
```

Explanation of Docker Parameters

```
Parameter	                    Description
-dit	                         Detached, interactive terminal mode
--name ubuntu-container	       Names the container
--hostname ubuntu-dev	         Sets hostname inside container
--restart unless-stopped	     Auto-restart container
--cpus="2"	                   Limits CPU usage
--memory="4g"	                 Limits memory usage
--mount type=bind	             Persists data on host
-v /var/run/docker.sock	       Enables Docker inside container
-p 2222:22	                   SSH port mapping
-p 8080:80	                   Web service port mapping
--env TZ	                     Timezone configuration
--env LANG	                   Language configuration
ubuntu:latest /bin/bash	       Ubuntu image with Bash shell

```


Installing Linux on Windows Using WSL2

WSL2 allows Windows users to run Linux natively, without a full virtual machine.

Step 1: Install WSL2

Open PowerShell as Administrator:
```
wsl --install
```
This will:

Enable required Windows features

Install WSL2

Install Ubuntu by default

Restart your computer when prompted.

Step 2: Launch Ubuntu

Open Start Menu

Search for Ubuntu

Create a Linux username and password

Step 3: Verify WSL Version

```
wsl -l -v

```
Ensure Ubuntu is running on WSL2.

If not:

```
wsl --set-version Ubuntu 2

```

Step 4: Update Packages

```
sudo apt update && sudo apt upgrade -y
```

## Comparison of Linux Setup Methods;

Method	                     Best Use Case	                       Pros                          Cons

Docker Containers           DevOps, CI/CD, microservices           Lightweight, reproducible      No full systemd

WSL2                         Windows development                   Fast, native	                  Windows-only
	
Virtual Machines	            OS-level learning	                   Full Linux OS	                Heavy resources

Cloud VMs	                    Production practice	                 Real infrastructure	          Cost & internet

HyperKit	                    macOS virtualization	               Fast	                           Limited tooling

# Recommendations

WSL2 (Windows users) – daily Linux usage

Docker containers – isolation & automation

Cloud VMs – real-world infrastructure

This mirrors how Linux is used in professional DevOps environments.

# Summary

Docker provides the best balance of performance, cost, and realism

WSL2 is excellent for Windows-native Linux usage

Cloud and VMs are best for advanced and production-level learning
