# Terraform Setup

This guide explains how to install and configure **Terraform** for managing Azure resources.

---

## 1. Install Terraform

### On Windows (using Chocolatey)

```bash
choco install terraform
```

### On macOS (using Homebrew)

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

### On Linux

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform
```

---

## 2. Verify Installation

```bash
terraform -version
```

---

## 3. Authenticate Terraform with Azure

Login to Azure via CLI:

```bash
az login
```

Set a default subscription:

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

Terraform will use the Azure CLI credentials for authentication.
