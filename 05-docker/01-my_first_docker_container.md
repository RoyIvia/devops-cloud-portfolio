## Building and Running a First Container

This section demonstrates a minimal end-to-end workflow.

### Step 1: Creating Application

```bash
nano app.py
```

```python
print("Hello from my first Docker container")
```


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


### Step 3: Building Image

```bash
docker build -t my-first-image .
```

Verify:

```bash
docker images
```


### Step 4: Running Container

```bash
docker run my-first-image
```

Expected output:

```
Hello from my first Docker container
```


### Step 5: Inspecting Containers

```bash
docker ps
docker ps -a
```



### Step 6: Cleanup

```bash
docker stop <container_id>
docker rm <container_id>
docker rmi my-first-image
```
