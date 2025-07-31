# 🍫 Chocolatey Package Manager

Chocolatey is a Windows package manager that makes it easy to install and manage software from the command line.

---

## 🛠️ Installation

> Run in **PowerShell as Administrator**:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Verify installation:

```powershell
choco --version
```

---

## 🎯 Useful Chocolatey Commands

### Search for a package

```powershell
choco search <packageName>
```

### Install a package

```powershell
choco install <packageName> -y
```

Example:

```powershell
choco install vscode -y
```

### Upgrade a package

```powershell
choco upgrade <packageName> -y
```

### Upgrade all packages

```powershell
choco upgrade all -y
```

### Uninstall a package

```powershell
choco uninstall <packageName> -y
```

---

## 📋 List installed packages

```powershell
choco list --local-only
```

---

## 🧰 Install multiple packages from a script

```powershell
choco install git vscode googlechrome 7zip -y
```

---

## 📂 Install Chocolatey packages from a `.config` file

Create `packages.config`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="git" />
  <package id="vscode" />
  <package id="7zip" />
</packages>
```

Then run:

```powershell
choco install packages.config -y
```

---

## 🧽 Cleanup

```powershell
choco clean
```

---

## 🔐 Enable Chocolatey FOSS license acceptance

```powershell
choco feature enable -n=allowGlobalConfirmation
```

---

## 📎 Notes

- Chocolatey requires **PowerShell 2.0+** and **.NET Framework 4+**
- Always run installs with **Admin rights**
- Combine Chocolatey with **Boxstarter** for automating full machine setups

---

## 📁 Custom Chocolatey Config Folder

Set a custom location for Chocolatey packages:

```powershell
choco config set cacheLocation "D:\ChocoCache"
```

---

## 📡 Proxy Configuration

If you're behind a corporate proxy:

```powershell
choco config set proxy http://proxy.company.com:8080
choco config set proxyUser yourUsername
choco config set proxyPassword yourPassword
```

---

## 📌 Pin Package Version

Prevent a package from being updated:

```powershell
choco pin add -n=<packageName>
choco pin remove -n=<packageName>
```

---

## 🧪 Test Package Installation Without Installing

```powershell
choco install <packageName> --whatif
```

---

## 📝 Export Installed Packages

Export list to reinstall later:

```powershell
choco list --local-only --exact > choco-packages.txt
```

---

## 🔄 Reinstall a Package

```powershell
choco install <packageName> --force
```

---

## 🚀 Use Chocolatey GUI

Install a visual interface for managing packages:

```powershell
choco install chocolateygui -y
```

Launch GUI:

```powershell
chocolateygui
```

---

## 🧪 Check for Package Outdated

```powershell
choco outdated
```

---

## 🧰 Create Your Own Package (Quick Start)

```powershell
choco new mypackage
cd mypackage
notepad mypackage.nuspec
```

Then install locally:

```powershell
choco pack
choco install mypackage -s .
```

---
