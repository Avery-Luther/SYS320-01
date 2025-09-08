# A powershell script that lists every service that is stopped then outputted to a CSV
# Quick note: This lab specifies processes not services, but stopped processes would not show up with Get-Process which only gets running prorcesses. 

Get-Service | Where-Object {$_.Status -eq 'Stopped'} | Export-Csv -Path '.\deliverable3output.csv'
 