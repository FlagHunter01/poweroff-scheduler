### poweroff scheduler

# Creates a script that powers off the computer if the time is outside the authorized hours.
# The script is written to the folder that is exiecuted uppon login. It is user sensitive.

### Functions 

# Reads username from prompt
function Read-Username {
    Write-Host "Please enter the target username as found in C:\Users."
    $username = Read-Host " - Username"
    return $username
}

# Tries to read saved username from file
# If a new username is entered, saves it to file
function Search-Username {
    if (Test-Path -Path .\SavedUser.txt) {
        $username = Get-Item -Path .\SavedUser.txt | Get-Content -Tail 1
        Write-Host 'Proceed with user '$username ' ?'
        $selection = Read-Host " - Y/n"
        if ($selection -eq 'Y' -or $selection -eq 'y' -or $selection -eq "") {
            return $username
        }
        else {
            $username = Read-Username
            $username > .\SavedUser.txt
            return $username
        }
    }
    else {
        $username = Read-Username
        $username > .\SavedUser.txt
        return $username
    }
}

# Writes the poweroff script to the target user
# Returns 0 if successful, 1 if restart needed and 2 if failed
function Write-Script ($user, $limit) {
    Write-Host " "
    Write-Host "Writing launcher and script to target user."
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
    $scriptContent = 'while (1) {# Limit array
[int32[][]]$limitArray = @((' + $limit[0][0] + ', ' + $limit[0][1] + '), (' + $limit[1][0] + ', ' + $limit[1][1] + '), (' + $limit[2][0] + ', ' + $limit[2][1] + '), (' + $limit[3][0] + ', ' + $limit[3][1] + '), (' + $limit[4][0] + ', ' + $limit[4][1] + '), (' + $limit[5][0] + ', ' + $limit[5][1] + '), (' + $limit[6][0] + ', ' + $limit[6][1] + '))
# Get current time
$time = Get-Date -Format "HHmm"
# Convert to int
$int_time = [int]$time
# Get day of the week
$day = [Int] (Get-Date).DayOfWeek
# Today s time limit
$limit = $limitArray[$day-1]
# if current time < morning limit or > afternoon limit, force shutdown.
if (($int_time -lt $limit[0]) -or ($int_time -gt $limit[1]) -and ($int_time)) {
    Stop-Computer -ComputerName localhost -Force
}
# This script runs once every minute
Start-Sleep -Seconds 60
}'

    ## Implanting the script into the target user's folders 
    # Create launcher if it doesn't exist
    if (!(Test-Path -Path $launcherPath -PathType Leaf)) {
        try {
            New-Item $launcherPath
            Set-Content $launcherPath $launcherContent
            $restart = 1
        }
        catch {
            Write-Host "Error while creating launcher."
            return 2
        }
    }
    # Create script if it doesn't exist
    if (!(Test-Path -Path $scriptPath -PathType Leaf)) {
        try {
            New-Item $scriptPath
            Set-Content $scriptPath $scriptContent
            $restart = 1
        }
        catch {
            Write-Host "Error while creating script."
            return 2
        }
    }
    # Updating script if it already exists
    else {
        try {
            Set-Content $scriptPath $scriptContent
        }
        catch {
            Write-Host "Error while updating script."
            return 2
        }
    }
    Write-Host " "
    Write-Host "Done."
    Write-Host " "
    if ($restart) {
        return 1
    }
    else {
        return 0
    }

}

# Reads the wanted schedule from prompt and writes script to target user
function Write-Schedule {
    Write-Host " "
    Write-Host "### WRITING THE SCRIPT" -ForegroundColor Green
    Write-Host " "
    $username = Search-Username
    Write-Host " "
    Write-Host "Enter the target time in hhmm format (e.g.: 10:37pm is written '2237')."
    Write-Host "The computer will shut down before the morning time and after the afternoon time."
    Write-Host "To deactivate the shutdown, enter '0' for the morning time and '2400' for the afternoon."
    Write-Host " "
    [int32[][]]$limit = @((0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400))
    Write-Host "Monday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[0] = ($morning, $afternoon)
    Write-Host "Tuesday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[1] = ($morning, $afternoon)
    Write-Host "Wednesday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[2] = ($morning, $afternoon)
    Write-Host "Thursday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[3] = ($morning, $afternoon)
    Write-Host "Friday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[4] = ($morning, $afternoon)
    Write-Host "Saturday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[5] = ($morning, $afternoon)
    Write-Host "Sunday"
    $morning = Read-Host " - Morning"
    $afternoon = Read-Host " - Afternoon"
    $limit[6] = ($morning, $afternoon)
    Write-Host " "
    $result = Write-Script $username $limit
    if ($result -eq 1) {
        Write-Host "/!\ A restart is needed. Do you wish to restart now ?" -ForegroundColor Magenta
        $restart = Read-Host " - Y/n"
        if ($restart -eq 'y' -or $restart -eq 'Y' -or $restart -eq "") {
            Write-Host " "
            Write-Host "### RESTARTING COMPUTER" -ForegroundColor Green
            Restart-Computer -ComputerName localhost -Force
        }
    }
    Write-Host " "
    Select-Menu
    exit 0
}

# Disables the poweroff for target user
function Disable-Schedule {
    Write-Host " "
    Write-Host "### DISABLING POWEROFF" -ForegroundColor Green
    Write-Host " "
    Write-Host "/!\ Please note that the script will be written with no time restriction to the user if it isn't already in his folder." -ForegroundColor Magenta
    Write-Host " "
    $username = Search-Username
    $limit = @((0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400))
    Write-Script $username $limit
    Write-Host " "
    Write-Host "Done."
    Write-Host " "
    Select-Menu
    exit 0
}

# Deletes the script from target user
function Clear-Schedule {
    Write-Host " "
    Write-Host "### DELETING POWEROFF SCRIPT" -ForegroundColor Green
    Write-Host " "
    $username = Search-Username
    $launcherPath = "C:\Users\" + $username + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\schedulerLauncher.vbs"
    $scriptPath = "C:\Users\" + $username + "\AppData\scheduler.ps1"
    Remove-Item -Path $launcherPath
    Remove-Item -Path $scriptPath
    Write-Host "Done."
    Write-Host " "
    Select-Menu
    exit 0
}

# Displays the selection menu and starts one of the other functions
function Select-Menu {
    Write-Host "### MAIN MENU" -ForegroundColor Green
    Write-Host " "
    Write-Host "To create / update the poweroff schedule, press '1'."
    Write-Host "To deactivate all scheduled poweroffs, press '2'."
    Write-Host "To delete the poweroff scheduler, press '3'."
    Write-Host "To exit this script, press any other key."
    $selection = Read-Host " - Your choice"
    
    switch ($selection) {
        
        '1' { Write-Schedule }
        '2' { Disable-Schedule }
        '3' { Clear-Schedule }
        Default {
            Write-Host " "
            Write-Host "Closing script."
            exit 0
        }
    }


}

### Body ###

Write-Host "### POWEROFF SCHEDULER" -ForegroundColor Green
Write-Host " "

### Checking for admin rights 
# This should never work since the script is granted admin rights by the .bat launcher
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "/!\ Please launch the script with administrator privileges (right-click - Launch as administrator)" -ForegroundColor Magenta
    Read-Host "Press enter"
    exit 1
}

Select-Menu
exit 0
