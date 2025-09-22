function apacheLogs($pageVisited, $httpCode, $browserName) {
    $AccessLogPage = Get-Content C:\xampp\apache\logs\access.log | Select-String "$pageVisited"
    $AccessLogCode = $AccessLogPage | Select-String " $httpCode "
    $AccessLogBrow = $AccessLogCode | Select-String " $browserName"
    
    $regex = [regex] '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
    $ipsUnorg = $regex.Matches($AccessLogBrow)
    $ips = @()
    for($i=0; $i -lt $ipsUnorg.Count; $i++){
        $ips += [PSCustomObject]@{"IP" = $ipsUnorg[$i]}
    }
    $ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
    $counts = $ipsoftens | group IP
    return $counts | Select-Object Count,Name
    
}