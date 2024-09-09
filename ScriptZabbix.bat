@echo off

REM Define the path to the MSI file
set "MSI_PATH=\\path\to\your\file\zabbix_agent-7.0.3-windows-amd64-openssl.msi"

REM Define custom installation parameters
set ZABBIX_SERVER=your_zabbix_server_address
set AGENT_HOSTNAME=%COMPUTERNAME%
set HOST_METADATA=your_custom_metadata
set TLSPSK_IDENTITY=your_psk_identity

REM Generate the PSK key using the PowerShell script
for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -File "\\path\to\your\script\GeneratePSK.ps1"') do set "TLSPSK_VALUE=%%i"

REM Display the generated PSK key for verification
echo The generated PSK key is: %TLSPSK_VALUE%

REM Install the Zabbix agent with the parameters
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

REM Check the installation status
if %ERRORLEVEL% neq 0 (
    echo An error occurred during installation.
    pause
)

REM Configure the Zabbix service to start automatically
sc config "Zabbix Agent" start= auto

REM Wait 20 seconds before starting the service
timeout /t 20 /nobreak

REM Start the Zabbix Agent service
sc start "Zabbix Agent"

REM Prevent the CMD window from closing automatically
pause
