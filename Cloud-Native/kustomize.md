# Kustomize: Overlay-Based Kubernetes Config Management

Kustomize lets you customize raw, template-free Kubernetes YAML files with **overlays**.

---

## ⚡ Why Kustomize?

- Patch configs for different environments (dev/test/prod)  
- No templating language needed  
- Integrated into `kubectl`

---

## 📂 Folder Structure

```text
base/
 ├─ deployment.yaml
 └─ service.yaml
overlays/
 ├─ dev/
 │   └─ kustomization.yaml
 └─ prod/
     └─ kustomization.yaml
```

---

## Example: Base `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 1
```

## Example: Overlay `kustomization.yaml`

```yaml
resources:
  - ../../base

patches:
  - target:
      kind: Deployment
      name: myapp
    patch: |-
      - op: replace
        path: /spec/replicas
        value: 3
```

---

## 🚀 Apply Overlay

```bash
kubectl apply -k overlays/dev
kubectl apply -k overlays/prod
```

---

## ✅ Summary

- **Base** → common configs  
- **Overlays** → environment-specific changes  
- Use with **kubectl -k** for native support  
