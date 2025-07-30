# Install oh-my-posh via winget
winget install JanDeDobbeleer.OhMyPosh -s winget

# Download and install MesloLGS Nerd Font (most popular for terminals)
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
$zipPath = "$env:TEMP\Meslo.zip"
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

Invoke-WebRequest -Uri $fontUrl -OutFile $zipPath
Expand-Archive $zipPath -DestinationPath $env:TEMP\MesloFont -Force
$fontFiles = Get-ChildItem -Path "$env:TEMP\MesloFont" -Filter "*.ttf" -Recurse

foreach ($font in $fontFiles) {
    Copy-Item $font.FullName -Destination $fontDir -Force
    Write-Output "Installed: $($font.Name)"
}

# Register fonts for current user (optional for Windows 10/11, but ensures instant availability)
$fonts = Get-ChildItem "$fontDir\Meslo*.ttf"
foreach ($font in $fonts) {
    $null = Add-Type -AssemblyName PresentationCore
    $fontName = $font.FullName
    $fontObj = New-Object System.Windows.Media.FontFamily($fontName)
}

Write-Host "`nMesloLGS Nerd Font installed. Set it in your Terminal profile for best Oh My Posh experience!"
