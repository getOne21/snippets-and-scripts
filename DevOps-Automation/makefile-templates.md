# Makefile Templates for Build & Deploy

Makefiles help automate **build and deployment** workflows for .NET, Docker, and CI/CD pipelines.

---

## 📝 How to Create & Use a Makefile  

1. **Create a file named `Makefile`** in your project root (no extension).  

   ```bash
   touch Makefile
   ```

2. **Copy one of the templates** below into the file.  

   > ⚠️ Important: Use **tabs** (not spaces) at the start of each command line in Makefiles.  

3. **Run Make commands**  

   ```bash
   make build
   make test
   make run
   ```

   Output will show the executed command (`dotnet build`, `docker build`, etc.).  

---

## 🟦 Makefile for .NET Projects

```makefile
build:
dotnet build src/MyApp.sln

test:
dotnet test tests/MyApp.Tests.csproj

run:
dotnet run --project src/MyApp.Api
```

Usage:

```bash
make build
make test
make run
```

---

## 🐳 Makefile for Docker

```makefile
IMAGE=myapp:latest

build:
docker build -t $(IMAGE) .

run:
docker run -p 8080:80 $(IMAGE)

push:
docker push $(IMAGE)
```

Usage:

```bash
make build
make run
make push
```

---

## ☁️ Makefile for Azure Deployment

1. Create `infra/` folder with `main.bicep` or `main.json`.  
2. Add this Makefile:  

```makefile
RESOURCE_GROUP=myResourceGroup
TEMPLATE=infra/main.bicep

deploy:
az deployment group create \
   --resource-group $(RESOURCE_GROUP) \
   --template-file $(TEMPLATE)
```

Usage:

```bash
make deploy
```

---

## ☁️ General Makefile Example

```makefile
# Variables
IMAGE=myapp:latest
RESOURCE_GROUP=myResourceGroup
TEMPLATE=infra/main.bicep

# .NET commands
build:
dotnet build src/MyApp.sln

test:
dotnet test tests/MyApp.Tests.csproj

run:
dotnet run --project src/MyApp.Api

# Docker commands
docker-build:
docker build -t $(IMAGE) .

docker-run:
docker run -p 8080:80 $(IMAGE)

docker-push:
docker push $(IMAGE)

# Azure deployment
deploy:
az deployment group create \
   --resource-group $(RESOURCE_GROUP) \
   --template-file $(TEMPLATE)

```

---

## ✅ Summary

- **Makefiles** simplify repetitive build/deploy commands  
- Great for **.NET, Docker, and Azure automation**  
- Can be integrated into **CI/CD pipelines**  
