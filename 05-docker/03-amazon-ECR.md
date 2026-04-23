# Containerized API Deployment on ECS Fargate with ECR and ALB


This project captures the deployment of a containerised application on AWS using a managed container workflow.

The implementation covers:
- Container build using Docker
- Image storage in Amazon ECR
- Container execution using ECS (Fargate)
- Traffic routing through an Application Load Balancer

This reflects a production-aligned pattern for deploying stateless services.


## Architecture

```
                        ┌───────────────────────────────┐
                        │           Internet            │
                        └──────────────┬────────────────┘
                                       │
                                       ▼
                        ┌───────────────────────────────┐
                        │   Application Load Balancer   │
                        │        (Public Subnet)        │
                        │        Port 80 (HTTP)         │
                        └──────────────┬────────────────┘
                                       │
                        ┌──────────────▼──────────────┐
                        │        Target Group         │
                        │     (Health Check /health)  │
                        └──────────────┬──────────────┘
                                       │
                ┌──────────────────────▼──────────────────────┐
                │              ECS Service                    │
                │           (Fargate Launch Type)             │
                │                                             │
                │   ┌──────────────────────────────────────┐  │
                │   │            ECS Tasks                 │  │
                │   │     (Private Subnets - awsvpc)       │  │
                │   │                                      │  │
                │   │   Container: Flask API (Port 5000)   │  │
                │   └──────────────────────────────────────┘  │
                └──────────────────────┬──────────────────────┘
                                       │
                                       ▼
                        ┌───────────────────────────────┐
                        │     Amazon ECR Repository     │
                        │   (Image Storage - Private)   │
                        └───────────────────────────────┘


```



## Application Implementation

A minimal Flask API was used to validate the deployment.

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Running on ECS Fargate 🚀"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```


## Containerization

### Dockerfile

```Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY app/ .

RUN pip install flask

EXPOSE 5000

CMD ["python", "app.py"]
```


### Build Execution

```bash
docker build -t royivia/ecs-fargate-app:latest .
```

Observation:
- Image built in layers
- Base image pulled from public registry
- Final image includes only runtime + app



## Image Distribution – Docker Hub

The image was pushed to my Docker Hub repository:

https://hub.docker.com/repositories/royivia

### Tagging

```bash
docker tag royivia/ecs-fargate-app:latest royivia/ecs-fargate-app:latest
```

### Push

```bash
docker push royivia/ecs-fargate-app:latest
```

Observation:
- Layers reused if already present
- Image becomes globally pullable

---

## Image Distribution – Amazon ECR

Repository created:

```bash
aws ecr create-repository --repository-name ecs-fargate-app --region eu-west-1
```

Repository URI:

```text
731245678901.dkr.ecr.eu-west-1.amazonaws.com/ecs-fargate-app
```

---

### Authentication

```bash
aws ecr get-login-password --region eu-west-1 \
| docker login --username AWS --password-stdin 731245678901.dkr.ecr.eu-west-1.amazonaws.com
```

---

### Tagging for ECR

```bash
docker tag royivia/ecs-fargate-app:latest \
731245678901.dkr.ecr.eu-west-1.amazonaws.com/ecs-fargate-app:latest
```

---

### Push to ECR

```bash
docker push 731245678901.dkr.ecr.eu-west-1.amazonaws.com/ecs-fargate-app:latest
```

Observation:
- Only missing layers uploaded
- Image registered with digest
- Accessible via ECS

---

## ECS Deployment

### Cluster

- Name: `royivia-ecs-cluster`
- Launch type: Fargate

---

### Task Definition

```json
{
  "family": "royivia-task",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "containerDefinitions": [
    {
      "name": "ecs-fargate-container",
      "image": "731245678901.dkr.ecr.eu-west-1.amazonaws.com/ecs-fargate-app:latest",
      "portMappings": [
        {
          "containerPort": 5000,
          "protocol": "tcp"
        }
      ],
      "essential": true
    }
  ]
}
```

---

### Service Configuration

- Service name: `royivia-service`
- Launch type: Fargate
- Desired count: 1
- Networking: awsvpc
- Load balancer attached

---

## Load Balancer Configuration

- Type: Application Load Balancer
- Listener: HTTP (port 80)
- Target group: ECS tasks
- Health check path: `/health`

---

## Networking

- Tasks run in private subnets
- ALB runs in public subnets
- Security groups allow:
  - HTTP (80) inbound to ALB
  - ALB → ECS traffic on port 5000

---

## Execution Flow

```
Local Build
    ↓
Docker Image (royivia/ecs-fargate-app)
    ↓
Push to ECR
    ↓
ECS Task Definition (references image)
    ↓
ECS Service (Fargate runs container)
    ↓
Application Load Balancer
    ↓
Client Request → Response
```

---

## Validation

Application accessed via ALB DNS:

```
http://ecs-royivia-alb-123456789.eu-west-1.elb.amazonaws.com
```

Response:

```
Running on ECS Fargate 🚀
```

Health check:

```
/health → 200 OK
```

---

## Observations

- Fargate abstracts infrastructure completely
- ECS handles scheduling and lifecycle
- ECR integrates with IAM for secure image access
- ALB routes traffic to ephemeral container instances
- Containers are replaceable and stateless

