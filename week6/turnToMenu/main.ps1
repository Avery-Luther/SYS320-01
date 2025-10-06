$baseDir = $PSScriptRoot + "\..\..\"
$apachedir = $baseDir + "week4"
$procMandir = $baseDir + "week2\ProcessManagement"
$localUserdir = $baseDir + "week6\localUserManagementMenu"
. (Join-Path $apachedir Parsing-Apache-Logs.ps1)
. (Join-Path $procMandir Deliverable4.ps1)
. (Join-Path $localUserdir Users.ps1)
. (Join-Path $localUserdir Event-Logs.ps1)
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display the last 10 apache logs`n"
$Prompt += "2 - Display the last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome and open champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true
while($operation ){
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 5){
        Write-host "goodbye"
        $operation = $false
    }    
    elseif($choice -eq 1){
        $logs = apacheLogs2
        $logs[-10..-1]
        Write-Host "Logs Fetched"
    }
    elseif($choice -eq 2){
        $logins = getFailedLogins 100
        Write-Host ($logins[-10 .. -1] |  Format-Table | Out-String)
        Write-Host "Logs fetched"
    }
    elseif($choice -eq 3){
        $atRisks = atRiskUsers 100
        $atRisks
        Write-Host "Users Fetched"
    }
    elseif($choice -eq 4){
        openChamplain
        Write-Host "Chrome opened to champlain.edu"
    }
}