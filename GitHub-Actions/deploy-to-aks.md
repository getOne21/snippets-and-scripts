# GitHub Actions: Deploy to AKS

This workflow deploys Kubernetes manifests to an **Azure Kubernetes Service (AKS)** cluster.

---

## Example Workflow

```yaml
name: Deploy to AKS

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

      - name: Get AKS credentials
        run: az aks get-credentials --resource-group myResourceGroup --name myAKSCluster --overwrite-existing

      - name: Deploy to AKS
        run: |
          kubectl apply -f k8s/deployment.yaml
          kubectl apply -f k8s/service.yaml
```

---

## Explanation

- `azure/login@v2` → Authenticates with Azure using a service principal.  
- `az aks get-credentials` → Retrieves kubeconfig for the cluster.  
- `kubectl apply` → Deploys your manifests to AKS.  

---

## Best Practices

- Use `workflow_dispatch` for manual deploys, or `on: push` for automatic.  
- Use **namespaces** to separate environments (`dev`, `test`, `prod`).  
- Consider adding a **Helm step** if using Helm charts.  
