Write-Output "### Poweroff-sheduler configuration ###"
Write-Output " "



### Checking for admin rights ###
# This should never work since the script is granted admin rights by the .bat launcher
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Please launch the script with administrator privileges (right-click - Launch as administrator)"
    Read-Host "Press enter"
    exit 1
}



### Reading username and target time ###
Write-Output "Enter the target user's name as displayed in the 'C:\Users' folder."
$user = Read-Host "Username"
Write-Output "Enter the target time in hhmm format (e.g.: 10:37pm is written '2237)."
Write-Output "To deactivate the shutdown, enter '0'."
$limit = @(2200, 2200, 2200, 2200, 2200, 2200, 2200)
$limit[0] = Read-Host "Monday"
$limit[1] = Read-Host "Tuesday"
$limit[2] = Read-Host "Wednesday"
$limit[3] = Read-Host "Thursday"
$limit[4] = Read-Host "Friday"
$limit[5] = Read-Host "Saturday"
$limit[6] = Read-Host "Sunday"
Write-Output " "
Write-Output "Creation / update of the script ..."

### Setting up variables for the script ###
# Flag indicating the need to restart the computer
$restart = 0

## Paths
# Path of the launcher
$launcherPath = "C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\schedulerLauncher.vbs"
# Path of the script itself
$scriptPath = "C:\Users\" + $user + "\AppData\scheduler.ps1"

## Content
# Launcher content
$launcherContent = 'command = "powershell.exe -nologo -command ' + $scriptPath + '"
set shell = CreateObject("WScript.Shell")
shell.Run command,0'
# Script content
$scriptContent = 'while (1) {# Tableau d heure limite
    $limitArray = @('+ $limit[0] + ',' + $limit[1] + ',' + $limit[2] + ',' + $limit[3] + ',' + $limit[4] + ',' + $limit[5] + ',' + $limit[6] + ')
    # Get current time
    $time = Get-Date -Format "HHmm"
    # Convert to int
    $time = $time -as [int]
    # Get day of the week
    $day = [Int] (Get-Date).DayOfWeek
    # Today s time limit
    $limit = $limitArray[$day-1]
    # if current time > limit or if it s before 6am and the limit isn t 0, force shutdown.
    if (($time -gt $limit) -or ($time -lt 0600) -and ($time)) {
        Stop-Computer -ComputerName localhost -Force
    }
    # This script runs once every minute
    Start-Sleep -Seconds 60
}'

### Implanting the script into the target user's folders ###
# Create launcher if it doesn't exist
if (!(Test-Path -Path $launcherPath -PathType Leaf)) {
    try {
        New-Item $launcherPath
        Set-Content $launcherPath $launcherContent
    }
    catch {
        Write-Output "Error while creating launcher."
        exit 1
    }
    $restart = 1
}
# Create script if it doesn't exist
if (!(Test-Path -Path $scriptPath -PathType Leaf)) {
    try {
        New-Item $scriptPath
        Set-Content $scriptPath $scriptContent
    }
    catch {
        Write-Output "Error while creating script."
        exit 1
    }
    $restart = 1
}
# Updating script if it already exists
else {
    try {
        Set-Content $scriptPath $scriptContent
    }
    catch {
        Write-Output "Error while updating script."
        exit 1
    }
}
Write-Output "Ok."

### End ###
# Displaying restart message
if ($restart){
    Write-Output "RESTART REQUIRED"
}
# Waiting for imput to keep the window alive
Write-Output " "
Read-Host "Press enter to finish"

exit 0
