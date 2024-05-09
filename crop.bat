@echo off
setlocal EnableDelayedExpansion

rem Obtenir le chemin d'accès du dossier en cours d'exécution
set "dossier_execution=%~dp0"

rem Supprimer et recréer le dossier "resultat" s'il existe déjà
if exist "%dossier_execution%\resultat" (
    rmdir /s /q "%dossier_execution%\resultat"
)
mkdir "%dossier_execution%\resultat"

rem Définir les paramètres
set "marges=-5"
set "options=--cropSafe --stringCropped LowMargin --usePrefix"

rem Parcourir les fichiers PDF du dossier en cours d'exécution
for %%a in ("%dossier_execution%\*.pdf") do (
    rem Vérifier si le fichier est un fichier PDF
    if /I "%%~xa"==".pdf" (
        rem Extraire le nom du fichier PDF (sans extension)
        set "nom_fichier=%%~na"

        rem Exécuter la commande définie avec le nom du fichier PDF
        echo Traitement du fichier : %%nom_fichier%%
        pdfcropmargins --absoluteOffset !marges! --outfile "%dossier_execution%\resultat\%%~nxa" --verbose !options! "%%a"
        rem Vérification de l'état de la commande
        if not errorlevel 1 (
            echo Le fichier a été traité avec succès.
        ) else (
            echo Une erreur est survenue lors du traitement du fichier %%nom_fichier%%.
            rem Enregistrement du fichier dans un journal d'erreurs
            echo %%a >> erreurs.log
        )
    ) else (
        rem Ignorer les fichiers qui ne sont pas des PDF
        echo Le fichier %%a n'est pas un fichier PDF. Ignoré.
    )
)

pause
