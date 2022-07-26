#.bat file
#@ECHO OFF
#SET ThisScriptsDirectory=%~dp0
#SET PowerShellScriptPath=%ThisScriptsDirectory%script.ps1
#PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";

#.vbs file
#command = "powershell.exe -nologo -command C:\Users\howtoforge\Desktop\loop.ps1"
#set shell = CreateObject("WScript.Shell")
#shell.Run command,0

# Le script a été pensé pour être le plus simple d'utilisation que possible.
# La quantité de fichiers et d'intéractions ont donc étés réduits au maximum.
Write-Output "### Parametrage de l'arret programme ###"
Write-Output " "

# Vérification des droits
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Merci de lancer ce script avec les privileges d'administrateur (click droit - Executer en tant qu'administrateur)"
    Read-Host "Appuillez sur entree"
    exit 1
}

# Récupération du nom d'utilisateur et de l'heure limite
Write-Output "Renseignez le nom d'utilisateur cible tel qu'il apparait dans le fichier 'C:\Users'."
$user = Read-Host "Nom d'utilisateur: "
Write-Output "Renseignez l'heure d'arret voulue au format hhmm (Par exempe, 22h30 se note 2230)."
Write-Output "Pour desactiver l'arret programme, entrez '0'."
$limit = Read-Host "Heure de l'arret programme: "
Write-Output " "
Write-Output "Creation / mise a jour du virus ..."

# Drapeau de nécessité de redémarage
$ restart = 0
# Chemin du lanceur silencieux
$launcherPath = "C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\schedulerLauncher.vbs"
# Chemin du script
$scriptPath = "C:\Users\" + $user + "\AppData\scheduler.ps1"

# Contenu du lanceur silencieux
$launcherContent = 'command = "powershell.exe -nologo -command ' + $scriptPath + '"
set shell = CreateObject("WScript.Shell")
shell.Run command,0'
# Contenu du script
$scriptContent = 'while (1) {
    # Heure limite
    $limit = ' + $limit + '
    # Obtenir l heure actuelle
    $time = Get-Date -Format "HHmm"
    # Convertir en entier
    $time = $time -as [int]
    # Si l heure actuelle est supérieure à la limite ou inférieure à 6h00 et différente de 0, éteindre l ordi
    if (($time -gt $limit) -or ($time -lt 0600) -and ($time)) {
        Stop-Computer -ComputerName localhost -Force
    }
    # La vérification se fait toutes les minutes
    Start-Sleep -Seconds 60
}'

#Vérification de l'existance et écriture des deux fichiers
if (!(Test-Path -Path $launcherPath -PathType Leaf)) {
    try {
        New-Item $launcherPath
        Set-Content $launcherPath $launcherContent
    }
    catch {
        Write-Output "Echec de la creation du lanceur."
        exit 1
    }
    $restart = 1
}
if (!(Test-Path -Path $scriptPath -PathType Leaf)) {
    try {
        New-Item $scriptPath
        Set-Content $scriptPath $scriptContent
    }
    catch {
        Write-Output "Echec de la creation du virus."
        exit 1
    }
    $restart = 1
}
else {
    try {
        Set-Content $scriptPath $scriptContent
    }
    catch {
        Write-Output "Echec de la modification du virus."
        exit 1
    }
}
Write-Output "Ok."

if ($restart){
    Write-Output "REDEMARRAGE REQUIS"
}

Write-Output " "
Read-Host "Appuillez sur entree pour terminer"

exit 0

# https://blog.danskingdom.com/allow-others-to-run-your-powershell-scripts-from-a-batch-file-they-will-love-you-for-it/
