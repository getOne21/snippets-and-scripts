# GitHub Actions Setup

GitHub Actions provides CI/CD directly inside your GitHub repository.  
With **Workflows**, you can automate builds, tests, and deployments to **Azure** and **AKS**.

---

## 1. Create a Workflow File

Workflows live inside `.github/workflows/`. Example:  

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: 8.0.x
    - name: Restore dependencies
      run: dotnet restore
    - name: Build
      run: dotnet build --no-restore
    - name: Test
      run: dotnet test --no-build --verbosity normal
```

---

## 2. Store Secrets in GitHub

Go to **Repo → Settings → Secrets and Variables → Actions** and add:

- `AZURE_CREDENTIALS` → JSON output of `az ad sp create-for-rbac`  
- `REGISTRY_USERNAME` & `REGISTRY_PASSWORD` → for ACR (if not using federated identity)  

---

## Summary

You now know how to:

1. Create a GitHub Actions workflow  
2. Store secrets securely  

Next, see how to [Build & Push Docker Images](build-and-push-docker.md).
