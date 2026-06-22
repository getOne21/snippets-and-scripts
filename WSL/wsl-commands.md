# 🐧 WSL & Linux CLI Commands

> Essential Windows Subsystem for Linux commands and common Linux CLI operations for Windows developers.

---

## 📦 WSL Installation & Management

```powershell
# Install WSL (PowerShell as Admin)
wsl --install                               # Install default distro (Ubuntu)
wsl --install -d Ubuntu-24.04               # Install specific distro
wsl --list --online                         # List available distros

# Management
wsl --list --verbose                        # List installed distros with status
wsl --set-default Ubuntu                    # Set default distro
wsl --set-version Ubuntu 2                  # Convert distro to WSL 2
wsl --set-default-version 2                 # Set WSL 2 as default for new distros

# Start / Stop
wsl                                         # Launch default distro
wsl -d Ubuntu                               # Launch specific distro
wsl --shutdown                              # Shut down all WSL instances
wsl --terminate Ubuntu                      # Terminate specific distro

# Update & Status
wsl --update                                # Update WSL kernel
wsl --status                                # Show WSL configuration & status
wsl --version                               # Show WSL version info

# Import / Export
wsl --export Ubuntu ./ubuntu-backup.tar     # Export distro to tar
wsl --import MyUbuntu C:\wsl\MyUbuntu .\ubuntu-backup.tar  # Import from tar
wsl --unregister Ubuntu                     # Remove a distro (deletes all data!)
```

---

## 📁 File System Navigation

```bash
ls                                  # List files
ls -la                              # List all files (incl. hidden) with details
ls -lh                              # Human-readable file sizes
ls -lt                              # Sort by modification time

cd /home/user                       # Change directory
cd ~                                # Go to home directory
cd -                                # Go to previous directory
pwd                                 # Print current directory

tree                                # Show directory structure (install: apt install tree)
tree -L 2                           # Limit depth to 2 levels
```

---

## 📄 File Operations

```bash
# Create
touch file.txt                      # Create empty file
mkdir mydir                         # Create directory
mkdir -p parent/child/deep          # Create nested directories

# Copy, Move, Rename
cp file.txt copy.txt                # Copy file
cp -r dir1 dir2                     # Copy directory recursively
mv file.txt newname.txt             # Rename / move file
mv file.txt /other/path/            # Move to another directory

# Delete
rm file.txt                         # Delete file
rm -rf mydir                        # Delete directory recursively (use carefully!)

# View / Read
cat file.txt                        # Print file contents
less file.txt                       # Paginated view (q to quit)
head -n 20 file.txt                 # First 20 lines
tail -n 20 file.txt                 # Last 20 lines
tail -f logfile.log                 # Follow file changes in real-time
wc -l file.txt                     # Count lines
```

---

## 🔍 Search & Find

```bash
# Find files
find . -name "*.txt"                # Find by name
find . -type f -size +10M           # Find files larger than 10MB
find . -mtime -7                    # Modified in last 7 days
find . -name "*.log" -delete        # Find and delete

# Search content
grep "pattern" file.txt             # Search in file
grep -r "pattern" ./src             # Recursive search in directory
grep -rn "pattern" ./src            # With line numbers
grep -ri "pattern" ./src            # Case-insensitive
grep -rl "pattern" ./src            # List files with matches only

# ripgrep (faster alternative, install: apt install ripgrep)
rg "pattern"                        # Search in current directory
rg "pattern" -t py                  # Search only Python files
rg "pattern" -l                     # List files only
```

---

## 🔐 Permissions & Ownership

```bash
# View permissions
ls -la                              # Shows permissions like -rwxr-xr-x

# Change permissions
chmod +x script.sh                  # Make executable
chmod 755 script.sh                 # rwxr-xr-x
chmod 644 file.txt                  # rw-r--r--
chmod -R 755 mydir                  # Recursive

# Change ownership
sudo chown user:group file.txt      # Change owner and group
sudo chown -R user:group mydir      # Recursive
```

