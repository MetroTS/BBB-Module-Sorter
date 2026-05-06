#elevation script by claude -- not my work

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSScriptRoot\init.ps1`"" -Verb RunAs
    exit
}


#config
configure automation
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -StartWhenAvailable `
    -Hidden

$trigger = New-ScheduledTaskTrigger -Daily -At "02:00" # <-- configure at which time it fires here!
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -NonInteractive -File `"$PSScriptRoot\ModulSorter.ps1`""

#automation gets registered
Register-ScheduledTask -TaskName "FileSort" `
    -TaskName "FileSort" `
    -Trigger $trigger `
    -Action $action `
    -RunLevel Highest `
    -Settings $settings `
    -Force