# 🐳 Docker Useful CLI Commands

This document contains useful and commonly used Docker commands for daily use, from building images to managing containers and volumes.

---

## 🔧 Build and Run Containers

### Build an Image

```bash
docker build -t myapp:latest .
```

### Run a Container

```bash
docker run -d --name mycontainer -p 8080:80 myapp:latest
```

### Run a Container with Volume Mount

```bash
docker run -v $(pwd)/data:/app/data myapp
```

### Run with Environment Variables or Automatically Remove on Exit

```bash
docker run -d --name mycontainer -e APP_ENV=development myapp
docker run --rm myapp npm test
```

---

## 📦 Manage Images

### List Images

```bash
docker images
```

### Remove Image

```bash
docker rmi <image_id>
```

### Prune Unused Images

```bash
docker image prune -a
```

### Inspect or Tag an Image

```bash
docker image inspect myapp:latest
docker tag myapp:latest myregistry/myapp:v1
```

---

## 🚢 Manage Containers

### List Running Containers

```bash
docker ps
```

### List All Containers

```bash
docker ps -a
```

### Stop a Container

```bash
docker stop <container_id>
```

### Start a Container

```bash
docker start <container_id>
```

### Remove a Container

```bash
docker rm <container_id>
```

### Inspect, Restart, or Monitor a Container

```bash
docker inspect <container_id>
docker restart <container_id>
docker stats
docker top <container_id>
```

### Copy Files To or From a Container

```bash
docker cp ./local-file.txt <container_id>:/app/local-file.txt
docker cp <container_id>:/app/output.txt ./output.txt
```

---

## 🧪 Debugging and Logs

### View Logs

```bash
docker logs <container_id>
```

### Exec Into Container

```bash
docker exec -it <container_id> /bin/bash
```

---

## 📂 Manage Volumes and Networks

### List Volumes

```bash
docker volume ls
```

### Remove a Volume

```bash
docker volume rm <volume_name>
```

### List Networks

```bash
docker network ls
```

### Create a Network

```bash
docker network create my-network
```

---

## 🧩 Docker Compose

Use Compose to define and run multi-container applications from a Compose YAML file:

```bash
docker compose up -d                   # Build (if needed) and start services
docker compose ps                      # Show service status
docker compose logs -f                 # Follow logs from all services
docker compose exec <service> sh       # Open a shell in a running service
docker compose down                    # Stop and remove containers and networks
```

See the [Docker Compose command reference](../Docker-Compose/docker-compose-commands.md) for
profiles, scaling, configuration, volumes, and other workflows.

---

## 📤 Push/Pull from Registry

### Login to Docker Hub

```bash
docker login
```

### Tag and Push to Docker Hub

```bash
docker tag myapp:latest mydockerhubuser/myapp:latest
docker push mydockerhubuser/myapp:latest
```

### Pull from Docker Hub

```bash
docker pull mydockerhubuser/myapp:latest
```

---

## 🧹 Cleanup Commands

### Remove All Stopped Containers

```bash
docker container prune
```

### Remove All Unused Data

```bash
docker system prune -a
```
