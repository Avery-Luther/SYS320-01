. (Join-Path $PSScriptRoot .\functionsAndEventLogs.ps1) 

clear

$loginoutsTable = loginLogoffEvents(15)
$loginoutsTable

$shutdownsStartupsTable = shutdownStartupEvents(25)
$shutdownsStartupsTable