# 🦭 Podman – Scripts & Commands

## 🐳 Docker-Compatible Commands

Podman is largely command-compatible with Docker. Most `docker` commands work by replacing `docker` with `podman`.

```bash
podman ps                          # List running containers
podman ps -a                       # List all containers
podman images                      # List local images
podman run -it ubuntu bash         # Start interactive container
podman exec -it <container> bash   # Exec into running container
podman stop <container>            # Stop a container
podman rm <container>              # Remove a container
podman rmi <image>                 # Remove an image
podman build -t name .             # Build from Containerfile / Dockerfile
podman pull <image>                # Pull an image from a registry
podman push <image>                # Push an image to a registry
```

---

## 📦 Podman Compose

Podman supports Docker Compose files via `podman compose` (requires `podman-compose` or the built-in compose support):

```bash
podman compose up -d               # Start services in detached mode
podman compose down                # Stop and remove containers
podman compose logs -f             # Follow logs
podman compose ps                  # List compose services
```

---

## 📁 Volumes

```bash
podman volume create myvolume
podman run -v myvolume:/data ubuntu
podman volume ls
podman volume inspect myvolume
podman volume rm myvolume
```

---

## 🖥️ Podman Machine (Windows / macOS)

```bash
podman machine init                # Initialize default machine
podman machine start               # Start the machine
podman machine stop                # Stop the machine
podman machine ls                  # List all machines
podman machine inspect             # Show machine details
podman machine rm                  # Remove the machine
podman machine ssh                 # SSH into the machine
```

---

## 🔗 Docker Compatibility (Socket Alias)

Podman can expose a Docker-compatible socket so tools that use `docker.sock` (e.g., Testcontainers, VS Code Dev Containers) work transparently:

```bash
podman system service --time=0 unix:///tmp/podman.sock &
export DOCKER_HOST=unix:///tmp/podman.sock
```

Or enable the Docker socket via Podman Desktop → **Settings → Docker Compatibility**.

---

## 🏷️ Pods (Podman-Specific)

Pods group multiple containers that share network and storage — similar to a Kubernetes Pod.

```bash
podman pod create --name mypod
podman run --pod mypod -d nginx
podman pod ps                      # List pods
podman pod inspect mypod
podman pod stop mypod
podman pod rm mypod
```

---

## 🔍 Useful Inspection Commands

```bash
podman inspect <container|image>   # Detailed JSON metadata
podman logs <container>            # Show container logs
podman stats                       # Live resource usage
podman top <container>             # Running processes in container
podman diff <container>            # Filesystem changes since start
podman port <container>            # Show mapped ports
```

---

## 🧹 Cleanup

```bash
podman system prune                # Remove stopped containers, unused images, volumes
podman system prune -a             # Remove everything unused (including all images)
podman container prune             # Remove all stopped containers
podman image prune                 # Remove dangling images
```
