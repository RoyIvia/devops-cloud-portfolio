# Accessing Your Linux Environment via Docker

After creating a Linux environment (Ubuntu) using Docker, you can interact with it just like a regular Linux system.
This section explains how to start, access, and manage your Linux environment from your host system, including best practices for persistent data and session management.

## 1. Starting Your Linux Environment

If you created an Ubuntu environment using:

```
docker run -it --name myubuntu ubuntu bash
```

-it → starts an interactive terminal

--name myubuntu → gives your container a recognizable name

bash → starts the Bash shell inside Ubuntu

You are now inside your Linux environment, you will see:
```
root@container_id:/#
```
You can run all standard Linux commands here, like ls, pwd, mkdir, apt install, etc.

## 2. Exiting and Returning to Linux

To exit the Environment

```
exit
```
or press Ctrl + D

- This Stops the session and returns you to your host terminal

Your Linux environment is still preserved unless you used ``` --rm ``` when creating it.

### Re-entering the environment Later;

To Check all existing Linux environments,eneter:

```
docker ps -a
```
The status can either be,

- Up → currently running

- Exited → stopped

  
## Understanding Docker Columns

```
| Column           | Meaning                                       |
| ---------------- | --------------------------------------------- |
| CONTAINER ID     | Unique identifier for the container           |
| IMAGE            | The Docker image used to create the container |
| COMMAND          | Command that runs when the container starts   |
| CREATED          | When the container was created                |
| STATUS           | Whether the container is running or stopped   |
| PORTS            | Port mappings from host → container           |
| NAMES            | Human-readable name assigned by Docker        |

```
### Start a stopped environment:

```
docker start -ai myubuntu
```
### To Attach to an already running environment:
```
docker exec -it myubuntu bash
```
### To Detach from a running session without stopping:

Ctrl + P + Q

- This allows the Linux environment to continue running in the background.

## 3. Managing Persistent Files

To save files between sessions, mount a folder on your host:

```
mkdir -p ~/ubuntu-data
docker run -it -v ~/ubuntu-data:/data --name myubuntu ubuntu bash
```
Inside your Linux environment:

```
cd /data
```
- Files saved here are accessible on your host machine at ~/ubuntu-data.

## 4. Inspecting and Troubleshooting Your Environment

Check configuration, mounts, and other settings:

```
docker inspect myubuntu
```
View resource usage:

```
docker stats
```
Check logs for debugging:

```
docker logs myubuntu
```
## 5. Cleaning Up

Stop your Linux environment:

```
docker stop myubuntu
```
Remove it if no longer needed:

```
docker rm myubuntu
```
## 6.Summary of Commands

```
| Action                          | Command                                      |
| ------------------------------- | -------------------------------------------- |
| Create & start Linux            | `docker run -it --name myubuntu ubuntu bash` |
| List running                    | `docker ps`                                  |
| List all (including stopped)    | `docker ps -a`                               |
| Start stopped Linux             | `docker start -ai myubuntu`                  |
| Open new shell in running Linux | `docker exec -it myubuntu bash`              |
| Exit Linux                      | `exit` or `Ctrl + D`                         |
| Detach without stopping         | `Ctrl + P + Q`                               |
| Persist data                    | `-v ~/ubuntu-data:/data`                     |
| Inspect environment             | `docker inspect myubuntu`                    |
| Stop environment                | `docker stop myubuntu`                       |
| Remove environment              | `docker rm myubuntu`                         |

```

### Key Takeaways

- Using Docker to create a Linux environment is a lightweight alternative to installing a full VM.

- You can start, stop, detach, and re-enter your Linux environment at any time.

- Persistent storage ensures files and projects are safe across sessions.

- All Linux commands now work inside this environment.
