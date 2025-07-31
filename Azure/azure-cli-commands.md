# ☁️ Azure CLI Scripts & Daily Commands

This document contains frequently used Azure CLI commands and reusable scripts to help streamline daily Azure operations.

---

## 🔐 Authentication & Account Management

### Login to Azure

```bash
az login
```

### Login using device code (useful for WSL, SSH, etc.)

```bash
az login --use-device-code
```

### List available subscriptions

```bash
az account list --output table
```

### Set default subscription

```bash
az account set --subscription "<SUBSCRIPTION_NAME_OR_ID>"
```

---

## 📁 Resource Group Management

### List all resource groups

```bash
az group list --output table
```

### Create a new resource group

```bash
az group create --name MyResourceGroup --location westeurope
```

### Delete a resource group

```bash
az group delete --name MyResourceGroup --yes --no-wait
```

---

## 🖥️ Virtual Machine Management

### Start a VM

```bash
az vm start --name MyVM --resource-group MyResourceGroup
```

### Stop a VM

```bash
az vm stop --name MyVM --resource-group MyResourceGroup
```

### Restart a VM

```bash
az vm restart --name MyVM --resource-group MyResourceGroup
```

### Get public IP of a VM

```bash
az vm list-ip-addresses --name MyVM --output table
```

### Run command inside a Linux VM

```bash
az vm run-command invoke \
  --command-id RunShellScript \
  --name MyVM \
  --resource-group MyResourceGroup \
  --scripts "uptime"
```

---

## ☁️ Azure Storage

### List storage accounts

```bash
az storage account list --output table
```

### Upload a file to Blob Storage

```bash
az storage blob upload \
  --account-name <StorageAccountName> \
  --container-name <ContainerName> \
  --name myfile.txt \
  --file ./myfile.txt
```

> You may need to pass `--auth-mode login` or a connection string.

### List blobs in a container

```bash
az storage blob list \
  --account-name <StorageAccountName> \
  --container-name <ContainerName> \
  --output table
```

---

## 🧰 Azure DevOps (az devops extension required)

### Set the default organization/project

```bash
az devops configure --defaults organization=https://dev.azure.com/MyOrg project=MyProject
```

### Queue a pipeline run

```bash
az pipelines run --name "MyPipeline"
```

### List build pipelines

```bash
az pipelines list --output table
```

### List recent pipeline runs

```bash
az pipelines runs list --top 5 --output table
```

---

## 🔐 Azure Key Vault

### List Secrets

```bash
az keyvault secret list --vault-name MyKeyVault --output table
```

### Get a Secret's Value

```bash
az keyvault secret show --vault-name MyKeyVault --name MySecret --query value -o tsv
```

### Set a Secret

```bash
az keyvault secret set --vault-name MyKeyVault --name MySecret --value "myvalue"
```

---

## 🌐 App Services

### List all App Services

```bash
az webapp list --output table
```

### Show the default hostname (DNS) of an App Service

```bash
az webapp show \
  --name MyApp \
  --resource-group MyResourceGroup \
  --query defaultHostName
```

### Tail application logs

```bash
az webapp log tail --name MyApp --resource-group MyResourceGroup
```

---

## 🔄 ARM Template Export

### Export resource group as ARM template

```bash
az group export --name MyResourceGroup > template.json
```

---

## 🧪 Useful Script Snippets

### Script: Restart All VMs in a Resource Group

```bash
#!/bin/bash
RESOURCE_GROUP="MyResourceGroup"
for vm in $(az vm list -g $RESOURCE_GROUP --query "[].name" -o tsv); do
  echo "Restarting VM: $vm"
  az vm restart --name $vm --resource-group $RESOURCE_GROUP
done
```

---

### Script: Start VMs Tagged as `autostart=true`

```bash
#!/bin/bash
az vm list --query "[?tags.autostart=='true'].{name:name, rg:resourceGroup}" -o tsv |
while read vmname rg; do
  echo "Starting $vmname in $rg..."
  az vm start --name "$vmname" --resource-group "$rg"
done
```

---

### Script: Upload All Files in Folder to Blob Storage

```bash
#!/bin/bash
STORAGE_ACCOUNT="mystorageaccount"
CONTAINER="mycontainer"
FOLDER="./files"

for file in "$FOLDER"/*; do
  filename=$(basename "$file")
  echo "Uploading $filename..."
  az storage blob upload \
    --account-name "$STORAGE_ACCOUNT" \
    --container-name "$CONTAINER" \
    --name "$filename" \
    --file "$file" \
    --auth-mode login
done
```

---

### Script: Create Resource Group and Deploy Bicep File

```bash
#!/bin/bash
RESOURCE_GROUP="MyRG"
LOCATION="westeurope"
BICEP_FILE="main.bicep"

az group create --name $RESOURCE_GROUP --location $LOCATION

az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file $BICEP_FILE
```

---

## 📌 Tips

- Use `--output table` or `--output json` for readable output.
- Combine with `jq` or `grep` for advanced filtering.
- Use `az configure --defaults group=MyRG location=westeurope` to reduce repetition.
