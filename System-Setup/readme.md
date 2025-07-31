# 🚀 System Setup Script

This guide provides a one-shot setup script to provision a new Windows development machine using Chocolatey, Docker, VS Code, Oh My Posh, Git, and other essentials.

---

## 📦 Prerequisites

- Windows 10/11
- PowerShell (Run as Administrator)
- Internet Connection

---

## ▶️ Quick Start

> Run this script in **PowerShell as Administrator**:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force

# Download and run the bootstrap script
Invoke-WebRequest -Uri "https://github.com/getOne21/snippets-and-scripts/blob/main/System-Setup/Scripts/initial.ps1" -OutFile "system-setup-install.ps1"
.initial.ps1
```

---

## 🛠️ What the Script Does

1. Installs **Chocolatey**
2. Installs essential packages:
    - Git
    - Docker Desktop
    - VS Code
    - 7zip
    - Oh My Posh
    - Windows Terminal
    - Node.js
    - .NET SDK
    - Sql Server Management Studio
    - Insomnia
    - VS 2022 Enterprise
3. Sets up fonts for Oh My Posh

---

## 📜 `Initial.ps1`

```powershell
# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install packages git, docker, vscide, omp, 7zip, windows terminal, nodejs, dotnet sdk
choco install git vscode docker-desktop oh-my-posh 7zip windows-terminal nodejs dotnet-sdk -y

# Oh My Posh font setup (Meslo Nerd Font)
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip" -OutFile "$env:TEMP\Meslo.zip"
Expand-Archive "$env:TEMP\Meslo.zip" -DestinationPath "$env:TEMP\MesloFonts"
Copy-Item "$env:TEMP\MesloFonts\*.ttf" -Destination "$env:WINDIR\Fonts"

# Development Tools
choco install visualstudio2022enterprise --package-parameters "--passive --includeRecommended -includeOptional" -y
choco install sql-server-management-studio -y
choco install insomnia-rest-api-client -y

```

---

## 🧼 Notes

- Ensure virtualization is enabled for Docker
- Restart required after font install
- Customize as needed per team or project

---
