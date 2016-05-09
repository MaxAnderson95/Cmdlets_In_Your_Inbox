#Change These Variables:
$Path_To_Files = "C:\temp\Cmdlets_In_Your_Inbox"
$SMTP_Server = "smtp.contoso.com"
$To = "you@contoso.com"


#Prevents the script from running if it's the weekend
If ((Get-Date).DayOfWeek -eq "Saturday" -or (Get-Date).DayOfWeek -eq "Sunday") {
 Exit
}

#Gets a list of all commands in a random order that was already generated earlier and places them in an array
$Commands = Get-Content "$Path_To_Files\Commands_Random.txt"

#Checks to see if reg key to hold last command ran exists. If it does not already exist, it creates it and fills it with "START"
If (-not (Test-Path "HKLM:\SOFTWARE\Cmdlet a Day")) {
    New-Item -Path "HKLM:\Software\Cmdlet a Day"
    New-ItemProperty -Path "HKLM:\Software\Cmdlet a Day" -Name "LastCommand" -Value "START"
}

#Checks the registry string to find which command was run last
$LastCommand = (Get-ItemProperty 'HKLM:\SOFTWARE\Cmdlet a Day').LastCommand

#Get's the index number of the last run command from the commands array
$x = [Array]::IndexOf($Commands,$LastCommand)

#Get's the current (next) command to get help on and places it in a variable
$Current_Command = $Commands[$x+1]

#Get the Help Data
$help = Get-Help $Current_Command | Out-String

#Email Message
    
    #Email From
    $From = "Learn a Cmdlet Every Day <CmdletADay@contoso.com>"

    #Email Subject
    $Subject = "$Current_Command"

    

    #Body
$Body = "<h2>Help files for $Current_Command`:</h2>
<pre><font size='3'>$help</font></pre>"

    #Sends the Email
    Send-MailMessage -To $To -From $From -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTP_Server

    #Sets the current_command as the last run command
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Cmdlet a Day" -Name "LastCommand" -Value $Current_Command
