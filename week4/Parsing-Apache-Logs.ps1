function apacheLogs2(){
    $logsNotFormated = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()
    for($i=0; $i -lt $logsNotFormated.Count; $i++){
        $words = $logsNotFormated[$i].Split(" ");
        
        $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                            "Time" = $words[3].Trim("["); `
                                            "Method" = $words[5].Trim('"'); `
                                            "Page" = $words[6]; `
                                            "Protocol" = $words[7].Trim('"'); `
                                            "Resopnse" = $words[8];`
                                            "Referrer" = $words[10];
                                            "Client" = $words[11..($words.Length)];
                                            }
    }
return $tableRecords
}
