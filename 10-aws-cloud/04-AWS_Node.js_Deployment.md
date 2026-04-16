# AWS Node.js Deployment Pipeline (EC2 → AMI → PM2 → ALB)

## System Overview

This project implements an end-to-end deployment pipeline for a Node.js application on AWS, evolving a single EC2 instance into a reusable, scalable, load-balanced architecture.

The design follows a cloud-native progression:
- Single compute instance for baseline deployment
- Process-managed runtime using PM2
- Immutable infrastructure via Amazon Machine Images (AMI)
- Traffic abstraction and scaling using Application Load Balancer (ALB)

The final system reflects a production-aligned architecture pattern used in modern cloud environments.



## Final Architecture

```text
User → ALB → Target Group → EC2 Instances (AMI-based) → Node.js (PM2-managed)
```



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

The instance served as the foundational environment for application deployment and system configuration.



## 2. System Initialization

Once connected via SSH:

```bash
sudo apt update -y
sudo apt upgrade -y
```

Node.js runtime installed:

```bash
sudo apt install nodejs -y
sudo apt install npm -y
```

Verification:

```bash
node -v
npm -v
```



## 3. Application Layer (Node.js Service)

Application structure:

```bash
mkdir app
cd app
vim app.js
```

Core service implementation:

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  res.end("Hello from AWS Node.js deployment 🚀");
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Application running on port 3000");
});
```

At this stage, the service is bound to the instance on port 3000.



## 4. Runtime Execution Model

Initial execution:

```bash
node app.js
```

Observation:
- Foreground process execution
- No fault tolerance
- No persistence layer

This defined the need for a managed process runtime.



## 5. Process Management Layer (PM2)

PM2 introduced to transition from manual execution to managed runtime:

```bash
sudo npm install -g pm2
pm2 start app.js
```

Operational control:

```bash
pm2 save
pm2 startup
pm2 list
```

PM2 provides:
- Process persistence across reboots
- Automatic restart on failure
- Background execution model
- Basic runtime observability

---

## 6. Validation and Observability

Local verification:

```bash
curl http://localhost:3000
```

Process inspection:

```bash
sudo ss -tulnp | grep 3000
```

Confirms:
- Active Node.js listener
- Stable runtime process



## 7. Security Posture Hardening

Security model transitioned from development exposure to controlled access:

### Development state:
- Direct access to port 3000 allowed temporarily

### Final state:
- EC2 instances not exposed to public traffic
- Only ALB permitted to communicate with backend instances
- SSH restricted to controlled IP access

This enforces a proper separation between compute and traffic layers.



## 8. Immutable Infrastructure (AMI Strategy)

Once the EC2 instance reached a stable configuration (Node.js + application + PM2), it was captured as a reusable machine image.

AMI creation path:

```text
EC2 → Instance → Actions → Image and templates → Create Image
```

Captured state includes:
- Operating system configuration
- Node.js runtime environment
- Application source code
- PM2 process configuration

Engineering outcome:
- Reproducible infrastructure
- Zero-touch provisioning for new instances
- Elimination of manual configuration drift



## 9. Scaling Layer (Application Load Balancer)

An ALB was introduced to abstract traffic routing from compute infrastructure.

Configuration:

```text
Type: Application Load Balancer
Scheme: Internet-facing
Listener: HTTP (80)
Target Group: EC2 instances (port 3000)
Health Check: /
```

Responsibilities:
- Traffic distribution across instances
- Health-based routing decisions
- Horizontal scaling enablement
- Single entry point for system access



## 10. Operational Model

The system operates as a decoupled multi-layer architecture:

- ALB handles request routing
- Target Group manages instance selection
- EC2 instances execute compute workload
- PM2 ensures application lifecycle stability
- AMI ensures infrastructure reproducibility

---

## 11. Engineering Challenges Addressed

Throughout the implementation, the following system-level issues were resolved:

- SSH authentication mismatches (key association and user configuration)
- Network accessibility constraints due to security group rules
- Application exposure control (port-level access management)
- Process lifecycle limitations in foreground execution
- Load balancer health check configuration requirements

Each issue was resolved through iterative infrastructure-level debugging.

---

## 12. Final System State

The final deployed system represents a fully functional cloud architecture with:

- Immutable EC2 provisioning via AMI
- Managed Node.js runtime via PM2
- Load-balanced traffic distribution via ALB
- Secure backend compute isolation
- Repeatable and scalable deployment model

---

## Conclusion

This implementation demonstrates a complete cloud deployment lifecycle, transitioning from single-instance execution to a scalable distributed system using AWS-native components and Linux-based process management strategies.
