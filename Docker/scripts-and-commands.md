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
