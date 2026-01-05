# Windows dotfiles setup script
# This script installs configuration files to their appropriate locations
# Usage: .\setup.ps1 [-Packages]

param(
    [switch]$Packages = $false,
    [switch]$Help = $false
)

$ErrorActionPreference = "Stop"

# Help message
if ($Help) {
    Write-Host "Usage: .\setup.ps1 [OPTIONS]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Packages    Install packages (requires package manager like Chocolatey or Scoop)"
    Write-Host "  -Help        Show this help message"
    exit 0
}

# Setup paths
$DOTFILES_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$CONFIG_DIR = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } else { "$env:USERPROFILE\.config" }
$APPDATA = $env:APPDATA
$LOCALAPPDATA = $env:LOCALAPPDATA

# Create config directory if needed
if (-not (Test-Path $CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $CONFIG_DIR -Force | Out-Null
}

Write-Host "Installing dotfiles from $DOTFILES_DIR..."
Write-Host "Detected OS: Windows"
Write-Host ""

# Function to check and install script dependencies
function Test-Dependencies {
    $scriptDependencies = @("git")
    $missingDeps = @()
    
    Write-Host "[*] Checking script dependencies..."
    
    foreach ($dep in $scriptDependencies) {
        if (Get-Command $dep -ErrorAction SilentlyContinue) {
            Write-Host "[+] Found: $dep"
        } else {
            Write-Host "[!] Missing dependency: $dep"
            $missingDeps += $dep
        }
    }
    
    if ($missingDeps.Count -gt 0) {
        Write-Host "[X] Error: Missing dependencies: $($missingDeps -join ', ')"
        Write-Host "Please install the missing dependencies manually."
        return $false
    }
    
    Write-Host "[+] All dependencies found"
    Write-Host ""
    return $true
}

# Function to install packages (basic support for Chocolatey)
function Install-Packages {
    if (-not $Packages) {
        Write-Host "Package installation disabled. Use -Packages to enable."
        return
    }
    
    Write-Host "[*] Installing packages..."
    Write-Host ""
    
    # Check if Chocolatey is installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Chocolatey not found. Skipping package installation."
        Write-Host "    Install from: https://chocolatey.org/install"
        return
    }
    
    Write-Host "[*] Installing packages with Chocolatey..."
    
    $packages = @("neovim", "python3", "git", "vim", "cmake", "ripgrep")
    
    foreach ($package in $packages) {
        try {
            choco install -y $package
            Write-Host "[+] Installed: $package"
        } catch {
            Write-Host "[!] Failed to install: $package"
        }
    }
    
    Write-Host ""
}

# Function to initialize git global settings
function Initialize-GitConfig {
    Write-Host ""
    Write-Host "[*] Configuring Git..."
    
    # Check if git is installed
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Git is not installed. Skipping Git configuration."
        return
    }
    
    # Get current git config values
    $currentUser = git config --global user.name
    $currentEmail = git config --global user.email
    
    # If already configured, display current settings
    if ($currentUser -and $currentEmail) {
        Write-Host "[+] Git already configured:"
        Write-Host "    Name:  $currentUser"
        Write-Host "    Email: $currentEmail"
        return
    }
    
    Write-Host "Git configuration needed:"
    $gitName = Read-Host "Enter git user name (or press Enter to skip)"
    
    if (-not $gitName) {
        Write-Host "[!] Git user name not provided. Skipping Git configuration."
        return
    }
    
    $gitEmail = Read-Host "Enter git email"
    
    if (-not $gitEmail) {
        Write-Host "[!] Git email not provided. Skipping Git configuration."
        return
    }
    
    # Set global git config
    git config --global user.name $gitName
    git config --global user.email $gitEmail
    
    Write-Host "[+] Git configured:"
    Write-Host "    Name:  $gitName"
    Write-Host "    Email: $gitEmail"
}

