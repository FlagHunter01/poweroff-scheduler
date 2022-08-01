# Poweroff Scheduler
 
## Aim
 
### Purpose
 
This script aims to help regulate screen time by shutting down the computer at a target time.
It was created due to the lack of reliability of Microsoft Parental Control; one can simply exit. 
It is meant for Windows OS. 
 
### How it works
 
The script prompts for a username and a target time.
When the target user is connected, the script shuts down the computer when the target time is reached. As it is possible to abort a shutdown if there are unsaved files, the script uses a hard shutdown. 
The script also automatically shuts down the computer before 6am if the target user is connected.
 
## Installation
 
### Downloading
 
 - Put the folder anywhere in your admin account, like the desktop.
 
### Granting rights
 
 - Open Windows PowerShell as administrator
 - Run the command:
 
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```
 
 - Enter `Y` and exit.
 
You're done!
 
## Useage
 
### Required information
 
Once you run the script, you will be asked for two pieces of information.
 
#### Folder name of the target account
 
The script generates a file inside the target user's folder.
Since it is possible to change that folder name, the script asks it every time you launch it.
 
> **Note**
> **If you don't know the target folder name**<br>
> - Open the following path in your file manager: "C:\Users" (you can copy it in the top left search bar)
> - Memorize the **exact** name of the target folder.
 
#### Target time
 
You will be prompted for a target time for each day of the week. 
Please answer in the hhmm format. 
For example, 10:37pm is written `2237`.
 
> **Note**
> **Please note that the script will automatically power off the computer if the target user logs in between 0 and 6 am.**
 
### Launching the script
 
 - Open the "Poweroff scheduler" folder.
 - Run "launch-me.dat" as administrator.
 - Answer to the prompts with the previously acquired information
 
> **Note**
> **Antivirus**<br>
> Since it's a script, it is possible that it will be blocked by Windows Defender or another antivirus. 
> There is usually a way to continue anyways by clicking the "More details" link on the antivirus popup.
 
> **Warning**
> **Don't forget to restart the computer if the script asks you to.**
 
### Durability of this script
 
During normal operation, the computer will shut down every day if the target user is connected at the specified time. This will repeat indefinitely. 
No further action should be required. 
 
However, if the file inside the user's folder is deleted, you will need to run the script again. 
You can also run the script to update the shutdown time. 
 
 

