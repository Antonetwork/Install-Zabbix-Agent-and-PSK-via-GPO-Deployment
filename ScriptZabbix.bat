@echo off

REM Define the path to the MSI file
set "MSI_PATH=\\adresse_ip\Partage\zabbix_agent-7.0.3-windows-amd64-openssl.msi"

REM Define installation parameters
set ZABBIX_SERVER=adresse_ip_du_serveur_zabbix
set AGENT_HOSTNAME=%COMPUTERNAME%
set INSTALL_PATH="C:\Program Files\Zabbix Agent"

REM Check if the Zabbix Agent service is already installed
sc query "Zabbix Agent" >nul 2>&1

if %errorlevel% == 0 (
    echo Zabbix Agent is already installed. Exiting script.
    exit /b 0
) else (
    REM Install the Zabbix Agent
    msiexec /i "%MSI_PATH%" /quiet /norestart /log "%temp%\zabbix_agent_install.log" SERVER=%ZABBIX_SERVER% HOSTNAME=%AGENT_HOSTNAME% INSTALLFOLDER=%INSTALL_PATH%

    REM Start and configure the Zabbix Agent service
    sc start "Zabbix Agent"
    sc config "Zabbix Agent" start= auto
)
