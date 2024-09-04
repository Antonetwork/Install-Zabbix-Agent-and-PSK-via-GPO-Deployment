@echo off

REM Définit le chemin du fichier MSI
set "MSI_PATH=\\adresse_ip_du_serveur_zabbix\Partage\zabbix_agent-7.0.3-windows-amd64-openssl.msi"

REM Définit les paramètres d'installation personnalisés
set ZABBIX_SERVER=adresse_ip_du_serveur_zabbix
set AGENT_HOSTNAME=%COMPUTERNAME%
set INSTALL_PATH="C:\Program Files\Zabbix Agent"

REM Vérifie si le service Zabbix Agent est déjà installé
sc query "Zabbix Agent" >nul 2>&1

if %errorlevel% == 0 (
    echo L'agent Zabbix est déjà installé. Fin du script.
    exit /b 0
) else (
    REM Installe l'agent Zabbix
    msiexec /i "%MSI_PATH%" /quiet /norestart /log "%temp%\zabbix_agent_install.log" SERVER=%ZABBIX_SERVER% HOSTNAME=%AGENT_HOSTNAME% INSTALLFOLDER=%INSTALL_PATH%

    REM Démarre et configure le service Zabbix
    sc start "Zabbix Agent"
    sc config "Zabbix Agent" start= auto
)
