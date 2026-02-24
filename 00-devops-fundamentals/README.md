# DevOps Fundamentals

## Overview
DevOps is a culture and set of practices that improves an organization’s ability to deliver applications and services at high velocity. It bridges the gap between development and operations teams, enabling faster, more reliable, and scalable software delivery.

This section documents the key foundational concepts of DevOps, including its purpose, the challenges it addresses, and how it integrates with modern software delivery practices.


## 1. What is DevOps?
- DevOps is **more than tools; it is a cultural shift** focused on collaboration, shared responsibility, and continuous improvement.
- It connects **development** (developers writing code) with **operations** (managing infrastructure and deployments) to streamline the software delivery process.
- Key objectives:
  - **Faster delivery** of features
  - **Automation** of manual tasks
  - **Continuous testing and monitoring**
  - **Reliable and scalable infrastructure**

---

## 2. Why DevOps is Important
Before DevOps:
- Developers wrote code independently.
- System administrators manually provisioned servers for testing and deployment.
- Build and release engineers manually deployed applications from the repository.
- Deployments were slow, error-prone, and lacked continuous feedback.

Challenges:
- Long release cycles
- “It works on my machine” syndrome
- Limited visibility into application health
- Manual, error-prone processes

DevOps solves these problems by introducing:
- Automation of build, test, and deployment workflows
- Continuous integration and continuous delivery (CI/CD)
- Shared responsibility for reliability and performance
- Monitoring and continuous feedback loops
- 
---

## 3. Software Development Lifecycle (SDLC) and Roles in a Software Company

The SDLC defines the stages a software application goes through from concept to production. DevOps overlays the SDLC to improve **speed, quality, and reliability**. Understanding the SDLC also requires understanding **the roles involved** and how they collaborate.

### SDLC Stages Overview
1. **Planning** – Understanding what the business needs.
2. **Coding/Development** – Writing the software.
3. **Build** – Compiling code and creating deployable artifacts.
4. **Testing** – Ensuring functionality, security, and performance.
5. **Release/Deployment** – Moving code to production.
6. **Operations/Monitoring** – Running the application and capturing feedback.
7. 
---

### Key Roles in the Software Development Lifecycle

| Role | Responsibilities |
|------|-----------------|
| **Business Analyst (BA)** | Interfaces with the customer or market to gather product requirements, prepares the Business Requirements Document (BRD), and ensures the product meets business goals. |
| **Product Manager (PM)** | Receives requirements from the BA, prioritizes features based on business value and organizational capacity, and creates a roadmap for development. |
| **Product Owner (PO)** | More technically-oriented; breaks down high-level requirements into actionable items called **EPICS** and user stories for development. |
| **Solutions Architect / Software Architect** | Translates EPICS into a **high-level design (HLD)** and **low-level design (LLD)**, specifying how components interact and how infrastructure supports the application. |
| **Developers / Software Engineers** | Implement features according to requirements and designs, using tools such as Git, Dockerfiles, Kubernetes manifests, and collaborating with DevOps engineers for smooth deployment. |
| **Quality Assurance (QA) Engineers)** | Test applications to validate functionality, performance, and reliability; ensure the product meets requirements before release. |
| **Database Administrators (DBA)** | Design, deploy, and manage databases required by the application; maintain integrity, backups, and performance tuning. |
| **DevOps Engineers** | Automate infrastructure, build CI/CD pipelines, ensure reliable deployments, manage cloud resources, and collaborate with development and operations teams. |
| **Site Reliability Engineers (SRE)** | Focus on system reliability, scalability, and performance; monitor production systems and resolve incidents quickly. |
| **Release Managers** | Plan and coordinate releases, ensuring deployment processes are smooth and rollback strategies exist. |
| **Technical Writers** | Document systems, APIs, and processes for both internal teams and end-users. |
| **UI / UX Designers** | Design user interfaces and experiences that are intuitive and meet user needs. |
| **Project Manager (PM)** | Oversees the overall project execution, coordinates between teams, manages timelines, and ensures delivery within scope and budget. |

---

### How DevOps Interacts With These Roles
- **Developers and DevOps engineers collaborate** on deployment automation, containerization, and infrastructure as code.  
- **SREs and DevOps engineers** work together to monitor production systems and reduce downtime.  
- **QA, developers, and DevOps** ensure continuous testing is integrated into the CI/CD pipeline.  
- The **Solutions Architect** provides the blueprint that guides both development and DevOps decisions.  

> DevOps sits at the **intersection of development, operations, and reliability**, ensuring smooth delivery of software.

---

## 4. Key Takeaways
- DevOps is a culture that emphasizes collaboration, automation, and continuous improvement.
- It solves problems caused by manual, siloed processes in traditional SDLC.
- Understanding SDLC and roles is critical to applying DevOps practices effectively.
- Modern DevOps pipelines rely on tools and practices that will be explored in this portfolio, including cloud platforms, containerization, orchestration, CI/CD, automation, and monitoring.



