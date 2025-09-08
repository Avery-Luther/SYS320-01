# A powershell script that lists every process that does not have 'system32' in the file path

Get-Process | Where-Object {$_.Path -notcontains 'system32'}