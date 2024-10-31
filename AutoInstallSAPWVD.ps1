# Variables
$sourcePath = "\\vmfileprd01.fr-gps.local\SAP"          # Chemin UNC du dossier Samba (par exemple : \\192.168.1.10\partage\dossier)
$destinationPath = "C:\Program Files (x86)\SAP"        # Chemin local où les fichiers seront copiés

# Créer le dossier de destination s'il n'existe pas
if (!(Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
}

# Créer un lecteur réseau temporaire pour le partage Samba
New-PSDrive -Name "Z" -PSProvider FileSystem -Root $sourcePath

# Copier tous les fichiers du partage Samba vers le dossier local
Copy-Item -Path "Z:\*" -Destination $destinationPath -Recurse -Force

# Démonter le lecteur réseau après la copie
Remove-PSDrive -Name "Z"

Write-Output "Copie terminée dans $destinationPath !"

C:\Program Files (x86)\01-admin-SAP-install-new-vdi.ps1 -executionpolicy bypass