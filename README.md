# Script-Zabbix-installation-to-GPO-Windows-Serveur-
Ce script batch automatise l'installation de l'agent Zabbix sur Windows via GPO. Il vérifie d'abord si l'agent est déjà installé pour éviter les réinstallations inutiles. Si absent, l'agent est installé silencieusement avec des paramètres personnalisés (serveur Zabbix, nom d'hôte). Le service est ensuite configuré pour démarrer automatiquement.
