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