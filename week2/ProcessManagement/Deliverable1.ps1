# A powershell script that lists every process that has a name starting with 'C'

Get-Process | Where-Object {$_.ProcessName -eq 'C*'}