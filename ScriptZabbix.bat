@echo off

REM Définit le chemin du fichier MSI (à modifier selon votre environnement)
set "MSI_PATH=\\chemin\vers\le\fichier\zabbix_agent-7.0.3-windows-amd64-openssl.msi"

REM Définit les paramètres d'installation personnalisés
set ZABBIX_SERVER=adresse_du_serveur
set AGENT_HOSTNAME=%COMPUTERNAME%
set HOST_METADATA=metadata_personnalise
set TLSPSK_IDENTITY=identifiant_psk
set TLSPSK_VALUE=valeur_psk

REM Installe l'agent Zabbix avec les paramètres
msiexec /i "%MSI_PATH%" /quiet /norestart /log "%temp%\zabbix_agent_install.log" ^
ENABLEREMOTECOMMANDS=1 ^
SERVER=%ZABBIX_SERVER% ^
SERVERACTIVE=%ZABBIX_SERVER% ^
HOSTNAME=%AGENT_HOSTNAME% ^
HOSTMETADATA=%HOST_METADATA% ^
TLSCONNECT=psk ^
TLSACCEPT=psk ^
TLSPSKIDENTITY=%TLSPSK_IDENTITY% ^
TLSPSKVALUE=%TLSPSK_VALUE%

REM Vérifie le statut de l'installation
if %ERRORLEVEL% neq 0 (
    echo Une erreur est survenue pendant l'installation.
    pause
)

REM Configure le service Zabbix pour démarrer automatiquement
sc config "Zabbix Agent" start= auto

REM Attendre 20 secondes avant de démarrer le service
timeout /t 20 /nobreak

REM Démarre le service Zabbix Agent
sc start "Zabbix Agent"

REM Empêche la fermeture automatique de la fenêtre CMD
pause
