# Windows dotfiles setup script
# This script installs configuration files to their appropriate locations
# Usage: .\setup.ps1

$ErrorActionPreference = "Stop"

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

# Function to prompt for optional package installation
function Invoke-PackageInstallationPrompt {
    Write-Host "[*] Package installation is optional."
    $installChoice = Read-Host "Would you like to install recommended packages? (y/n)"
    
    if ($installChoice -ne "y" -and $installChoice -ne "Y") {
        Write-Host "[*] Skipping package installation."
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
    
    $packages = @("neovim", "python3", "git", "vim", "cmake", "ripgrep", "lua", "nodejs")
    
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
# Function to sync configuration folder
function Invoke-ConfigurationSync {
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
    
    # Copy configuration
    Copy-Item -Path "$Source\*" -Destination $Destination -Recurse -Force
    Write-Host "[+] Synced: $Destination"
    return $true
}

# Prompt for optional package installation
Invoke-PackageInstallationPrompt


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

# Configuration list for Windows
# Format: @{name="folder_name"; dest="path"}
$configList = @(
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
        Invoke-ConfigurationSync -Source $source -Destination $dest -ConfigName $config.name
    } else {
        Write-Host "[!] Skipped $($config.name) (folder not found)"
    }
}

Write-Host ""
Write-Host "[OK] Dotfiles installation complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Review copied files if needed"
Write-Host "2. Restart your applications to load new configs"
Write-Host ""
