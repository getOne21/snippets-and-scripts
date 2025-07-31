# 🚀 Azure Web App Deployment – Multi-Stage (Dev + Prod) with Bicep & GitHub Actions

This guide sets up a two-stage deployment pipeline:

- ✅ **Staging (Dev)** on push to `main`
- ✅ **Production** on manual dispatch
- Uses **Bicep** templates and **GitHub Actions**

---

## 📁 Folder Structure

```code
Templates/
├─ webapp-full.bicep
.github/
└─ workflows/
   └─ deploy-multistage.yml
```

---

## 🧱 `webapp-full.bicep`

Same template used for both environments, with parameters for:

- `siteName`
- `hostingPlanName`
- `location`
- `environment`

> See [webapp-full.bicep](./Templates/Bicep/webapp-full.bicep)

---

## 🤖 `.github/workflows/deploy-multistage.yml`

> See [deploy-multistage.yml](./Templates/GitHubActions/deploy-multistage.yml)

```yaml
name: 🚀 Azure Multi-Stage Deploy (.NET + Bicep)

on:
  push:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'prod'
        type: choice
        options:
          - prod

permissions:
  id-token: write
  contents: read

jobs:
  deploy-dev:
    if: github.event_name == 'push'
    name: Deploy to Dev
    runs-on: ubuntu-latest
    environment: development

    steps:
    - uses: actions/checkout@v4

    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: '8.x'

    - name: Restore, Build, Publish
      run: |
        dotnet restore
        dotnet build --configuration Release
        dotnet publish -c Release -o publish

    - name: Azure Login
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Deploy Infrastructure (Dev)
      uses: azure/arm-deploy@v1
      with:
        resourceGroupName: 'rg-dev-app'
        template: Templates/webapp-full.bicep
        parameters: siteName='dev-dotnetapp' hostingPlanName='dev-serviceplan' environment='Development'

    - name: Deploy App Package (Dev)
      uses: azure/webapps-deploy@v3
      with:
        app-name: 'dev-dotnetapp'
        package: ./publish

  deploy-prod:
    if: github.event_name == 'workflow_dispatch' && github.event.inputs.environment == 'prod'
    name: Deploy to Production
    runs-on: ubuntu-latest
    environment: production

    steps:
    - uses: actions/checkout@v4

    - name: Setup .NET
      uses: actions/setup-dotnet@v4
      with:
        dotnet-version: '8.x'

    - name: Restore, Build, Publish
      run: |
        dotnet restore
        dotnet build --configuration Release
        dotnet publish -c Release -o publish

    - name: Azure Login
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Deploy Infrastructure (Prod)
      uses: azure/arm-deploy@v1
      with:
        resourceGroupName: 'rg-prod-app'
        template: Templates/webapp-full.bicep
        parameters: siteName='prod-dotnetapp' hostingPlanName='prod-serviceplan' environment='Production'

    - name: Deploy App Package (Prod)
      uses: azure/webapps-deploy@v3
      with:
        app-name: 'prod-dotnetapp'
        package: ./publish
```

---

## 🧪 Triggering the Workflow

### 🚧 Dev Deployment

Occurs **automatically** on push to `main`.

### 🚀 Production Deployment

Triggered **manually** via GitHub UI:

- Go to "Actions" → "Deploy"
- Click **"Run workflow"**
- Select environment: `prod`

---

## 🔐 Required GitHub Secrets

| Name                    | Description                        |
|-------------------------|------------------------------------|
| `AZURE_CLIENT_ID`       | Azure AD App registration clientId |
| `AZURE_TENANT_ID`       | Azure AD tenant ID                 |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID              |

---

## 📚 References

- [GitHub Actions Matrix](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)
- [Azure Login with OIDC](https://learn.microsoft.com/azure/developer/github/connect-from-azure)

---
