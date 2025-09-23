# Terraform: Deploying Azure Resources

This guide shows how to use **Terraform** to provision Azure resources.

---

## 1. Configure Azure Provider

Create a file `main.tf`:

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_storage_account" "sa" {
  name                     = "mystorageacct12345"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

---

## 2. Initialize, Plan & Apply

```bash
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

This will create the resource group and storage account in Azure.

---

## 3. Store State in Azure Storage (Best Practice)

Create a `backend.tf`:

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

Initialize with backend config:

```bash
terraform init -backend-config="resource_group_name=tfstate-rg"   -backend-config="storage_account_name=tfstateaccount"   -backend-config="container_name=tfstate"   -backend-config="key=terraform.tfstate"
```

---

## 4. Destroy Resources

```bash
terraform destroy
```

---

## ✅ Summary

- Use Terraform to declare Azure infrastructure as code.  
- Always use remote state (Azure Storage).  
- Combine with [GitHub Actions IaC](../GitHub-Actions/github-actions-iac.md) for automation.  
