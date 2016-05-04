#Change These Variables:
$Path_To_Files = "C:\Users\max.anderson\Google Drive\Powershell\Cmdlet a Day"
$SMTP_Server = "relay.chicos.com"
$To = "max.anderson.contractor@chicos.com"


#Prevents the script from running if it's the weekend
If ((Get-Date).DayOfWeek -eq "Saturday" -or (Get-Date).DayOfWeek -eq "Sunday") {
 Exit
}

#Gets a list of all commands in a random order that was already generated earlier and places them in an array
$Commands = Get-Content "$Path_To_Files\Commands_Random.txt"

#Checks the var.txt file to find which command was run last
$LastCommand = Get-Content "$Path_To_Files\Last_Command.txt"

#Get's the index number of the last run command from the commands array
$x = [Array]::IndexOf($Commands,$LastCommand)

#Get's the current (next) command to get help on and places it in a variable
$Current_Command = $Commands[$x+1]

#Get the Help Data
$help = Get-Help $Current_Command | Out-String

#Email Message
    
    #Email From
    $From = "Learn a Cmdlet Every Day <CmdletADay@test.com>"

    #Email Subject
    $Subject = "$Current_Command"

    

    #Body
$Body = "<h2>Help files for $Current_Command`:</h2>
<pre><font size='3'>$help</font></pre>"

    #Sends the Email
    Send-MailMessage -To $To -From $From -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTP_Server

    #Sets the current_command as the last run command
    Set-Content -Path "$Path_To_Files\Last_Command.txt" -Value $Current_Command