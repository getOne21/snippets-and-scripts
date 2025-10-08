# Oh My Posh – PowerShell Setup on Windows

Beautiful and customizable prompt for PowerShell and Windows Terminal using Oh My Posh.

---

## 🚀 Installation Guide (PowerShell on Windows)

### 🧰 Prerequisites

- Windows 10/11
- PowerShell (≥ 7 recommended)
- Windows Terminal (recommended)

---

### 🛠 Step 1: Install Oh My Posh

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

---

### 🖋 Step 2: Install Nerd Fonts (MesloLGS Recommended)

```powershell
# Download MesloLGS Nerd Font
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
$zipPath = "$env:TEMP\Meslo.zip"
$extractPath = "$env:TEMP\MesloFont"
$fontDir = "C:\Windows\Fonts"
$fontsRegPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

# Self-elevate if not running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Restarting as administrator..."
    $newProcess = Start-Process -FilePath "powershell.exe" `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs -WindowStyle Normal -PassThru
    $newProcess.WaitForExit()
    exit
}

Write-Host "Downloading MesloLGS Nerd Font..."
Invoke-WebRequest -Uri $fontUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive $zipPath -DestinationPath $extractPath -Force

# Function to install and register system-wide fonts
function Install-FontSystemWide {
    param([string]$fontPath)

    $fontName = Split-Path $fontPath -Leaf
    $destPath = Join-Path $fontDir $fontName

    # Copy the font to the system fonts folder
    if (-not (Test-Path $fontDir)) {
        Write-Host "Creating $fontDir ..."
        New-Item -ItemType Directory -Path $fontDir -Force | Out-Null
    }

    Copy-Item -Path $fontPath -Destination $destPath -Force
    Write-Host "Copied: $fontName"

    # Register font in registry for all users
    New-ItemProperty -Path $fontsRegPath -Name $fontName -Value $fontName -PropertyType String -Force | Out-Null
    Write-Host "Registered: $fontName"
}

# Install all TTF files
$fontFiles = Get-ChildItem -Path $extractPath -Filter "*.ttf" -Recurse
foreach ($font in $fontFiles) {
    Install-FontSystemWide $font.FullName
}

# Refresh font cache
Add-Type -AssemblyName PresentationCore
[System.Windows.Media.Fonts]::SystemFontFamilies | Out-Null

Write-Host "`n✅ Meslo Nerd Fonts installed system-wide successfully!"
Write-Host "➡️  You can now select 'MesloLGS Nerd Font' in Windows Terminal."

```

---

### 🎨 Step 3: Set Font in Windows Terminal

1. Open Windows Terminal settings (Ctrl + ,)
2. Choose your PowerShell profile
3. Set `Font face` to: `MesloLGS NF`

---

### 📜 Step 4: Enable Oh My Posh in PowerShell Profile

```powershell
# Optional: Find the default theme path
$env:POSH_THEMES_PATH

# Add this to your PowerShell profile
notepad $PROFILE

# Load Profile
. $PROFILE
```

Paste this into your profile file:

```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
```

Save and restart the terminal.

---

## 🧩 Useful Commands

| Command | Description |
|--------|-------------|
| `oh-my-posh init pwsh --config "..."` | Initialize prompt with a custom theme |
| `Get-PoshThemes` | List all available themes |
| `Set-PoshPrompt -Theme jandedobbeleer` | Preview/set a theme temporarily |
| `notepad $PROFILE` | Open your PowerShell profile for editing |
| `oh-my-posh --version` | Show the installed version |
| `oh-my-posh config export` | Export current config to a `.omp.json` |
| `oh-my-posh config edit` | Edit the theme config with GUI (if installed) |

---

## 🎨 Theme Customization

You can copy any theme JSON from `$env:POSH_THEMES_PATH`, modify it, and reference your version:

```powershell
# Example:
oh-my-posh init pwsh --config "$HOME\my-custom.omp.json" | Invoke-Expression
```

To create your own prompt segments (e.g., disk usage, Git info, etc.), edit the JSON using:

- [Segment reference](https://ohmyposh.dev/docs/segments/cli/angular)
- [Themes](https://ohmyposh.dev/docs/themes)

---
