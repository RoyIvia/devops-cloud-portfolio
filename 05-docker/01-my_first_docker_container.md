## Building and Running a First Container

This section demonstrates a minimal end-to-end workflow.

### Step 1: Creating Application

```bash
nano app.py
```

```python
print("Hello from my first Docker container")
```
- This is a minimal Python application
- It serves as the workload we want to containerise
- In real scenarios, this would be:
  - an API
  - a service
  - a background worker


### Step 2: Creating Dockerfile

```bash
nano Dockerfile
```

```Dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY app.py .

CMD ["python", "app.py"]
```
- The Dockerfile defines **how the image is built**.

- Each instruction creates a **layer** in the final image.

### Instruction breakdown:

**FROM python:3.10-slim**
- Sets the base image
- This already contains:
  - Python runtime
  - minimal OS dependencies
- Docker pulls this image from a registry if not available locally


**WORKDIR /app**
- Creates (if not exists) and sets `/app` as the working directory
- All subsequent instructions execute relative to this path


**COPY app.py .**
- Copies `app.py` from host → container image
- Source = build context (`.`)
- Destination = `/app`


**CMD ["python", "app.py"]**
- Defines the default command when the container starts
- This is **not executed during build**
- It runs only when the container is started

### Step 3: Building Image

```bash
docker build -t my-first-image .
```


- Docker reads the `Dockerfile`
- Executes instructions sequentially
- Creates an **image composed of layers**
- `docker build` → starts the build process
- `-t my-first-image` → tags the image
- `.` → build context (current directory)

Verify:

```bash
docker images
```

- Lists locally available images
- Confirms that the image was successfully built
  
Images are:
- immutable
- reusable
- versionable (via tags)

### Step 4: Running Container

```bash
docker run my-first-image
```

Expected output:

```
Hello from my first Docker container
```
- Docker creates a container from the image
- Applies isolation using:
  - namespaces
  - cgroups
- Executes the `CMD` defined in the Dockerfile


### Step 5: Inspecting Containers

```bash
docker ps
docker ps -a
```

- `docker ps` → shows running containers
- `docker ps -a` → shows all containers (including stopped)


### Step 6: Cleanup

```bash
docker stop <container_id>
docker rm <container_id>
docker rmi my-first-image
```
- `docker stop` → stops running container
- `docker rm` → removes container
- `docker rmi` → removes image

###Significance:

- Prevents resource waste
- Keeps environment clean
- Important in CI/CD pipelines
