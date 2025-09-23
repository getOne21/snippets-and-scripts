# Advanced Features of AKS with Azure CLI

This section builds upon the [Introduction Guide](aks-introduction.md) and demonstrates **advanced AKS features** using the Azure CLI.

---

## 1. Creating a Cluster with Virtual Node Pools

AKS supports multiple node pools for different workloads. For example, you can create a cluster with a **system node pool** and an additional **user node pool** for GPU workloads.

```bash
az aks create   --resource-group myResourceGroup   --name myAdvancedCluster   --node-count 1   --enable-addons monitoring   --generate-ssh-keys
```

Add a new node pool:

```bash
az aks nodepool add   --resource-group myResourceGroup   --cluster-name myAdvancedCluster   --name gpuPool   --node-count 1   --node-vm-size Standard_NC6
```

---

## 2. Enabling Cluster Autoscaler

The **cluster autoscaler** automatically adjusts the number of nodes.

Enable autoscaler on a node pool:

```bash
az aks nodepool update   --resource-group myResourceGroup   --cluster-name myAdvancedCluster   --name nodepool1   --enable-cluster-autoscaler   --min-count 1   --max-count 5
```

---

## 3. Integrating with Azure Container Registry (ACR)

To pull private images from an Azure Container Registry, grant the AKS cluster permissions:

```bash
az aks create   --resource-group myResourceGroup   --name myAksWithAcr   --node-count 2   --attach-acr myContainerRegistry   --generate-ssh-keys
```

Or attach ACR to an existing cluster:

```bash
az aks update   --resource-group myResourceGroup   --name myAdvancedCluster   --attach-acr myContainerRegistry
```

---

## 4. Enabling Role-Based Access Control (RBAC)

AKS supports **Azure Active Directory (AAD) integration** with RBAC for fine-grained access control.

Enable AAD integration when creating a cluster:

```bash
az aks create   --resource-group myResourceGroup   --name myRBACCluster   --enable-aad   --enable-azure-rbac   --node-count 2   --generate-ssh-keys
```

Assign a role to a user:

```bash
az role assignment create   --assignee <user-object-id>   --role "Azure Kubernetes Service RBAC Reader"   --scope $(az aks show --resource-group myResourceGroup --name myRBACCluster --query id -o tsv)
```

---

## 5. Upgrading an AKS Cluster

Check available Kubernetes versions:

```bash
az aks get-upgrades   --resource-group myResourceGroup   --name myAdvancedCluster
```

Upgrade the cluster:

```bash
az aks upgrade   --resource-group myResourceGroup   --name myAdvancedCluster   --kubernetes-version <new-version>   --yes
```

---

## 6. Enabling Managed Identities

AKS clusters can use **managed identities** instead of service principals for secure resource access.

```bash
az aks create   --resource-group myResourceGroup   --name myManagedCluster   --enable-managed-identity   --node-count 2   --generate-ssh-keys
```

---

## 🛠️ Daily Admin Commands Cheat Sheet

### Node Pools
```bash
# List node pools
az aks nodepool list --resource-group myResourceGroup --cluster-name myAdvancedCluster -o table

# Add a node pool
az aks nodepool add --resource-group myResourceGroup --cluster-name myAdvancedCluster --name pool2 --node-count 2

# Scale a node pool
az aks nodepool scale --resource-group myResourceGroup --cluster-name myAdvancedCluster --name pool2 --node-count 5

# Delete a node pool
az aks nodepool delete --resource-group myResourceGroup --cluster-name myAdvancedCluster --name pool2
```

### Upgrades & Versions
```bash
# Show available Kubernetes upgrades
az aks get-upgrades --resource-group myResourceGroup --name myAdvancedCluster -o table

# Upgrade cluster version
az aks upgrade --resource-group myResourceGroup --name myAdvancedCluster --kubernetes-version <version> --yes

# Upgrade node image (latest security patches)
az aks upgrade --resource-group myResourceGroup --name myAdvancedCluster --node-image-only --yes
```

### RBAC & Security
```bash
# Get cluster admin credentials
az aks get-credentials --resource-group myResourceGroup --name myRBACCluster --admin

# List role assignments
az role assignment list --scope $(az aks show --resource-group myResourceGroup --name myRBACCluster --query id -o tsv) -o table
```

### ACR Integration
```bash
# Attach ACR to an existing cluster
az aks update --resource-group myResourceGroup --name myAdvancedCluster --attach-acr myContainerRegistry

# Verify if ACR is attached
az aks show --resource-group myResourceGroup --name myAdvancedCluster --query "servicePrincipalProfile.clientId"
```

---

## Summary

In this guide, you learned how to:
1. Create multiple node pools  
2. Enable and configure cluster autoscaler  
3. Integrate AKS with Azure Container Registry  
4. Use RBAC and AAD integration  
5. Upgrade an AKS cluster  
6. Enable managed identities  
7. Apply daily admin commands for practical management  

These advanced features allow you to build secure, scalable, and production-ready Kubernetes environments on Azure.
