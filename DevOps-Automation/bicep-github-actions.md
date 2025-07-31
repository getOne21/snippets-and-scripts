# 🚀 Full Azure Web App Deployment with Bicep & GitHub Actions

This guide provides a full working example to deploy a .NET 8 web application to Azure using:

- ✅ **Bicep** for resource provisioning
- ✅ **GitHub Actions** for CI/CD pipeline
- ✅ **Managed Identity** and App Settings
- ✅ **App Service Plan**, Diagnostics, and optional Key Vault integration

---

## 📁 File Structure

```code
Templates/
├─ webapp-full.bicep
.github/
└─ workflows/
   └─ deploy.yml
```

---

## 🧱 Bicep Template – `webapp-full.bicep`

```bicep
param siteName string = 'mydotnetapp'
param hostingPlanName string = 'myAppServicePlan'
param location string = resourceGroup().location
param environment string = 'Production'

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: siteName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: environment
        }
        {
          name: 'MySetting'
          value: 'example'
        }
      ]
    }
    httpsOnly: true
  }
  dependsOn: [
    hostingPlan
  ]
}
```

---

## 🤖 GitHub Actions – `.github/workflows/deploy.yml`

```yaml
name: 🚀 Deploy .NET App to Azure

on:
  push:
    branches: [ main ]

permissions:
  id-token: write
  contents: read

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Set up .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: '8.x'

    - name: Restore
      run: dotnet restore

    - name: Build
      run: dotnet build --configuration Release --no-restore

    - name: Publish
      run: dotnet publish -c Release -o publish

    - name: Login to Azure
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Deploy Bicep Template
      uses: azure/arm-deploy@v1
      with:
        resourceGroupName: 'MyResourceGroup'
        template: Templates/webapp-full.bicep
        parameters: siteName='mydotnetapp' hostingPlanName='myAppServicePlan'

    - name: Deploy App Package
      uses: azure/webapps-deploy@v3
      with:
        app-name: 'mydotnetapp'
        package: ./publish
```

---

## 🔐 GitHub Secrets Required

Create the following GitHub repo secrets:

| Name                    | Description                        |
|-------------------------|------------------------------------|
| `AZURE_CLIENT_ID`       | Azure AD App registration clientId |
| `AZURE_TENANT_ID`       | Azure AD tenant ID                 |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID              |

---

## ✅ How to Deploy

```bash
# Log in and create resource group
az login
az group create -n MyResourceGroup -l westeurope

# Deploy Bicep manually (optional)
az deployment group create   --resource-group MyResourceGroup   --template-file Templates/webapp-full.bicep   --parameters siteName='mydotnetapp'
```

Or push to your GitHub `main` branch and let Actions do the rest.

---

## 📚 References

- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [GitHub Actions for Azure](https://github.com/Azure/actions)

---
