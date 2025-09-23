# GitHub Actions: Advanced Setup & Best Practices

This guide builds on the basics of [GitHub Actions Setup](github-actions-setup.md), [Build & Push Docker](build-and-push-docker.md), and [Deploy to AKS](deploy-to-aks.md).  
It focuses on making your workflows **secure, reliable, and production-ready** when deploying to **Azure**.

---

## 🔑 Authentication & Security

### Use Federated Identity (OIDC) Instead of Secrets

Avoid storing service principal credentials in GitHub. Instead, configure **Workload Identity Federation (OIDC)**:

1. Create a federated identity in Azure AD for your GitHub repo.  
2. Configure GitHub workflow to authenticate with Azure:

```yaml
- name: Azure Login (OIDC)
  uses: azure/login@v2
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

This eliminates the need to store passwords in GitHub.

### Least Privilege Role Assignments

Assign roles at the **resource group** level, not subscription-wide.

```bash
az role assignment create   --assignee <clientId>   --role Contributor   --scope /subscriptions/<subId>/resourceGroups/myResourceGroup
```

---

## 📦 Container Registry & Images

### Image Tagging Strategy

Use consistent tagging for traceability:

- `myapp:1.0.0` → release version  
- `myapp:latest` → latest stable build  
- `myapp:${{ github.sha }}` → unique commit-based tag  

### Retention Policies

Configure ACR to automatically delete old images:

```bash
az acr config retention update   --registry myRegistry   --status Enabled   --days 30   --type UntaggedManifests
```

---

## ☸️ Kubernetes Deployment Strategies

### Namespaces per Environment

Organize workloads with namespaces (`dev`, `test`, `prod`).

```bash
kubectl create namespace dev
kubectl create namespace prod
```

### Deploy with Helm

Instead of raw YAML, use Helm for reusable charts:

```yaml
- name: Deploy with Helm
  run: |
    helm upgrade --install myapp ./charts/myapp       --namespace prod       --set image.repository=myregistry.azurecr.io/myapp       --set image.tag=${{ github.sha }}
```

### Blue/Green or Canary

- **Blue/Green**: Deploy new version alongside old, then switch traffic.  
- **Canary**: Gradually roll out to a subset of users.  

---

## 📊 Monitoring & Logging

### Rollout Verification

Ensure pods are ready before marking deploy successful:

```yaml
- name: Verify rollout
  run: kubectl rollout status deployment/myapp -n prod
```

### Azure Monitor Integration

Enable monitoring addon:

```bash
az aks enable-addons --addons monitoring --name myAKSCluster --resource-group myResourceGroup
```

Logs go to **Azure Monitor** → **Log Analytics Workspace**.

---

## 🔄 Multi-Stage Workflows

Use multiple stages (build → dev → prod) with **environments** and approvals.

```yaml
on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps: ...

  deploy-dev:
    needs: build
    environment: dev
    steps: ...

  deploy-prod:
    needs: deploy-dev
    environment: prod
    steps: ...
```

Set **required approvals** in GitHub Environments before production deploy.

---

## ⚡ Performance & Cost Optimization

- **Cluster Autoscaler** → scale nodes dynamically.  
- **Pod Autoscaler** → auto-scale deployments.  
- **Spot Node Pools** → save cost on non-critical workloads.  

---

## 🛡️ Policy & Governance

### Azure Policy for AKS

Apply compliance rules:

```bash
az policy assignment create   --name restrictPrivileged   --scope /subscriptions/<subId>/resourceGroups/myResourceGroup   --policy <policyDefinitionId>
```

### Container Image Scanning

Add security scanning (e.g., Trivy):

```yaml
- name: Scan image with Trivy
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: myregistry.azurecr.io/myapp:${{ github.sha }}
```

---

## ✅ Summary

With these improvements, your GitHub Actions pipelines are:

1. **Secure** → OIDC login, least-privilege roles, no secrets in GitHub.  
2. **Traceable** → Strong image tagging and retention.  
3. **Flexible** → Helm, namespaces, and deployment strategies.  
4. **Reliable** → Rollout verification, monitoring integration.  
5. **Controlled** → Multi-stage workflows with approvals.  
6. **Compliant** → Azure Policy + container scanning.  

This setup moves your pipelines from **basic CI/CD** to **enterprise-grade DevOps**.
