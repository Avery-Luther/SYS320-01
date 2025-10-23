. "C:\Users\champuser\sys320-01\week6\localUserManagementMenu\Users.ps1"
. "C:\Users\champuser\sys320-01\week7\Configuration.ps1"
. "C:\Users\champuser\sys320-01\week7\Email.ps1"
. "C:\Users\champuser\sys320-01\week7\scheduler.ps1"
. "C:\Users\champuser\sys320-01\week6\localUserManagementMenu\Event-Logs.ps1"

$configuration = readConfiguration
$failed = atRiskUsers $configuration.Days
#Write-Host ($failed | Format-Table | Out-String)
sendAlertEmail($failed | Format-Table | Out-String)

ChooseTimeToRun ($configuration.Time)