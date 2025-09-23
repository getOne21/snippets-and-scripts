# Dapr: Distributed Application Runtime

Dapr is a **portable runtime** for building **microservices** with event-driven and service-to-service communication.

---

## 🌍 Why Dapr?

- Abstracts service discovery, pub/sub, state management  
- Works with any language and framework  
- Runs on Kubernetes or self-hosted

---

## 🚀 Install Dapr CLI

```bash
brew install dapr/tap/dapr-cli    # macOS
choco install dapr-cli            # Windows
```

Initialize locally:

```bash
dapr init
```

---

## 📦 Run an App with Dapr

```bash
dapr run --app-id myapp --app-port 5000 dotnet run
```

Dapr sidecar listens on:

- HTTP: `http://localhost:3500`
- gRPC: `localhost:50001`

---

## ☁️ Deploy to Kubernetes

```bash
dapr init -k
kubectl apply -f deploy/myapp.yaml
```

Example sidecar annotation:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  template:
    metadata:
      annotations:
        dapr.io/enabled: "true"
        dapr.io/app-id: "myapp"
        dapr.io/app-port: "5000"
```

---

## ✅ Summary

- Dapr provides **service-to-service calls, pub/sub, state stores**  
- Works great on **AKS** for cloud-native apps  
- Polyglot friendly → .NET, Java, Go, Node.js, etc.  
