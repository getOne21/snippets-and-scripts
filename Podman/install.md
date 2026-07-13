# 🦭 Podman – Install Guide

## 🛠️ Installation on Windows

### Option 1 – Podman Desktop (GUI + CLI)

1. Download from: [https://podman-desktop.io/](https://podman-desktop.io/)
2. Run the installer.
3. Podman Desktop bundles the Podman CLI, so no separate CLI install is needed.
4. On first launch, use the built-in setup wizard to install and initialize the Podman Machine (WSL 2 backend).

> Podman Desktop also lets you manage Kubernetes manifests, images, volumes, and extensions from a single UI.

---

### Option 2 – Podman CLI Only (via Winget or Chocolatey)

**Winget:**

```powershell
winget install RedHat.Podman
```

**Chocolatey:**

```powershell
choco install podman-desktop   # includes CLI
# or CLI only:
choco install podman
```

---

## ⚙️ Initialize the Podman Machine (WSL 2)

Podman on Windows runs containers inside a lightweight Linux VM called a *Podman Machine*.

```powershell
podman machine init          # Create the default machine
podman machine start         # Start the machine
podman machine ls            # List machines and their status
```

---

## ✅ Verify Installation

```powershell
podman --version
podman info
podman run hello-world
```

---

## 🔄 Podman Desktop vs Podman CLI

| Feature | Podman Desktop | Podman CLI |
|---|---|---|
| Graphical UI | ✅ Yes | ❌ No |
| Image management | ✅ Visual | ✅ Commands |
| Container management | ✅ Visual | ✅ Commands |
| Kubernetes support | ✅ Built-in | 🔧 Manual |
| Extensions | ✅ Yes | ❌ No |
| Docker compatibility mode | ✅ Toggle | ✅ Alias |
| Rootless by default | ✅ Yes | ✅ Yes |

> **Tip:** Podman Desktop includes a Docker compatibility toggle that creates a `docker.sock` socket, so existing Docker Compose files and tooling work without changes.