---

## ⚙️ Process Management

```bash
ps aux                              # List all processes
ps aux | grep node                  # Find specific processes
top                                 # Interactive process viewer
htop                                # Better process viewer (install: apt install htop)

kill <PID>                          # Terminate process by PID
kill -9 <PID>                       # Force kill
killall node                        # Kill all processes by name
pkill -f "pattern"                  # Kill by pattern match

# Background processes
command &                           # Run in background
jobs                                # List background jobs
fg %1                               # Bring job 1 to foreground
bg %1                               # Resume job 1 in background
nohup command &                     # Run even after terminal closes
```

---

## 🌐 Networking

```bash
# Connection info
ip addr show                        # Show IP addresses
hostname -I                         # Quick IP address
curl ifconfig.me                    # Public IP

# DNS & Connectivity
ping google.com                     # Test connectivity
nslookup example.com                # DNS lookup
dig example.com                     # Detailed DNS query

# Ports & Connections
ss -tulnp                           # Show listening ports
netstat -tulnp                      # Alternative (older)
lsof -i :8080                       # What's using port 8080

# Download
wget https://example.com/file.zip   # Download a file
curl -O https://example.com/file.zip  # Download with curl
```

---

## 📦 Package Management (Ubuntu/Debian)

```bash
sudo apt update                     # Update package index
sudo apt upgrade                    # Upgrade all packages
sudo apt install <package>          # Install a package
sudo apt remove <package>           # Remove a package
sudo apt autoremove                 # Remove unused dependencies
apt search <keyword>                # Search for packages
apt list --installed                # List installed packages
dpkg -l | grep <package>            # Check if package is installed
```

---

## 🔄 Piping & Redirection

```bash
# Piping (pass output to next command)
cat file.txt | grep "pattern"       # Search in output
ps aux | sort -k4 -rn | head       # Top memory-consuming processes
ls -la | wc -l                      # Count files

# Redirection
command > file.txt                  # Overwrite file with output
command >> file.txt                 # Append to file
command 2> error.log                # Redirect stderr
command > out.log 2>&1              # Redirect both stdout and stderr
command < input.txt                 # Use file as input
```

---

## 📦 Compression & Archives

```bash
# tar
tar -czf archive.tar.gz mydir      # Create gzipped archive
tar -xzf archive.tar.gz            # Extract gzipped archive
tar -tf archive.tar.gz             # List contents

# zip
zip -r archive.zip mydir           # Create zip archive
unzip archive.zip                  # Extract zip
unzip -l archive.zip               # List contents
```

---

## 🔗 WSL ↔ Windows Interop

```bash
# Access Windows files from WSL
cd /mnt/c/Users/username/Documents  # Access C: drive

# Access WSL files from Windows
# Navigate to: \\wsl$\Ubuntu\home\username

# Run Windows commands from WSL
explorer.exe .                      # Open current dir in Windows Explorer
notepad.exe file.txt                # Open file in Notepad
cmd.exe /c dir                      # Run Windows cmd command
powershell.exe -c "Get-Process"     # Run PowerShell command

# Run WSL commands from Windows (PowerShell)
wsl ls -la                          # Run Linux command from Windows
wsl -e bash -c "echo hello"        # Execute and return
```

---

## 💡 Useful Aliases (add to `~/.bashrc` or `~/.zshrc`)

```bash
alias ll='ls -la'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias ports='ss -tulnp'
alias myip='curl -s ifconfig.me'
alias update='sudo apt update && sudo apt upgrade -y'
alias grep='grep --color=auto'
```

After editing, reload with:

```bash
source ~/.bashrc
```

---

## 📚 Resources

- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/)
- [Ubuntu Command Reference](https://manpages.ubuntu.com/)
- [Linux Command Cheat Sheet](https://www.linuxtrainingacademy.com/linux-commands-cheat-sheet/)
