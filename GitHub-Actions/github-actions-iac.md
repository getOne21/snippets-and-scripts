# GitHub Actions: Deploy Azure Resources with IaC (Bicep, ARM, Terraform)

This guide shows how to use **Infrastructure as Code (IaC)** tools with **GitHub Actions** to deploy Azure resources into a resource group.  
We’ll cover **Bicep**, **ARM templates**, and **Terraform**.

---

## ☁️ Using Bicep

Bicep is a higher-level DSL for Azure Resource Manager and the recommended choice for Azure IaC.

### Bicep Example

```yaml
name: Deploy Bicep

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }} # or OIDC login

      - name: Deploy Bicep Template
        run: |
          az deployment group create             --resource-group myResourceGroup             --template-file infrastructure/main.bicep             --parameters appName=myApp env=prod
```

### Notes

- Use `az deployment sub create` for subscription-level deployments.  
- Parameters can be passed inline or via `.bicepparam` files.  

---

## 📜 Using ARM Templates

ARM templates are JSON-based. They are the foundation of Bicep.

### ARM Example

```yaml
name: Deploy ARM

on:
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Deploy ARM Template
        run: |
          az deployment group create             --resource-group myResourceGroup             --template-file infrastructure/main.json             --parameters appName=myApp env=prod
```

### ARM Example Notes

- Still supported, but verbose compared to Bicep.  
- Useful when working with existing ARM JSON templates.  

---

## 🌍 Using Terraform

Terraform is multi-cloud and widely used. Best when managing Azure + other providers.

### Terraform Example

```yaml
name: Deploy Terraform

on:
  push:
    branches: [ main ]

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
```

### Backend for State

Store state in **Azure Storage**:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

Run once to initialize the backend:

```bash
terraform init -backend-config="resource_group_name=tfstate-rg"   -backend-config="storage_account_name=tfstateaccount"   -backend-config="container_name=tfstate"   -backend-config="key=terraform.tfstate"
```

---

## ✅ Summary

- **Bicep** → Modern, Azure-native, concise syntax.  
- **ARM** → Legacy JSON, still supported.  
- **Terraform** → Multi-cloud, stateful, enterprise-friendly.  

All can be integrated into **GitHub Actions** for automated Azure deployments.  
