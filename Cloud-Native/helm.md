# Helm: Package Kubernetes Apps

Helm is a **package manager for Kubernetes** that simplifies deployment and management of applications.

---

## 📦 Why Helm?

- Package apps as reusable **charts**
- Manage complex manifests with **templates**
- Easy upgrades and rollbacks

---

## 🚀 Install Helm

```bash
choco install kubernetes-helm   # Windows
brew install helm               # macOS
```

---

## 📂 Create a Chart

```bash
helm create myapp
```

This generates:

```text
myapp/
 ├─ charts/
 ├─ templates/
 ├─ values.yaml
 └─ Chart.yaml
```

---

## ⚡ Deploy App with Helm

```bash
helm install myapp ./myapp --namespace dev
```

Upgrade after changes:

```bash
helm upgrade myapp ./myapp
```

Rollback:

```bash
helm rollback myapp 1
```

---

## ✅ Summary

- Helm packages apps into **charts**  
- Supports upgrades and rollbacks  
- Works great for **AKS** and multi-environment deployments  
