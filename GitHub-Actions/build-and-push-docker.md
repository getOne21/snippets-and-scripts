# GitHub Actions: Build & Push Docker Images

This workflow builds and pushes a Docker image to **Azure Container Registry (ACR)** whenever code is pushed to `main`.

---

## Example Workflow

```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Log in to ACR
        uses: azure/docker-login@v2
        with:
          login-server: myregistry.azurecr.io
          username: ${{ secrets.REGISTRY_USERNAME }}
          password: ${{ secrets.REGISTRY_PASSWORD }}

      - name: Build and push
        run: |
          docker build -t myregistry.azurecr.io/myapp:${{ github.sha }} .
          docker push myregistry.azurecr.io/myapp:${{ github.sha }}
```

---

## Explanation

- `azure/docker-login@v2` → Logs in to your ACR.  
- `docker build` → Builds the container image.  
- `docker push` → Pushes it to the registry.  
- `${{ github.sha }}` → Uses commit SHA as the image tag.  

---

## Next Steps

Deploy this image to AKS using [Deploy to AKS](deploy-to-aks.md).
