# ![alt text](image.png) PowerShell Useful Scripts & Commands

This document contains practical PowerShell commands and scripts for daily system, network, and file management.

---

## 📂 File and Folder Operations

### List Files in a Directory

```powershell
Get-ChildItem -Path C:\Users\YourName\Documents
```

### Copy Files Recursively

```powershell
Copy-Item -Path C:\Source -Destination C:\Backup -Recurse
```

### Remove Files Older Than 30 Days

```powershell
Get-ChildItem -Path "C:\Logs" -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } | Remove-Item
```

### Create a New Folder

```powershell
New-Item -ItemType Directory -Path "C:\NewFolder"
```

### Move Files

```powershell
Move-Item -Path C:\Temp\file.txt -Destination C:\Archive\
```

### Compare Two Files

```powershell
Compare-Object (Get-Content file1.txt) (Get-Content file2.txt)
```

### Compress Folder to ZIP

```powershell
Compress-Archive -Path C:\FolderToZip -DestinationPath C:\Archive.zip
```

### Extract ZIP File

```powershell
Expand-Archive -Path C:\Archive.zip -DestinationPath C:\ExtractedFolder
```

---

## 🖥️ System Info & Processes

### Get System Info

```powershell
Get-ComputerInfo
```

### List Running Processes

```powershell
Get-Process
```

### Kill a Process by Name

```powershell
Stop-Process -Name notepad -Force
```

### Get Service Status

```powershell
Get-Service -Name wuauserv
```

### Get CPU Info

```powershell
Get-CimInstance -ClassName Win32_Processor | Select-Object Name, NumberOfCores, MaxClockSpeed
```

### Get RAM Usage

```powershell
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object TotalVisibleMemorySize,FreePhysicalMemory
```

### Start/Stop a Service

```powershell
Start-Service -Name wuauserv
Stop-Service -Name wuauserv
```

### Restart a Service and Wait Until Running

```powershell
Restart-Service -Name wuauserv -Force
Start-Sleep -Seconds 5
Get-Service -Name wuauserv
```

### Check Disk Health (SMART)

```powershell
Get-WmiObject -Namespace root\wmi -Class MSStorageDriver_FailurePredictStatus
```

### List Mounted Drives

```powershell
Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' }
```

### Monitor CPU Usage Every 5 Seconds

```powershell
while ($true) {
    Get-Counter '\Processor(_Total)\% Processor Time'
    Start-Sleep -Seconds 5
}
```

---

## 🌐 Network Commands

### Test Network Connectivity

```powershell
Test-Connection google.com
```

### Get Local IP Address

```powershell
Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -ne "WellKnown" }
```

### Get MAC Address

```powershell
Get-NetAdapter | Select-Object Name, MacAddress
```

### Get Open TCP Ports

```powershell
Get-NetTCPConnection -State Listen
```

### Get DNS Server Addresses

```powershell
Get-DnsClientServerAddress
```

### Trace Route to Host

```powershell
Test-NetConnection -TraceRoute google.com
```

### Open a Firewall Port (TCP 8080)

```powershell
New-NetFirewallRule -DisplayName "Allow TCP 8080" -Direction Inbound -LocalPort 8080 -Protocol TCP -Action Allow
```

### Clear DNS Cache

```powershell
Clear-DnsClientCache
```

---

## 🔐 User and Security

### List Local Users

```powershell
Get-LocalUser
```

### Create a New Local User

```powershell
New-LocalUser -Name "newuser" -Password (Read-Host -AsSecureString "Enter Password") -FullName "New User" -Description "Created via PowerShell"
```

### Add User to Administrators Group

```powershell
Add-LocalGroupMember -Group "Administrators" -Member "newuser"
```

### Get Current User

```powershell
whoami
```

### Check if Current User is Admin

```powershell
([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
```

### Get Group Memberships of a User

```powershell
Get-LocalGroupMember -Group "Administrators"
```

---

## 📅 Scheduled Tasks

### List Scheduled Tasks

```powershell
Get-ScheduledTask
```

### Create a Basic Scheduled Task

```powershell
$action = New-ScheduledTaskAction -Execute "notepad.exe"
$trigger = New-ScheduledTaskTrigger -Daily -At 9am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "OpenNotepadDaily"
```