# Function to sync configuration folder
function Sync-ConfigFolder {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$ConfigName
    )
    
    if (-not (Test-Path $Source -PathType Container)) {
        Write-Host "[!] Source folder not found: $Source"
        return $false
    }
    
    # Create destination directory if needed
    if (-not (Test-Path $Destination)) {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }
    
    # Special handling for SSH (permissions)
    if ($ConfigName -eq "ssh") {
        Copy-Item -Path "$Source\*" -Destination $Destination -Recurse -Force
        Write-Host "[+] Synced: $Destination (SSH keys copied)"
        return $true
    }
    
    # Standard copy for other configs
    Copy-Item -Path "$Source\*" -Destination $Destination -Recurse -Force
    Write-Host "[+] Synced: $Destination"
    return $true
}

# Check dependencies first
if (-not (Test-Dependencies)) {
    exit 1
}

# Install packages if requested
Install-Packages

# Configuration list for Windows
# Format: @{name="folder_name"; dest="path"}
$configList = @(
    @{name = "bash"; dest = "$CONFIG_DIR\bash"}
    @{name = "nvim"; dest = "$CONFIG_DIR\nvim"}
    @{name = "wezterm"; dest = "$CONFIG_DIR\wezterm"}
    @{name = "git"; dest = "$CONFIG_DIR\git"}
    @{name = "fonts"; dest = "$env:USERPROFILE\.fonts"}
    @{name = "ssh"; dest = "$env:USERPROFILE\.ssh"}
)

# Process configuration list
Write-Host ""
Write-Host "[*] Setting up configuration folders..."
Write-Host ""

foreach ($config in $configList) {
    $source = Join-Path $DOTFILES_DIR $config.name
    $dest = $config.dest
    
    if (Test-Path $source -PathType Container) {
        Sync-ConfigFolder -Source $source -Destination $dest -ConfigName $config.name
    } else {
        Write-Host "[!] Skipped $($config.name) (folder not found)"
    }
}

Write-Host ""

# Initialize git global settings
Initialize-GitConfig

# Setup shell rc files in home directory
Write-Host ""
Write-Host "[*] Setting up shell rc files..."

# Bash RC
$bashrcSource = Join-Path $DOTFILES_DIR "bash\.bashrc"
$bashrcDest = "$env:USERPROFILE\.bashrc"

if (Test-Path $bashrcSource) {
    if (Test-Path $bashrcDest) {
        Move-Item -Path $bashrcDest -Destination "$bashrcDest.bak" -Force
    }
    Copy-Item -Path $bashrcSource -Destination $bashrcDest -Force
    Write-Host "[+] Copied: $bashrcDest"
} else {
    Write-Host "[!] .bashrc not found"
}

# Bash profile
$bashProfileSource = Join-Path $DOTFILES_DIR "bash\.bash_profile"
$bashProfileDest = "$env:USERPROFILE\.bash_profile"

if (Test-Path $bashProfileSource) {
    if (Test-Path $bashProfileDest) {
        Move-Item -Path $bashProfileDest -Destination "$bashProfileDest.bak" -Force
    }
    Copy-Item -Path $bashProfileSource -Destination $bashProfileDest -Force
    Write-Host "[+] Copied: $bashProfileDest"
}

# Bash logout
$bashLogoutSource = Join-Path $DOTFILES_DIR "bash\.bash_logout"
$bashLogoutDest = "$env:USERPROFILE\.bash_logout"

if (Test-Path $bashLogoutSource) {
    if (Test-Path $bashLogoutDest) {
        Move-Item -Path $bashLogoutDest -Destination "$bashLogoutDest.bak" -Force
    }
    Copy-Item -Path $bashLogoutSource -Destination $bashLogoutDest -Force
    Write-Host "[+] Copied: $bashLogoutDest"
}

Write-Host ""
Write-Host "[OK] Dotfiles installation complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Review copied files if needed"
Write-Host "2. Restart your applications to load new configs"
Write-Host ""
