## Image Distribution – Docker Hub

### Registry Context

Dockerhub is used as the image registry for distributing built artifacts.

In this workflow, it serves as:
- A central repository for container images
- A distribution point across environments
- A source of truth for deployable artifacts

My repository:
https://hub.docker.com/repositories/royivia


## Image Tagging and Push Execution

After building the image locally:

```bash
docker build -t my-first-image .
```

The image exists only in the local Docker engine.

To make it distributable, it was retagged to match Docker Hub naming conventions:

```bash
docker tag my-first-image royivia/my-first-image:latest
```

### Observation

- No new image is created
- Only a new reference is added
- Both tags point to the same image ID


## Authentication

Authenticated against Docker Hub via CLI:

```bash
docker login
```

This establishes a session for pushing images to the registry.


## Push Operation

The image was pushed to Docker Hub:

```bash
docker push royivia/my-first-image:latest
```

### What occurred during push

- Docker identified image layers
- Compared with registry layers
- Uploaded only missing layers
- Generated a digest for the image

This confirms:
- Layered architecture efficiency
- Content-addressable storage behavior


## Verification

The image is now available at:

https://hub.docker.com/repositories/royivia

And can be pulled on any host:

```bash
docker pull royivia/my-first-image:latest
docker run royivia/my-first-image
```


## System-Level Understanding

- The registry does not run containers — it stores images
- Images are immutable artifacts identified by digests
- Tagging defines human-readable references to those artifacts
- Distribution is optimized via layer reuse


## Role in DevOps Workflow

This step transitions the workflow from:
- Local build → isolated environment

To:
- Distributed artifact → deployable across systems

In production systems:
- CI pipelines build and tag images
- Images are pushed to registries
- Deployment systems pull and run those images

This establishes a consistent and reproducible deployment model.