---

## 📦 Package Management

### Install a Package with Winget

```powershell
winget install Microsoft.VisualStudioCode
```

### Install PowerShell Module

```powershell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```

### Export installed packages

```powershell
winget export -o C:\packages.json
```

### Import packages on new machine

```powershell
winget import -i C:\packages.json
```

### Update all packages

```powershell
winget upgrade --all
```

---

## 🔄 Automation Examples

### Loop Through Files and Print Names

```powershell
Get-ChildItem -Path "C:\MyFolder" | ForEach-Object { Write-Host $_.Name }
```

### Run a Command on Remote Computer

```powershell
Invoke-Command -ComputerName RemotePC -ScriptBlock { Get-Process }
```

### Read a Text File Line by Line

```powershell
Get-Content -Path "C:\log.txt" | ForEach-Object { Write-Output $_ }
```

### Export Processes to CSV

```powershell
Get-Process | Export-Csv -Path "C:\processes.csv" -NoTypeInformation
```

### Schedule a Script to Run Weekly

```powershell
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Scripts\MyScript.ps1"
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 3am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "WeeklyScript"
```

---

## 🧹 Cleanup

### Empty Recycle Bin

```powershell
Clear-RecycleBin -Confirm:$false
```

### Clean Temp Files

```powershell
Remove-Item "$env:TEMP\*" -Recurse -Force
```

### Clear Event Logs

```powershell
Get-EventLog -LogName Application | ForEach-Object { Clear-EventLog -LogName $_.Log }
```

---

## 🔍 Troubleshooting and Diagnostics

### Check Disk Usage

```powershell
Get-PSDrive -PSProvider FileSystem
```

### Check Disk Space Usage on Drive C

```powershell
Get-Volume -DriveLetter C
```

### View Last 10 Event Logs from System

```powershell
Get-EventLog -LogName System -Newest 10
```

### Display Network Interface Statistics

```powershell
Get-NetAdapterStatistics
```

---

## ⏰ Timers and Delays

### Wait/Pause Script for 5 Seconds

```powershell
Start-Sleep -Seconds 5
```

### Measure Script Execution Time

```powershell
Measure-Command { Get-Process }
```

---

## 📜 Script Template

```powershell
<#
.SYNOPSIS
    Advanced script template with logging and error handling
.DESCRIPTION
    This template includes:
    - Parameter validation
    - Logging system
    - Error handling
    - Progress reporting
#>

param (
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_})]
    [string]$InputPath,
    
    [Parameter()]
    [ValidateRange(1,100)]
    [int]$Threshold = 50
)

begin {
    # Initialize logging
    $logFile = "C:\Logs\ScriptLog_$(Get-Date -Format 'yyyyMMdd').log"
    function Write-Log {
        param([string]$message)
        "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message" | Out-File $logFile -Append
        Write-Host $message
    }
    
    Write-Log "Script started with parameters: InputPath=$InputPath, Threshold=$Threshold"
}

process {
    try {
        # Main processing
        $items = Get-ChildItem -Path $InputPath -Recurse -ErrorAction Stop
        
        $i = 0
        $total = $items.Count
        $items | ForEach-Object {
            $i++
            $percent = [math]::Round(($i/$total)*100)
            Write-Progress -Activity "Processing files" -Status "$percent% Complete" -PercentComplete $percent
            
            try {
                # Your processing logic here
                if ($_.Length/1MB -gt $Threshold) {
                    Write-Log "Large file found: $($_.FullName) ($([math]::Round($_.Length/1MB,2)) MB)"
                }
            }
            catch {
                Write-Log "ERROR processing $($_.FullName): $_"
            }
        }
    }
    catch {
        Write-Log "FATAL ERROR: $_"
        throw
    }
}

end {
    Write-Log "Script completed successfully"
    Write-Progress -Activity "Processing files" -Completed
}
```

### Define a Simple Function

```powershell
function Get-Greeting {
    param([string]$Name = "User")
    "Hello, $Name!"
}
Get-Greeting -Name "Alice"
```

### Try-Catch Error Handling

```powershell
try {
    Get-Item "C:\NonExistentFile.txt"
}
catch {
    Write-Host "File not found."
}