# A powershell script that lists every service that is stopped then outputted to a CSV
# Quick note: This lab specifies processes not services, but stopped processes would not show up with Get-Process which only gets running prorcesses. 

if (Get-process | Where-Object {$_.Name -eq 'chrome'}){
    Stop-Process -Name 'chrome'
}
else {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "champlain.edu"
}
