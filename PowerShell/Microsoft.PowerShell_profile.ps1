# Custom Aliases and Functions
Set-Alias -Name .. -Value 'cd ..'
Set-Alias -Name grep -Value 'findstr'
Set-Alias -Name vim -Value 'nvim'
Set-Alias -Name cls -Value 'Clear-Host'
Set-Alias -Name clr -Value 'Clear-Host'

# Remove default ls alias to allow custom function to override it
Remove-Alias -Name ls -Force -ErrorAction SilentlyContinue

# Functions with parameters (can't be simple aliases)
function ls { lsd --color auto --human-readable --group-directories-first --sort extension @args }
function la { lsd --color auto --human-readable --group-directories-first --sort extension --almost-all @args }
function ll { lsd --color auto --human-readable --group-directories-first --sort extension --almost-all --long @args }
function lt { lsd --color auto --human-readable --group-directories-first --sort extension --almost-all --tree @args }

# Git branch in prompt
function __ps1_git_branch {
    try {
        $branch = & git rev-parse --abbrev-ref HEAD 2>$null
        if ($null -ne $branch -and $branch -ne "HEAD") {
            Write-Host " (" -NoNewline -ForegroundColor Cyan
            Write-Host $branch -NoNewline -ForegroundColor Yellow
            Write-Host ")" -NoNewline -ForegroundColor Cyan
        }
    } catch {
        # Silently ignore git errors
    }
}

# Custom Prompt
function prompt {
    Write-Host "`n┌─[" -NoNewline -ForegroundColor Cyan
    Write-Host $env:USERNAME -NoNewline -ForegroundColor Green
    Write-Host "@" -NoNewline -ForegroundColor Cyan
    Write-Host $env:COMPUTERNAME -NoNewline -ForegroundColor Green
    Write-Host "] " -NoNewline -ForegroundColor Cyan
    Write-Host (Get-Location) -ForegroundColor Magenta
    __ps1_git_branch
    Write-Host "`n└─> " -NoNewline -ForegroundColor Cyan
    return " "
}

function cds
{
	param($dirname)
	fd -td --max-results=1 $dirname | cd
}

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv

cls

if (Get-Command neofetch -ErrorAction SilentlyContinue) {
    neofetch
}
