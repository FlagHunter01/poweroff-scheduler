### poweroff scheduler

# Creates a script that powers off the computer if the time is outside the authorized hours.
# The script is written to the folder that is exiecuted uppon login. It is user sensitive.

### Functions 

# Reads username from prompt
function Read-Username {
    Write-Host "Merci d'entrer le nom d'utilisateur tel qu'il apparait dans C:\Users."
    $username = Read-Host " - Nom d'utilisateur"
    return $username
}

# Tries to read saved username from file
# If a new username is entered, saves it to file
function Search-Username {
    if (Test-Path -Path .\SavedUser.txt) {
        $username = Get-Item -Path .\SavedUser.txt | Get-Content -Tail 1
        Write-Host 'Continuer avec '$username ' ?'
        $selection = Read-Host " - O/n"
        if ($selection -eq 'O' -or $selection -eq 'o' -or $selection -eq "") {
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
    Write-Host "Ecriture du lanceur et du script sur le profil cible."
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
            Write-Host "Erreur lors de l'écriture du lanceur."
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
            Write-Host "Erreur lors de l'écriture du script."
            return 2
        }
    }
    # Updating script if it already exists
    else {
        try {
            Set-Content $scriptPath $scriptContent
        }
        catch {
            Write-Host "Erreur pendant la mise à jour du script."
            return 2
        }
    }
    Write-Host " "
    Write-Host "Fini."
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
    Write-Host "### ECRITURE DU SCRIPT" -ForegroundColor Green
    Write-Host " "
    $username = Search-Username
    Write-Host " "
    Write-Host "Entrer l'heure cible au format hhmm (par exemple, 22h37 s'écrit 2237. 6h00 est 0600 et minuit est 2400)."
    Write-Host "L'ordinateur s'éteindra avant la limite du matin et après la limite de l'après-midi."
    Write-Host "Pour empêcher l'ordinateur de s'éteindre courant une journée, entrer 0 pour la limite du matin et 2400 pour la limite de l'après-midi."
    Write-Host " "
    [int32[][]]$limit = @((0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400))
    Write-Host "Lundi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[0] = ($morning, $afternoon)
    Write-Host "Mardi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[1] = ($morning, $afternoon)
    Write-Host "Mercredi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[2] = ($morning, $afternoon)
    Write-Host "Jeudi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[3] = ($morning, $afternoon)
    Write-Host "Vendredi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[4] = ($morning, $afternoon)
    Write-Host "Samedi"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[5] = ($morning, $afternoon)
    Write-Host "Dimanche"
    $morning = Read-Host " - Matin"
    $afternoon = Read-Host " - Après-midi"
    $limit[6] = ($morning, $afternoon)
    Write-Host " "
    $result = Write-Script $username $limit
    if ($result -eq 1) {
        Write-Host "/!\ Un redémarrage est requis. Voulez-vous redémarrer maintenant ?" -ForegroundColor Magenta
        $restart = Read-Host " - O/n"
        if ($restart -eq 'O' -or $restart -eq 'o' -or $restart -eq "") {
            Write-Host " "
            Write-Host "### REDEMARRAGE" -ForegroundColor Green
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
    Write-Host "### DESACTIVATION DE L'EXTINCTION" -ForegroundColor Green
    Write-Host " "
    Write-Host "/!\ Notez que si l'utilisateur cible n'était pas encore affecté par le script, un script bénin sera ajouté a sa session." -ForegroundColor Magenta
    Write-Host " "
    $username = Search-Username
    $limit = @((0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400), (0, 2400))
    Write-Script $username $limit
    Write-Host " "
    Write-Host "Fini."
    Write-Host " "
    Select-Menu
    exit 0
}

# Deletes the script from target user
function Clear-Schedule {
    Write-Host " "
    Write-Host "### SUPPRESSION DU SCRIPT" -ForegroundColor Green
    Write-Host " "
    $username = Search-Username
    $launcherPath = "C:\Users\" + $username + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\schedulerLauncher.vbs"
    $scriptPath = "C:\Users\" + $username + "\AppData\scheduler.ps1"
    Remove-Item -Path $launcherPath
    Remove-Item -Path $scriptPath
    Write-Host "Fini."
    Write-Host " "
    Select-Menu
    exit 0
}

# Displays the selection menu and starts one of the other functions
function Select-Menu {
    Write-Host "### MENU PRINCIPAL" -ForegroundColor Green
    Write-Host " "
    Write-Host "Pour créer / mettre à jour un horaire d'extinction, entrez '1'."
    Write-Host "Pour désactiver toutes les extinctions, entrez '2'."
    Write-Host "Pour supprimer le script, entrez '3'."
    Write-Host "Pour sortir, entrez n'importe quel autre caractère."
    $selection = Read-Host " - Votre choix"
    
    switch ($selection) {
        
        '1' { Write-Schedule }
        '2' { Disable-Schedule }
        '3' { Clear-Schedule }
        Default {
            Write-Host " "
            Write-Host "Fermeture du script."
            exit 0
        }
    }


}

### Body ###

Write-Host "### POWEROFF SCHEDULER" -ForegroundColor Green
Write-Host " "
Write-Host "https://flaghunter01.github.io/poweroff-scheduler/fr/"
Write-Host " "

### Checking for admin rights 
# This should never work since the script is granted admin rights by the .bat launcher
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "/!\ Merci de lancer le script avec les privilèges d'administrateur (click-droit - Lancer en tant qu'administrateur)" -ForegroundColor Magenta
    Read-Host "Appuyez sur entrée"
    exit 1
}

Select-Menu
exit 0
