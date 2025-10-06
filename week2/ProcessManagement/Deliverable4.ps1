# A powershell script that detects if chorme is open, then if it is closes it, and if it isnt opens it to champlain.edu 
Function openChamplain(){
if (Get-process | Where-Object {$_.Name -eq 'chrome'}){
    Stop-Process -Name 'chrome'
}
else {
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "champlain.edu"
}
}