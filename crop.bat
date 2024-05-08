@echo off

setlocal EnableDelayedExpansion

rem Obtenir le chemin d'accès du dossier en cours d'exécution
set "dossier_execution=%~dp0"

rem Définir la commande à exécuter pour chaque fichier PDF (ici, "pdfcropmargins")
set "commande=pdfcropmargins  --verbose --cropSafe  --stringCropped LowMargin --usePrefix"

rem Parcourir les fichiers PDF du dossier en cours d'exécution
for %%a in ("%dossier_execution%\*.pdf") do (
    rem Extraire le nom du fichier PDF (sans extension)
    set "nom_fichier=%%~na"

    rem Exécuter la commande définie avec le nom du fichier PDF
    echo ** %%nom_fichier%% **
    %commande% "%%a"

    rem 

)

pause
