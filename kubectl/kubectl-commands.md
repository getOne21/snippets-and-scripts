# ☸️ kubectl Commands

> The Kubernetes command-line tool for managing clusters, deploying apps, inspecting resources, and debugging workloads.

---

## 📦 Installation

```bash
# macOS
brew install kubectl

# Windows
choco install kubernetes-cli

# Linux (Debian/Ubuntu)
sudo apt-get install -y kubectl

# Or download binary directly
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

---

## ⚙️ Cluster & Context Configuration

```bash
kubectl config view                         # View kubeconfig
kubectl config current-context              # Show active context
kubectl config get-contexts                 # List all contexts
kubectl config use-context my-context       # Switch context
kubectl config set-context --current --namespace=dev  # Set default namespace
kubectl cluster-info                        # Show cluster info
```

---

## 📋 Viewing Resources

```bash
kubectl get pods                            # List pods in current namespace
kubectl get pods -A                         # List pods across all namespaces
kubectl get pods -o wide                    # Show extra details (node, IP)
kubectl get pods -w                         # Watch for changes
kubectl get pods --sort-by=.status.startTime  # Sort by start time

kubectl get svc                             # List services
kubectl get deploy                          # List deployments
kubectl get nodes                           # List cluster nodes
kubectl get ns                              # List namespaces
kubectl get ingress                         # List ingress resources
kubectl get all                             # List common resources
kubectl get all -A                          # All resources, all namespaces

kubectl get pod mypod -o yaml               # Output as YAML
kubectl get pod mypod -o json               # Output as JSON
kubectl get pods -l app=myapp               # Filter by label
kubectl get pods --field-selector status.phase=Running  # Filter by field
```

---

## 🔍 Describing & Inspecting

```bash
kubectl describe pod mypod                  # Detailed pod info (events, status)
kubectl describe node mynode                # Node details
kubectl describe svc myservice              # Service details
kubectl describe deploy mydeployment        # Deployment details

kubectl top pods                            # Pod CPU/memory usage
kubectl top nodes                           # Node CPU/memory usage
```

---

## 🚀 Creating & Applying Resources

```bash
kubectl apply -f manifest.yaml              # Apply a manifest file
kubectl apply -f ./manifests/               # Apply all files in a directory
kubectl apply -f https://example.com/m.yaml # Apply from URL
kubectl apply -k ./kustomize/               # Apply with Kustomize

kubectl create namespace dev                # Create a namespace
kubectl create deployment myapp --image=nginx  # Quick deployment
kubectl create service clusterip mysvc --tcp=80:8080  # Quick service
kubectl create configmap myconfig --from-literal=key=value
kubectl create secret generic mysecret --from-literal=password=abc123
```

---

## ✏️ Editing & Patching

```bash
kubectl edit deployment mydeployment        # Edit in default editor
kubectl patch deployment mydeployment -p '{"spec":{"replicas":3}}'  # Patch
kubectl set image deployment/myapp myapp=nginx:1.25  # Update container image
kubectl label pod mypod env=prod            # Add a label
kubectl annotate pod mypod description="my pod"  # Add an annotation
```

---

## 📈 Scaling & Rolling Updates

```bash
kubectl scale deployment myapp --replicas=5         # Scale to 5 replicas
kubectl autoscale deployment myapp --min=2 --max=10 --cpu-percent=80

kubectl rollout status deployment myapp             # Check rollout progress
kubectl rollout history deployment myapp            # View rollout history
kubectl rollout undo deployment myapp               # Rollback to previous
kubectl rollout undo deployment myapp --to-revision=2  # Rollback to specific
kubectl rollout restart deployment myapp            # Restart all pods
kubectl rollout pause deployment myapp              # Pause rollout
kubectl rollout resume deployment myapp             # Resume rollout
```

---

## 🗑️ Deleting Resources

```bash
kubectl delete pod mypod                    # Delete a pod
kubectl delete pod mypod --grace-period=0 --force  # Force delete
kubectl delete -f manifest.yaml             # Delete from manifest
kubectl delete deployment myapp             # Delete a deployment
kubectl delete ns dev                       # Delete a namespace (and all resources)
kubectl delete pods -l app=myapp            # Delete by label
```

---

## 🐛 Debugging & Troubleshooting

### Logs

```bash
kubectl logs mypod                          # View pod logs
kubectl logs mypod -c mycontainer           # Logs from specific container
kubectl logs mypod --previous               # Logs from previous crashed container
kubectl logs mypod -f                       # Follow / stream logs
kubectl logs mypod --tail=100               # Last 100 lines
kubectl logs mypod --since=1h               # Logs from last hour
kubectl logs -l app=myapp                   # Logs from all pods with label
```

### Exec & Port-Forward

```bash
kubectl exec -it mypod -- /bin/bash         # Shell into a pod
kubectl exec mypod -- cat /etc/config       # Run a command in pod
kubectl port-forward mypod 8080:80          # Forward local port to pod
kubectl port-forward svc/myservice 8080:80  # Forward to service
kubectl port-forward deploy/myapp 8080:80   # Forward to deployment
```

### Debug

```bash
kubectl run debug --image=busybox -it --rm -- sh  # Temp debug pod
kubectl debug mypod -it --image=busybox     # Ephemeral debug container
kubectl get events --sort-by=.metadata.creationTimestamp  # Cluster events
kubectl get events -w                       # Watch events in real-time
```

---

## 📋 ConfigMaps & Secrets

```bash
# ConfigMaps
kubectl create configmap myconfig --from-file=config.yaml
kubectl create configmap myconfig --from-literal=key1=val1 --from-literal=key2=val2
kubectl get configmap myconfig -o yaml      # View config
kubectl delete configmap myconfig

# Secrets
kubectl create secret generic mysecret --from-literal=pass=abc123
kubectl create secret docker-registry regcred --docker-server=... --docker-username=... --docker-password=...
kubectl get secret mysecret -o jsonpath='{.data.pass}' | base64 -d  # Decode secret
kubectl delete secret mysecret
```

---

## 📂 Copy Files To/From Pods

```bash
kubectl cp localfile.txt mypod:/tmp/file.txt       # Copy to pod
kubectl cp mypod:/tmp/file.txt ./localfile.txt     # Copy from pod
kubectl cp mypod:/tmp/file.txt ./file.txt -c mycontainer  # Specific container
```

---

## 🏷️ Namespaces

```bash
kubectl create namespace staging            # Create namespace
kubectl get ns                              # List namespaces
kubectl config set-context --current --namespace=staging  # Set default
kubectl delete namespace staging            # Delete namespace
```

---

## 🔐 RBAC

```bash
kubectl auth can-i create pods              # Check if you can create pods
kubectl auth can-i '*' '*'                  # Check for full admin access
kubectl auth can-i get pods --as user@example.com  # Check for another user
kubectl get clusterroles                    # List cluster roles
kubectl get rolebindings -n dev             # List role bindings in namespace
```

---

## ⌨️ Useful Shortcuts & Tips

```bash
# Aliases (add to .bashrc / .zshrc)
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias klog='kubectl logs -f'
alias kexec='kubectl exec -it'

# Enable tab completion
source <(kubectl completion bash)           # Bash
source <(kubectl completion zsh)            # Zsh

# Dry-run to generate YAML
kubectl create deployment myapp --image=nginx --dry-run=client -o yaml > deploy.yaml
kubectl run mypod --image=nginx --dry-run=client -o yaml > pod.yaml
```

---

## 📚 Resources

- [kubectl Reference Docs](https://kubernetes.io/docs/reference/kubectl/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
