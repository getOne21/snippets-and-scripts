# 🐳 Docker – Install Guide & Useful Commands

## 🛠️ Installation on Windows

### Install Docker Desktop

1. Download from: [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
2. Run the installer.
3. Enable required features (e.g., WSL 2 backend or Hyper-V).
4. Restart your machine if prompted.

> Ensure **WSL 2** is enabled:

```powershell
wsl --install
```

Verify installation:

```powershell
docker --version
docker compose version
```

---

## 📦 Post-Install Check

```bash
docker run hello-world
```

This downloads and runs a test image to confirm your installation is working.

---

## 🧰 Common Docker Commands

```bash
docker ps                         # List running containers
docker ps -a                      # List all containers
docker images                     # List downloaded images
docker run -it ubuntu bash        # Start interactive container
docker exec -it <container> bash  # Exec into running container
docker stop <container>           # Stop a container
docker rm <container>             # Remove container
docker rmi <image>                # Remove image
docker build -t name .            # Build from Dockerfile
docker compose up -d              # Start containers via compose
docker compose down               # Stop and clean up
```

---

## 📁 Docker File System & Volumes

```bash
docker volume create myvolume
docker run -v myvolume:/data ubuntu
docker volume ls
docker volume inspect myvolume
```

---
