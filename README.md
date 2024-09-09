### Install Zabbix Agent via GPO Deployment

This batch script is designed to automate the installation of the Zabbix agent on Windows machines via a Group Policy Object (GPO) deployment. It first checks if the "Zabbix Agent" service is already installed on the target machine. If the agent is not present, the script proceeds with a silent installation of the Zabbix agent MSI package, using custom parameters such as the Zabbix server address and the hostname of the machine. Once the installation is complete, the script configures the Zabbix service to start automatically. This approach ensures a single installation and avoids redundant re-installations at each machine startup.

For proper implementation of this script, please visit the following link: [https://docs.khroners.fr/books/zabbix/page/deploiement-de-lagent-zabbix-par-gpo](https://docs.khroners.fr/books/zabbix/page/deploiement-de-lagent-zabbix-par-gpo). Don’t forget to modify the Zabbix server IP address and the installation file location in the script before deploying it.

Step 1: Create the PowerShell Script
Create a PowerShell script named GeneratePSK.ps1 with the following content:

Step 2: Modified Batch Script
Here’s the updated batch script to call the PowerShell script and use the generated PSK key:
