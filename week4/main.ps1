. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Parsing-Apache-Logs.ps1)
Write-Host "Assignment 1:" | Out-String
Write-Host (apacheLogs "index.html" 200 "Chrome" | Format-Table -AutoSize -Wrap | Out-String)

Write-Host "Assignment 2:" | Out-String
Write-Host (apacheLogs2 | Format-Table -Autosize -Wrap | Out-String)