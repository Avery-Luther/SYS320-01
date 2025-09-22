# Listing all of the apache logs
# Get-Content C:\xampp\apache\logs\access.log

# Listing the last 5 logs
# Get-Content C:\xampp\apache\logs\access.log -Tail 5

# Listing the 404s and 400s 
# Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

# Listing logs that are NOT 200
# Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch ' 200 '

# From all of the .log files, get entries that contain 'error'
#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String  'error'
#$A[-1..-5]

$notFounds = Get-ChildItem C:\xampp\apache\logs\access.log | Select-String ' 404 '
$regex = [regex] '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
$ipsUnorg = $regex.Matches($notFounds)

$ips = @()
for($i=0; $i -lt $ipsUnorg.Count; $i++){
    $ips += [PSCustomObject]@{"IP" = $ipsUnorg[$i]}
}
#$ips | Where-Object { $_.IP -ilike "10.*"}

$ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipsoftens | group IP
$counts | Select-Object Count,Name
