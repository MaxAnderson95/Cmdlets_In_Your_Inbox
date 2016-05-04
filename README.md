# Cmdlets In Your Inbox
This script will send the help files of a random cmdlet to your Inbox every day. It uses Windows task scheduler to run every day and is even programmed to not send you cmdlets on the weekend if you desire.

## Instructions
1. Download and place the "Cmdlet a Day" folder somewhere on your machine.

### Generate a Random List of Commands
1. First you're going to begin by creating the list of commands that the script will run though daily. This can be done manually or by using the "Generate Random List of Commands.ps1" script.
2. Open the "Generate Random List of Commands.ps1" script file in a text editor or the ISE. 
3. Start adding the list of Modules you'd like to pull commands from on line 3 and down inside the "Modules" array.
4. Once complete, save and run the script. It will generate a txt file named "Commands_Random" in the same directory as the script file based on the modules specified.

### Configure the Primary Script
1. Open "Cmdlet a day.ps1" in a text editor or the ISE.
2. Edit lines 2-4 with your applicable information
3. Save and exit the file

### Configure the Scheduled Task
1. Open Task Scheudler on your PC and create a new task.
2. Name the task. (For example: Send Cmdlet a Day Email)
3. Give an optional discription
4. Run the task as the local account: SYSTEM
5. Check the "Hidden" box
6. Add a daily trigger or a trigger of your choice
7. Add an action of the type "Run a Program".
8. In the "Program/script" box enter "Powershell.exe"
9. In the "Add arguments" box enter "-File "C:\Users\[USERNAME]\\Powershell\Cmdlet a Day\Cmdlet a Day.ps1". Be sure to fill in the applicable path
10. Test the setup by running the task manually

## Things to Note
* This script is currently configured to use an unauthenticated SMTP relay server. It can easily be changed to work with one that requires authentication or to use a service like Gmail.
