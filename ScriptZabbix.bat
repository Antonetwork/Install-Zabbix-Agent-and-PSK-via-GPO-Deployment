@echo off

REM Définit le chemin du fichier MSI
set "MSI_PATH=\\192.168.13.123\Users\Administrateur\Desktop\Partage\zabbix_agent-7.0.3-windows-amd64-openssl (1).msi"

REM Définit les paramètres d'installation personnalisés
set ZABBIX_SERVER=192.168.13.119
set AGENT_HOSTNAME=%COMPUTERNAME%
set HOST_METADATA=Debian
set TLSPSK_IDENTITY=Zabbix

REM Génère la clé PSK à l'aide du script PowerShell
for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -File "\\192.168.13.123\Users\Administrateur\Desktop\Partage\GeneratePSK.ps1"') do set "TLSPSK_VALUE=%%i"

REM Affiche la clé PSK générée pour vérification
echo La clé PSK générée est : %TLSPSK_VALUE%

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
