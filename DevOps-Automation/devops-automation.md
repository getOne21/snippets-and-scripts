# ⚡ DevOps & Automation Toolkit

A collection of tools, scripts, and templates to automate cloud infrastructure, deployments, and development pipelines.

---

## ☁️ Azure Bicep & ARM Templates

### 🔧 Install Bicep CLI

```bash
az bicep install
az bicep upgrade
```

### 📄 Compile Bicep to ARM

```bash
bicep build main.bicep
```

### 🚀 Deploy Bicep to Azure

```bash
az deployment group create   --resource-group my-rg   --template-file main.bicep   --parameters @params.json
```

---

## 🐙 GitHub CLI (gh)

### 💻 Install

- [GitHub CLI Install Guide](https://cli.github.com/manual/installation)

### 🔐 Login

```bash
gh auth login
```

### 🧰 Common Commands

```bash
gh repo create my-repo --public --source=. --push
gh issue list
gh pr create --base main --head feature --title "Add feature"
gh release create v1.0.0 --title "Initial Release" --notes "First release"
```

> Use `gh` inside your project folders for best results.

---

## ⚙️ CI/CD Snippets

### 🧪 GitHub Actions – .NET Project Example

```yaml
# .github/workflows/dotnet.yml
name: Build & Test

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4
    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: '8.x'

    - name: Restore dependencies
      run: dotnet restore

    - name: Build
      run: dotnet build --no-restore --configuration Release

    - name: Test
      run: dotnet test --no-build --verbosity normal
```

---

### 🧰 Azure DevOps YAML Snippet

```yaml
# azure-pipelines.yml
trigger:
- main

pool:
  vmImage: 'windows-latest'

steps:
- task: UseDotNet@2
  inputs:
    packageType: 'sdk'
    version: '8.x'

- script: dotnet restore
  displayName: 'Restore packages'

- script: dotnet build --configuration Release
  displayName: 'Build project'

- script: dotnet test --no-build --verbosity normal
  displayName: 'Run tests'
```

---

## 📚 References

- [Bicep Docs](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [GitHub CLI Docs](https://cli.github.com/manual/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Azure DevOps Pipelines](https://learn.microsoft.com/azure/devops/pipelines/)

---

## 📦 Bicep Templates

- Create a Linux VM (Ubuntu) [Linux Ubuntu VM Bicep Template](Templates/Bicep/vm.bicep)
- Create a general-purpose v2 Storage Account [General-Purpose V2 Storage Account Bicep Template](Templates/Bicep/storage.bicep)
- Deploy a .NET 8 Web App on a Free Linux App Service Plan [.NET 8 Web App on a Free Linux App Service Plan Bicep Template](Templates/Bicep/webapp.bicep)
