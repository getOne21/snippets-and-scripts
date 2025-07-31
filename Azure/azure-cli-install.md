# ☁️ Azure CLI – Installation Guide

The Azure Command-Line Interface (CLI) is a set of commands used to create and manage Azure resources.

---

## 🖥️ Windows

### Install using MSI

1. Download the installer:  
   [Azure CLI for Windows (MSI)](https://aka.ms/installazurecliwindows)

2. Run the installer and follow the setup wizard.

3. Verify installation:

```powershell
az version
```

---

## 🐧 Linux

### Ubuntu/Debian

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### RHEL/CentOS/Fedora

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf install https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
sudo dnf install azure-cli
```

### Other Distributions

Refer to the full instructions for your distro:  
[https://learn.microsoft.com/cli/azure/install-azure-cli](https://learn.microsoft.com/cli/azure/install-azure-cli)

---

## 🍎 macOS

### Using Homebrew

```bash
brew update && brew install azure-cli
```

---

## 🐳 Docker

Run Azure CLI in an isolated container:

```bash
docker run -it mcr.microsoft.com/azure-cli
```

---

## 📥 Upgrade Azure CLI

- **Windows:** Re-run the MSI installer.
- **macOS/Linux:** Run the installer again or:

```bash
az upgrade
```

---

## 🔐 Login to Azure

```bash
az login
```

Use `az login --use-device-code` if you're in a restricted browser environment.

---

## 📚 Resources

- [Official Docs](https://learn.microsoft.com/cli/azure/)
- [Install Guide](https://learn.microsoft.com/cli/azure/install-azure-cli)
- [Command Reference](https://learn.microsoft.com/cli/azure/reference-index)

---