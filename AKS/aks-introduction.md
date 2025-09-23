# Kubernetes on Azure with Azure CLI

This guide introduces **Kubernetes on Azure** using the **Azure Kubernetes Service (AKS)** and demonstrates how to create and manage clusters with the **Azure CLI**.  

AKS is a managed Kubernetes service that simplifies deploying and managing containerized applications. With AKS, Azure handles critical tasks like health monitoring, scaling, and upgrades so you can focus on your applications.

---

## Prerequisites

Before you begin, ensure you have the following installed:

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) (latest version recommended)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) for managing Kubernetes clusters
- An active [Azure subscription](https://azure.microsoft.com/free/)

Log in to Azure:

```bash
az login
```

Verify subscription:

```bash
az account show
```

---

## Step 1: Create a Resource Group

A resource group is a logical container for Azure resources.

```bash
az group create   --name myResourceGroup   --location eastus
```

---

## Step 2: Create an AKS Cluster

Create a simple AKS cluster with a system-assigned managed identity:

```bash
az aks create   --resource-group myResourceGroup   --name myAKSCluster   --node-count 2   --enable-addons monitoring   --generate-ssh-keys
```

**Explanation:**
- `--node-count 2` → Creates 2 worker nodes.
- `--enable-addons monitoring` → Enables Azure Monitor for containers.
- `--generate-ssh-keys` → Generates SSH keys for node authentication.

---

## Step 3: Connect to the Cluster

Get cluster credentials and configure `kubectl` to use them:

```bash
az aks get-credentials   --resource-group myResourceGroup   --name myAKSCluster
```

Verify cluster access:

```bash
kubectl get nodes
```

---

## Step 4: Deploy an Application

Let’s deploy a sample **NGINX application**.

Create a file named `nginx-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 80
```

Apply the configuration:

```bash
kubectl apply -f nginx-deployment.yaml
```

Check deployment:

```bash
kubectl get pods
kubectl get service nginx-service
```

After a few minutes, you’ll get an **external IP** for your NGINX service. Open it in the browser to verify.

---

## Step 5: Scaling the Application

Scale the NGINX deployment to 5 replicas:

```bash
kubectl scale deployment nginx-deployment --replicas=5
```

Check updated pods:

```bash
kubectl get pods
```

---

## Step 6: Delete the Cluster

When you’re done, delete the resource group to remove all resources:

```bash
az group delete --name myResourceGroup --yes --no-wait
```

---

## 🌟 Good to Know for Beginners

- **Pods** → Smallest unit (containers run inside pods).  
- **Deployments** → Manage pods with updates, scaling, and rollback.  
- **Services** → Expose pods (internal `ClusterIP`, external `LoadBalancer`).  
- **Ingress** → Routes HTTP traffic into the cluster, great for multiple apps.  
- **Namespaces** → Logical separation (e.g., `dev`, `test`, `prod`).  
- **Persistent Volumes** → For storing data beyond pod lifetimes (Azure Disks/Files).  
- **Monitoring** → Use `kubectl logs` & `kubectl describe` for quick debugging.  

💡 Remember: the AKS control plane is **free**, you only pay for the worker nodes.  

---

## 🛠️ Daily Commands Cheat Sheet

### Azure CLI (AKS)
```bash
# List AKS clusters
az aks list -o table

# Show cluster details
az aks show --resource-group myResourceGroup --name myAKSCluster

# Get credentials (login to cluster)
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

# Scale cluster node count
az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 3
```

### kubectl
```bash
# Cluster info
kubectl cluster-info

# List all namespaces
kubectl get namespaces

# List all pods in current namespace
kubectl get pods

# List pods across all namespaces
kubectl get pods -A

# Get deployments
kubectl get deployments

# Get services
kubectl get svc

# Detailed info about a pod
kubectl describe pod <pod-name>

# Logs from a pod
kubectl logs <pod-name>

# Run a shell inside a pod
kubectl exec -it <pod-name> -- /bin/bash

# Delete a deployment
kubectl delete deployment <deployment-name>
```

---

## Summary

In this guide, you learned how to:
1. Create a resource group in Azure  
2. Provision an AKS cluster with Azure CLI  
3. Connect to the cluster using `kubectl`  
4. Deploy and scale a sample application  
5. Use daily commands for management  
6. Clean up resources  

With this foundation, you can start deploying more complex workloads and integrating AKS with other Azure services.
