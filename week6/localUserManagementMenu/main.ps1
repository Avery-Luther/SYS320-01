. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        if (checkUser $name){
            Write-Host "User Already Exists"
            continue
        }
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        if ((checkPassword $password) -eq $false){
            Write-Host "Password must meet complexity requirements"
            continue
        }
        
        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if (checkUser $name){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
            continue
        } 
        Else{
            Write-Host "User does not exist" | Out-String
        }
        

        
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if (checkUser $name){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
            continue
        } 
        Else{
            Write-Host "User does not exist" | Out-String
        }

        
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if (checkUser $name){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
            continue
        } 
        Else{
            Write-Host "User does not exist" | Out-String
        }
        
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if (checkUser $name){
            $days = Read-Host -Prompt "Please enter the number of days back to check"
            $userLogins = getLogInAndOffs $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
            continue
        } 
        Else{
            Write-Host "User does not exist" | Out-String
        }
        
        

        
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if (checkUser $name){
            $days = Read-Host -Prompt "Please enter the number of days back to check"
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
            continue
        } 
        Else{
            Write-Host "User does not exist" | Out-String
        }
        

        
    }


# At risk users   
    elseif($choice -eq 9){
        $days = Read-Host -Prompt "Please enter the number of days back to check"
        $atRisks = atRiskUsers($days)
        #Write-Host $atRisks.Length
        Write-Host $atRisks | Out-String
        #for($i=0, $i -lt $atRisks.Length; $i++){
        #    Write-Host $atRisks[$i]
        #}
    }
    else{
        Write-Host "Please enter a number from 1 through 10"|Out-String
    }

}




