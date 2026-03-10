# Amazon Linux for Cloud & DevOps 

Amazon Linux is a Linux distribution developed and maintained by AWS, optimized for running workloads on the AWS cloud. It is widely used in EC2 environments and integrates closely with AWS services such as Systems Manager, IAM roles, CloudWatch, and ECS.

For DevOps engineers, Amazon Linux is important because it provides an operating system that is tightly integrated with AWS infrastructure, security, and automation tools. Understanding how to work with Amazon Linux is essential when deploying and managing cloud-native applications on AWS.

This section documents how to access Amazon Linux, common commands used in daily operations, important differences from Ubuntu, and comparisons with other related Linux distributions used in cloud environments.

---

# Amazon Linux Versions

There are currently two main versions used in production environments:

| Version           | Description                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------------ |
| Amazon Linux 2    | Long-term support distribution widely used in EC2 environments                                   |
| Amazon Linux 2023 | Modern generation distribution with improved security, deterministic updates, and newer packages |

Amazon Linux 2023 uses **DNF** as its primary package manager, while Amazon Linux 2 uses **YUM**.

---

# Accessing Amazon Linux

## 1. Launching an EC2 Instance (Recommended for Real Environments)

Steps:

1. Open the AWS Management Console
2. Navigate to **EC2**
3. Click **Launch Instance**
4. Select **Amazon Linux 2023 AMI**
5. Choose instance type
6. Configure networking and security group
7. Launch instance with a key pair

Connect using SSH:

```bash
ssh -i key.pem ec2-user@your-instance-ip
```

Default user:

```text
ec2-user
```

---

## 2. Running Amazon Linux Locally Using Docker

Pull the image:

```bash
docker pull amazonlinux
```

Run the container:

```bash
docker run -it amazonlinux bash
```

Check the OS:

```bash
cat /etc/os-release
```

---

## 3. Running Amazon Linux in a Virtual Machine

You can run Amazon Linux locally using virtualization tools such as:

* VirtualBox
* VMware
* UTM

Steps:

1. Download Amazon Linux VM image
2. Import into virtualization software
3. Start the virtual machine
4. Connect using SSH

---

# Basic System Information Commands

```bash
uname -a
```

Displays kernel information.

```bash
cat /etc/os-release
```

Shows OS version.

```bash
uptime
```

Displays system uptime.

```bash
hostnamectl
```

Shows system hostname and kernel details.

---

# User Management

Check current user:

```bash
whoami
```

Create a user:

```bash
sudo useradd username
```

Set password:

```bash
sudo passwd username
```

Add user to sudo group:

```bash
sudo usermod -aG wheel username
```

---

# File System and Navigation

List files:

```bash
ls
```

Change directory:

```bash
cd /path
```

Check disk usage:

```bash
df -h
```

Check folder size:

```bash
du -sh folder
```

Create directory:

```bash
mkdir directory
```

Remove file:

```bash
rm file
```

---

# Package Management

## Amazon Linux 2

Uses **YUM**

Update packages:

```bash
sudo yum update
```

Install package:

```bash
sudo yum install nginx
```

Remove package:

```bash
sudo yum remove nginx
```

Search packages:

```bash
yum search package
```

---

## Amazon Linux 2023

Uses **DNF**

Update packages:

```bash
sudo dnf update
```

Install package:

```bash
sudo dnf install nginx
```

Remove package:

```bash
sudo dnf remove nginx
```

Search packages:

```bash
dnf search package
```

---

# Service Management (systemd)

Start service:

```bash
sudo systemctl start nginx
```

Enable service on boot:

```bash
sudo systemctl enable nginx
```

Check status:

```bash
systemctl status nginx
```

Restart service:

```bash
systemctl restart nginx
```

Stop service:

```bash
systemctl stop nginx
```

---

# Networking Commands

Check IP address:

```bash
ip addr
```

Test connectivity:

```bash
ping google.com
```

Check listening ports:

```bash
ss -tulnp
```

Check routing table:

```bash
ip route
```

---

# Process Management

List processes:

```bash
ps aux
```

Monitor system usage:

```bash
top
```

Kill process:

```bash
kill PID
```

Force kill:

```bash
kill -9 PID
```

---

# Logs and Debugging

System logs:

```bash
journalctl
```

Service logs:

```bash
journalctl -u nginx
```

View recent logs:

```bash
journalctl -n 50
```

Follow logs in real time:

```bash
journalctl -f
```

---

# AWS Tools on Amazon Linux

Amazon Linux often includes AWS tools preinstalled.

Check AWS CLI:

```bash
aws --version
```

Install AWS CLI if needed:

```bash
sudo yum install awscli
```

---

# Docker Installation

Install Docker:

```bash
sudo yum install docker
```

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker on boot:

```bash
sudo systemctl enable docker
```

Add user to Docker group:

```bash
sudo usermod -aG docker ec2-user
```

---

# Security and Firewall

Amazon Linux typically uses **firewalld**.

Start firewall:

```bash
sudo systemctl start firewalld
```

Open port:

```bash
sudo firewall-cmd --add-port=80/tcp --permanent
```

Reload firewall:

```bash
sudo firewall-cmd --reload
```

However, in AWS environments security is often managed using **Security Groups** instead.

---

# Common Differences from Ubuntu

| Feature           | Ubuntu       | Amazon Linux |
| ----------------- | ------------ | ------------ |
| Base distribution | Debian       | RHEL-based   |
| Package manager   | apt          | yum / dnf    |
| Default user      | ubuntu       | ec2-user     |
| Firewall          | ufw          | firewalld    |
| Package naming    | Debian style | RHEL style   |

Example package difference:

| Ubuntu          | Amazon Linux  |
| --------------- | ------------- |
| build-essential | gcc make      |
| libssl-dev      | openssl-devel |
| python3-dev     | python3-devel |

---

# Ubuntu vs Amazon Linux

| Feature              | Ubuntu          | Amazon Linux         |
| -------------------- | --------------- | -------------------- |
| Maintained by        | Canonical       | AWS                  |
| Common use           | General servers | AWS infrastructure   |
| Package manager      | apt             | yum/dnf              |
| Cloud optimization   | General         | AWS optimized        |
| Security integration | Standard        | Deep AWS integration |

Ubuntu is widely used across multiple cloud providers, while Amazon Linux is specifically optimized for AWS workloads.

---

# Comparison with Other Related Distributions

| Distribution | Description                                                 |
| ------------ | ----------------------------------------------------------- |
| Ubuntu       | Debian-based distribution widely used in cloud environments |
| Amazon Linux | AWS-optimized distribution designed for EC2 workloads       |
| AlmaLinux    | RHEL-compatible enterprise Linux replacement                |
| Rocky Linux  | Community enterprise Linux derived from RHEL                |
| Alpine Linux | Minimal Linux distribution commonly used for containers     |

---

# When to Use Each Distribution

Use **Amazon Linux** when:

* running workloads on AWS
* deploying EC2 infrastructure
* using AWS-managed services
* requiring tight integration with AWS tools

Use **Ubuntu** when:

* building development environments
* following general Linux tutorials
* running workloads across multiple cloud providers

Use **Alpine Linux** when:

* building lightweight Docker containers

---

# Key Takeaways for DevOps Engineers

Amazon Linux is a critical distribution for engineers working with AWS infrastructure. Understanding its package management, service management, and integration with AWS services is essential for deploying and maintaining cloud-native applications.

DevOps engineers should be comfortable working with both **Ubuntu and Amazon Linux**, as both distributions are widely used in production environments.
