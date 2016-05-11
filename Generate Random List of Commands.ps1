param (
    [switch]$Offline = $false
)

#Add which modules you'd like to be emailed about
$Modules = @(
"ActiveDirectory"
"Hyper-V"
)

#Creates the Command List in a text file
[System.Collections.ArrayList]$cmdlets = get-command -Module $Modules | Select-Object Name
$cmdlets_new = $cmdlets | Where-Object {$_.name -notmatch '[A-Z]:' -and $_.name -notlike "cd*"}
$cmdlets_new = $cmdlets_new.Name
$cmdlets_new = $cmdlets_new | Sort-Object {Get-Random}

New-Item -Path Commands_Random.txt -Force | Out-Null
Add-Content -Path .\Commands_Random.txt -Value START
Add-Content -Path .\Commands_Random.txt -Value $cmdlets_new

Write-Host "Created Comands_Random.txt from Modules: $Modules" -BackgroundColor Black -ForegroundColor Yellow


#Downloads the help files offline for the modules chosen
If ($Offline -eq $true) {   
    
    If (Test-Path .\Offline_Help_Files) {
        Remove-Item .\Offline_Help_Files -Recurse -Force
    }

    New-Item -ItemType Directory -Path .\Offline_Help_Files -Force | Out-Null

    Save-Help -Module $Modules -DestinationPath .\Offline_Help_Files -Force

    Write-Host "Downloaded offline help files for Modules: $Modules" -BackgroundColor Black -ForegroundColor Yellow

}