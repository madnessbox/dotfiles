$DotfilesRoot = "C:\dev\dotfiles"

$Links = @(
	@{ Source = "$DotfilesRoot\nvim"; Target = "$env:LOCALAPPDATA\nvim" },
	@{ Source = "$DotfilesRoot\powershell\Microsoft.PowerShell_profile.ps1"; Target = $PROFILE },
	@{ Source = "$DotfilesRoot\terminal\settings.json";
	Target = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" }
)

foreach ($link in $Links) {
	if (Test-Path $link.Target) { 
		Remove-Item $link.Target -Force -Recurs 
	}

	$TargetParent = Split-Path $link.Target -Parent
	if (-not (Test-Path $TargetParent)) {
		New-Item -ItemType Directory -Path $TargetParent | Out-Null
	}

	New-Item -ItemType SymbolicLink -Path $link.Target -Target $link.Source
	Write-Host "Linked $($link.Target) -> $($link.Source)"
}
