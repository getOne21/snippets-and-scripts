# 🐳 Docker Compose Commands

> Define and run multi-container applications with a single YAML file — orchestrate services, networks, and volumes locally.

---

## 📦 Installation

Docker Compose V2 is included with Docker Desktop. For standalone installation:

```bash
# Linux (standalone plugin)
sudo apt-get install docker-compose-plugin

# Verify installation
docker compose version
```

> **Note:** V2 uses `docker compose` (space). The legacy `docker-compose` (hyphen) is deprecated.

---

## 🚀 Starting & Stopping Services

```bash
docker compose up                           # Start all services (foreground)
docker compose up -d                        # Start in detached mode (background)
docker compose up --build                   # Build images before starting
docker compose up --force-recreate          # Recreate containers even if unchanged
docker compose up -d --remove-orphans       # Remove containers for undefined services
docker compose up service1 service2         # Start specific services only

docker compose down                         # Stop and remove containers, networks
docker compose down -v                      # Also remove named volumes
docker compose down --rmi all               # Also remove all images
docker compose down --rmi local             # Remove only images without a custom tag

docker compose stop                         # Stop services (don't remove)
docker compose start                        # Start stopped services
docker compose restart                      # Restart all services
docker compose restart service1             # Restart a specific service
```

---

## 🔨 Building Images

```bash
docker compose build                        # Build all services
docker compose build service1               # Build a specific service
docker compose build --no-cache             # Build without cache
docker compose build --pull                 # Always pull base images
docker compose build --parallel             # Build in parallel
```

---

## 📋 Viewing Status & Logs

```bash
docker compose ps                           # List running containers
docker compose ps -a                        # List all containers (incl. stopped)
docker compose ps --format json             # Output as JSON

docker compose logs                         # View logs from all services
docker compose logs service1                # Logs from specific service
docker compose logs -f                      # Follow logs (stream)
docker compose logs -f --tail=100           # Follow last 100 lines
docker compose logs --since 30m             # Logs from last 30 minutes
docker compose logs --timestamps            # Include timestamps
```

---

## 🛠️ Running Commands in Containers

```bash
docker compose exec service1 bash           # Shell into a running container
docker compose exec service1 sh             # Use sh if bash unavailable
docker compose exec service1 cat /etc/hosts # Run a command in container
docker compose exec -T service1 command     # Non-interactive (for scripts)

docker compose run service1 bash            # Start a new container and run command
docker compose run --rm service1 npm test   # Run and remove after exit
docker compose run -e MY_VAR=value service1 cmd  # With env variable
```

---

## 📈 Scaling Services

```bash
docker compose up -d --scale worker=3       # Scale worker to 3 instances
docker compose up -d --scale web=2 --scale worker=5  # Scale multiple services
```

---

## 🔍 Inspecting Configuration

```bash
docker compose config                       # Validate and view resolved config
docker compose config --services            # List defined service names
docker compose config --volumes             # List defined volumes
docker compose config --profiles            # List defined profiles
```

---

## 📂 Working with Profiles

```yaml
# docker-compose.yml
services:
  web:
    image: nginx
  debug:
    image: busybox
    profiles:
      - debug
```

```bash
docker compose up -d                        # Only starts 'web' (no profile)
docker compose --profile debug up -d        # Starts 'web' + 'debug'
```

---

## 🌐 Networking

```yaml
# docker-compose.yml
services:
  web:
    networks:
      - frontend
  api:
    networks:
      - frontend
      - backend
  db:
    networks:
      - backend

networks:
  frontend:
  backend:
```

```bash
docker compose up -d
docker network ls                           # List networks
docker network inspect <project>_frontend   # Inspect a network
```

---

## 💾 Volumes & Data Persistence

```yaml
# docker-compose.yml
services:
  db:
    image: postgres
    volumes:
      - pgdata:/var/lib/postgresql/data     # Named volume
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql  # Bind mount

volumes:
  pgdata:
```

```bash
docker volume ls                            # List volumes
docker volume inspect <project>_pgdata      # Inspect a volume
docker compose down -v                      # Remove volumes on shutdown
```

---

## 🔧 Environment Variables

```yaml
# docker-compose.yml
services:
  app:
    image: myapp
    environment:
      - DB_HOST=db
      - DB_PORT=5432
    env_file:
      - .env
      - .env.local
```

```bash
# .env file (auto-loaded by Compose)
COMPOSE_PROJECT_NAME=myproject
DB_PASSWORD=secret

# Override with shell env
DB_PASSWORD=override docker compose up -d
```

---

## 📄 Multiple Compose Files

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d  # Merge files
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

> **Convention:** `docker-compose.override.yml` is automatically merged with `docker-compose.yml` if present.

---

## 🏥 Health Checks

```yaml
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
```

---

## 📤 Pull & Push Images

```bash
docker compose pull                         # Pull images for all services
docker compose pull service1                # Pull image for specific service
docker compose push                         # Push built images to registry
```

---

## 🧹 Cleanup

```bash
docker compose down -v --rmi all            # Full cleanup (containers, volumes, images)
docker compose rm -s -v                     # Remove stopped containers and volumes
docker system prune -a                      # Global Docker cleanup
```

---

## ⌨️ Useful Tips

```bash
# Use COMPOSE_FILE to set default file
export COMPOSE_FILE=docker-compose.yml:docker-compose.dev.yml

# Project name (defaults to directory name)
docker compose -p myproject up -d
export COMPOSE_PROJECT_NAME=myproject

# Watch mode (auto-rebuild on file changes)
docker compose watch

# Dry-run
docker compose up --dry-run
```

---

## 📚 Resources

- [Docker Compose Docs](https://docs.docker.com/compose/)
- [Compose File Reference](https://docs.docker.com/compose/compose-file/)
- [Compose CLI Reference](https://docs.docker.com/compose/reference/)
