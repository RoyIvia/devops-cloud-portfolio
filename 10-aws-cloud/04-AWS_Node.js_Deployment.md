# AWS Node.js Deployment Pipeline & Custom AMI Creation

## System Overview

This project implements an end-to-end deployment pipeline for a Node.js application on AWS, evolving a single EC2 instance into a reusable, scalable, load-balanced architecture.

The design follows a cloud-native progression:
- Single compute instance for baseline deployment
- Process-managed runtime using PM2
- Immutable infrastructure via Amazon Machine Images (AMI)
- Traffic abstraction and scaling using Application Load Balancer (ALB)

The final system reflects a production-aligned architecture pattern used in modern cloud environments.

---

## Final Architecture

```text
User → ALB → Target Group → Auto Scaling Group → EC2 Instances (AMI-based) → Node.js (PM2-managed)
```

---

## 1. Compute Layer (EC2 Configuration)

A baseline EC2 instance was provisioned using:

```text
AMI: Ubuntu Server 24.04 LTS (HVM)
Instance Type: t3.micro
Network: Default VPC (public subnet enabled)
Key Pair: SSH authentication (.pem)
```

Security Group configuration:

```text
Inbound Rules:
- SSH (22) → My IP
- HTTP (80) → 0.0.0.0/0
- Custom TCP (3000) → Temporary (development validation only)
```

---

## 2. EC2 Access (SSH Connection Workflow)

Before any configuration can begin, secure access to the EC2 instance is established using SSH key-based authentication.

### Step 1: Set correct key permissions (local machine)

```bash
chmod 400 myServer1_Key.pem
```

This ensures the private key is not publicly readable, which is required by SSH.

---

### Step 2: Connect to EC2 instance

```bash
ssh -i myServer1_Key.pem ubuntu@<EC2_PUBLIC_IP>
```

### Explanation:
- `ssh` → Secure Shell protocol
- `-i` → Specifies identity file (private key)
- `ubuntu` → Default username for Ubuntu AMIs
- `<EC2_PUBLIC_IP>` → Public IPv4 address of EC2 instance

Successful execution grants secure terminal access to the EC2 environment.

---

## 3. System Initialization

Once connected via SSH, the first step is preparing the instance for software installation and application runtime.

System packages are updated to ensure compatibility and security:

```bash
sudo apt update -y
sudo apt upgrade -y
```

Node.js and npm are installed to provide the runtime environment required to execute JavaScript server-side applications:

```bash
sudo apt install nodejs -y
sudo apt install npm -y
```

Verification confirms successful installation:

```bash
node -v
npm -v
```

At this stage, the EC2 instance is fully prepared to host and execute a Node.js application.

---

## 4. Application Layer (Node.js Service)

The application is structured inside a dedicated working directory to isolate project files from the system environment.

```bash
mkdir app
```

Creates a dedicated application folder where all source code will reside.

```bash
cd app
```

Moves into the application directory to ensure all subsequent operations occur within the project scope.

```bash
vim app.js
```

Creates the main application entry file responsible for handling HTTP requests.

### Application Implementation

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  res.end("Hello from AWS Node.js deployment 🚀");
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Application running on port 3000");
});
```

---

## 5. Runtime Execution Model

The application is executed using the Node.js runtime:

```bash
node app.js
```

### Key limitation identified:
- Foreground execution blocks terminal session
- No persistence across reboots
- No automatic recovery on failure

This establishes the need for a process manager.

---

## 6. Process Management Layer (PM2)

PM2 (Process Manager 2) is a production-grade process manager for Node.js applications. It manages application execution as a background service.

### Core capabilities:
- Daemonized (background) execution
- Automatic restart on crash
- Process monitoring
- Persistent startup after reboot

### Installation:

```bash
sudo npm install -g pm2
```

### Start application:

```bash
pm2 start app.js
```

### Process inspection:

```bash
pm2 list
```

### Enable persistence:

```bash
pm2 save
pm2 startup
```

PM2 transitions the application from a manually executed script into a managed service.

---

## 7. Application Validation

```bash
curl http://localhost:3000
```

Expected output:

```
Hello from AWS Node.js deployment 🚀
```

Process verification:

```bash
sudo ss -tulnp | grep 3000
```

---

## 8. Security Posture Hardening

Security is progressively enforced as the architecture evolves.

### Initial state:
- EC2 publicly reachable via IP
- Port 3000 exposed for testing purposes
- SSH restricted to personal IP

### Hardened state:
- Direct EC2 public access removed for application traffic
- Only ALB is publicly accessible
- EC2 instances only accept traffic from ALB security group

This enforces a layered security model:

- Public Layer → ALB only
- Private Layer → EC2 instances
- Compute Layer → Isolated backend execution

---

## 9. Immutable Infrastructure (AMI Strategy)

Once the EC2 instance is fully configured, it is captured as an Amazon Machine Image (AMI).

```text
EC2 → Instance → Actions → Image and templates → Create Image
```

### AMI includes:
- Ubuntu OS configuration
- Node.js runtime
- Application code
- PM2 configuration

### Outcome:
- Reproducible infrastructure
- Eliminates manual setup
- Enables rapid provisioning of identical servers

---

## 10. Scaling Layer (Auto Scaling Group + ALB)

A new EC2 instance is launched from the AMI to validate reproducibility.

This confirms that infrastructure can be duplicated without manual configuration.

### Auto Scaling Group (ASG):
- Maintains desired number of instances
- Replaces unhealthy instances
- Launches instances from AMI automatically

### Application Load Balancer (ALB):

```text
Type: Application Load Balancer
Scheme: Internet-facing
Listener: HTTP (80)
Target Group: EC2 instances (port 3000)
Health Check Path: /
```

### Behavior:
- ALB distributes traffic across EC2 instances
- ASG ensures availability and scaling
- Instances automatically join based on health status

---

## 11. Final Architecture

```text
User → ALB → Target Group → Auto Scaling Group → EC2 Instances (AMI-based) → Node.js (PM2-managed)
```

---

## 12. Key Engineering Concepts

- EC2 provisioning and lifecycle management
- Secure SSH-based remote access
- Linux system initialization and configuration
- Node.js backend service deployment
- Process management using PM2
- Immutable infrastructure using AMI
- Horizontal scaling using Auto Scaling Groups
- Load balancing using ALB
- Network security using AWS Security Groups
- Infrastructure reproducibility principles

---

## 13. Final Outcome

A fully scalable AWS deployment architecture featuring:

- Immutable infrastructure using AMI
- Managed Node.js runtime using PM2
- Load-balanced application layer via ALB
- Auto Scaling Group for elasticity
- Secure backend isolation from public access
- Fully reproducible deployment pipeline
