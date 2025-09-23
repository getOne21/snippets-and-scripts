# GitHub Actions: Connect to Azure & Deploy to a Resource Group

This guide explains how to set up authentication between **GitHub Actions** and **Azure**, and how to deploy resources into a **resource group**.

---

## 🔑 Option 1: Service Principal + Secret (Legacy)

This method uses a **Service Principal (SP)** with a client secret stored in GitHub.

### 1. Create a Service Principal

```bash
az ad sp create-for-rbac   --name github-actions-sp   --role contributor   --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP>   --sdk-auth
```

This outputs JSON like:

```json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "...",
  ...
}
```

### 2. Store in GitHub Secrets

- Go to **Repo → Settings → Secrets and Variables → Actions**
- Add a new secret called **AZURE_CREDENTIALS**
- Paste the JSON output

### 3. Login in Workflow

```yaml
- name: Azure Login
  uses: azure/login@v2
  with:
    creds: ${{ secrets.AZURE_CREDENTIALS }}
```

---

## 🔒 Option 2: Federated Identity (OIDC) — Recommended

This is the modern approach. No secrets are stored in GitHub.

### 1. Create Azure AD App

```bash
az ad app create --display-name github-actions-app
```

### 2. Create Federated Credential

```bash
az ad app federated-credential create   --id <APP_ID>   --parameters '{
    "name":"github-oidc",
    "issuer":"https://token.actions.githubusercontent.com",
    "subject":"repo:<ORG>/<REPO>:ref:refs/heads/main",
    "audiences":["api://AzureADTokenExchange"]
  }'
```

- Replace `<ORG>/<REPO>` with your GitHub repo name.  
- The `subject` defines which branch/environment can request tokens.

### 3. Assign Role at Resource Group Scope

```bash
az role assignment create   --assignee <APP_ID>   --role contributor   --scope /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP>
```

### 4. Store IDs in GitHub Secrets

Add these secrets in GitHub:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

### 5. Login in Workflow

```yaml
- name: Azure Login (OIDC)
  uses: azure/login@v2
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

---

## 🚀 Deploy Into a Resource Group

After login, you can deploy resources with **Azure CLI**, **Bicep**, or **ARM**.

### Example: Deploy Bicep Template

```yaml
- name: Deploy Bicep to Azure
  run: |
    az deployment group create       --resource-group myResourceGroup       --template-file infrastructure/main.bicep       --parameters appName=myApp env=prod
```

### Example: Deploy Web App Directly

```yaml
- name: Deploy Web App
  run: |
    az webapp up       --name mywebapp123       --resource-group myResourceGroup       --runtime "DOTNET:8.0"       --sku B1
```

---

## ✅ Summary

- **Service Principal + Secret**: Easy to set up but stores credentials in GitHub.  
- **Federated Identity (OIDC)**: More secure, no secrets stored, recommended by Microsoft.  
- After login, deploy resources into the resource group with `az` CLI or Bicep/ARM templates.  
