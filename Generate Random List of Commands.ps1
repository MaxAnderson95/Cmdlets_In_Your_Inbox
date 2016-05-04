#Add which modules you'd like to be emailed about
$Modules = @(
"ActiveDirectory"
"Hyper-V"
)


[System.Collections.ArrayList]$cmdlets = get-command | Select-Object Name


$cmdlets_new = $cmdlets | Where-Object {$_.name -notmatch '[A-Z]:' -and $_.name -notlike "cd*"}

$cmdlets_new = $cmdlets_new.Name

$cmdlets_new | Sort-Object {Get-Random} | Out-File Commands_Random.txt
