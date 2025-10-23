#Challenge 1
function getIOCs(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.47/IOC.html #Getting web page
    $trs = $page.parsedhtml.body.getElementsBytagName("tr") #pulling all of the TR tags
    $fullTable = @() #initializing the table object
    for($i=1; $i -lt $trs.length; $i++){ #looping through all of table records
        $tds = $trs[$i].getElementsByTagName("td") #pulling the table data
        $fullTable += [pscustomobject]@{`
                "Pattern" = $tds[0].innerText;`
                "Explanation" = $tds[1].innerText;`
        } #Writing all of the table data to the object
    }
    return $fullTable #return object
}
function getApacheAccessLogs{
    $logFilePath = Join-Path $PSScriptRoot .\access.log #make the file path
    $logFile = Get-Content $logFilePath #get the file
    $tableRecords = @() # initialize object
    for($i=0; $i -lt $logFile.count; $i++){ #Loop through each line
        $words = $logFile[$i].Split(" "); #split the line into each element of the log
        $tableRecords += [PSCustomObject]@{ "IP" = $words[0];`
                                            "Time" = $words[3].Trim("[");`
                                            "Method" = $words[5].Trim('"'); `
                                            "Page" = $words[6]; `                                        
                                            "Protocol" = $words[7].Trim('"'); `                                            
                                            "Resopnse" = $words[8];`
                                            "Referer" = $words[10].Trim('"');`
                                            } #Fetch log data
    }
    return $tableRecords # Return the object

}
function getSusLogs(){
    $IOCs = getIOCs | select Pattern # Get just the IoC patterns
    $fullLogs = getApacheAccessLogs # Get the access logs
    $susLogs = @() #Initalize the new log object
    for($i = 0; $i -lt $fullLogs.count; $i++){ #Loop through all of the logs
        # This will loop through all of the IOCs on one particular log.
        # If it detects just one IoC it will stop everything and move to the next log.
        $loopCon = $True
        for($j = 0; (($j -lt $IOCs.count) -and ($loopCon -eq $True)); $j++){
            if($fullLogs[$i].Page -match $IOCs[$j].Pattern){
                $susLogs += $fullLogs[$i]
                $loopCon = $False
            }
        }
    }
    return ($susLogs) # Return logs
}
#Write-Host (getIOCs | Format-Table -AutoSize -Wrap | Out-String)
#Write-Host (getApacheAccessLogs | Format-Table -AutoSize -Wrap | Out-String)
Write-Host (getSusLogs | Format-Table -AutoSize -Wrap | Out-String)
