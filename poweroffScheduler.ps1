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
    Read-Host "Appuillez sur entree pour sortir"
    exit 1
}

# Récupération du nom d'utilisateur et de l'heure limite
Write-Output "Renseignez le nom d'utilisateur cible tel qu'il apparait dans le fichier 'C:\Users'."
$user = Read-Host "Nom d'utilisateur: "
Write-Output "Renseignez l'heure d'arret voulue au format hhmm (Par exempe, 22h30 se note 2230)."
Write-Output "Pour desactiver l'arret programme, entrez '0'."
$limit = Read-Host "Heure de l'arret programme: "
Write-Output " "
Write-Output "Creation / mise a jour du script ..."

$content = 'while (1) {
    # Essayer de lire l heure limite
    try {
        $limit = Get-Content -Path ' + $timePath + ' -as [int]
    }
    # En cas d échec, le temps limite est 22h00
    catch {
        $limit = 2200
    }
    # Obtenir l heure actuelle
    $time = Get-Date -Format "HHmm"
    # Convertir en entier
    $time = $time -as [int]
    # Si l heure actuelle est supérieure à la limite ou inférieure à 6h00 et différente de 0, éteindre l ordi
    if (($time -gt $limit) -or ($time -lt 0600) -and ($time)) {
        Stop-Computer -ComputerName localhost
    }
    # La vérification se fait toutes les minutes
    Start-Sleep -Seconds 60
}'

#Vérification de l'existance et écriture des deux fichiers
$scriptPath = "C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\scheduler.ps1"
$timePath = "C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\time.txt"
if (!(Test-Path -Path $scriptPath -PathType Leaf)) {
    Write-Output "Le script n'existe pas. Tentative de craation ..."
    try {
        New-Item $scriptPath
        Set-Content $scriptPath $content
        Write-Output "Ok."
    }
    catch {
        Write-Output "Echec de la creation."
        exit 1
    }
}
else{
    Write-Output "Le script existe."
}
if (!(Test-Path -Path $timePath -PathType Leaf)) {
    Write-Output "Le fichier de configuration n'existe pas. Tentative de creation ..."
    try {
        New-Item $timePath
        Set-Content $timePath $limit
        Write-Output "Ok."
    }
    catch {
        Write-Output "Echec de la creation."
        exit 1
    }
}
else {
    Write-Output "Le fichier de configuration existe. Tentative d'écrasement ..."
    try {
        Set-Content $timePath $limit
        Write-Output "Ok."
    }
    catch {
        Write-Output "Echec de la creation."
        exit 1
    }
}
Write-Output " "
Read-Host "Appuillez sur entree pour fermer le script. Si les fichiers n'existaient pas, merci de redemarrer l'ordinateur."

exit 0

# https://blog.danskingdom.com/allow-others-to-run-your-powershell-scripts-from-a-batch-file-they-will-love-you-for-it/
