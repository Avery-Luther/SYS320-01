$configFile = $PSScriptRoot + "\configuration.txt"

$prompt = @()
$prompt += "`n"
$prompt += "1 - Show Configuration`n"
$prompt += "2 - Change Configuration`n"
$prompt += "3 - Exit"

function readConfiguration(){
    $configRaw = Get-Content $configFile
    $config = @()
    $config = [PSCustomObject]@{ "Days" = $configRaw[0]; "Time" = $configRaw[1]}
    return $config
}


function changeConfiguration(){
    $newDays = Read-Host -Prompt "How many days back?"
    if($newDays -match "\D"){
        return "Please enter a number"
    }
    $newTime = Read-host -Prompt "What time?"
    if($newTime -notmatch "[0-9]{1,2}:[0-9]{1,2}\s[A,P]M"){
        return 'Please use the format "XX:XX AM/PM"'
    }
    $newConfigRaw = $newDays + "`n" + $newTime
    $newConfigRaw | Out-File -FilePath $configFile
    

}
function configurationMenu{
    $operation = $true
    While ($operation) {
    
        Write-Host $prompt | Out-String
        $choice = Read-Host -Prompt "Select" 
        if ($choice -eq 3){
            Write-Host "Goodbye"
            $operation = $false
        }
        #Show config
        elseif($choice -eq 1){
            Write-Host "Current Config File:" | Out-String
            Write-Host (readConfiguration | Format-Table | Out-String)
        }
        #Change config
        elseif($choice -eq 2){
            changeConfiguration
            Write-Host "Configuration changed" | Out-String
        }
        Else{
            Write-Host "Only enter a number between 1 and 3"
        }
    }
}
