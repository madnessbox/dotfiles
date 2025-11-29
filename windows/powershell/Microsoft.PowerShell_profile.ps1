# Prompt
Import-Module posh-git

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'spaceship.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -Colors @{ "InlinePrediction" = '#767676' }
Set-PSReadLineOption -Colors @{ "Parameter" = '#5F87D7' }

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias functions
function get-gitstatus { git status }

# Alias
Set-Alias vim nvim
Set-Alias ll ls -Force
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias touch ni
Set-Alias lg lazygit
Set-Alias -Name gs -Value get-gitstatus

function rm {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    $Path = @()
    $Recurse = $false
    $Force = $false
    
    # Parse arguments
    foreach ($arg in $Arguments) {
        if ($arg -match '^-') {
            # Handle combined flags like -rf, -fr, etc.
            if ($arg -match 'r') { $Recurse = $true }
            if ($arg -match 'f') { $Force = $true }
        } else {
            $Path += $arg
        }
    }
    
    # Build Remove-Item parameters
    $params = @{ Path = $Path }
    if ($Recurse) { $params.Recurse = $true }
    if ($Force) { $params.Force = $true }
    
    Remove-Item @params
}

# Ensure the terminal font supports Icons
$fontSupported = (Get-Command oh-my-posh).Module | Select-Object -ExpandProperty Version -ErrorAction SilentlyContinue
if (-not $fontSupported)
{
  Write-Warning "Ensure your terminal font supports icons."
}

