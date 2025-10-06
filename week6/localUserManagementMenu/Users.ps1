

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

# For Choice 3
function checkUser($name){
    Try {Get-LocalUser $name -ErrorAction SilentlyContinue} Catch [UserNotFound]{ return $false }
}
# TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
Function checkPassword($password){
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    if(($plainPassword.Length -ge 6) -and `
       ($plainPassword -match '[!@#\$%\^&\*\(\)\[\]\{\}\+~`?><_]+') -and `
       ($plainPassword -match '[0-9]+') -and `
       (($plainPassword -match '[A-Z]+') -or ($plainPassword -match '[a-z]+'))){
       return $true
    }
    Else{
        return $false
    }

}

# At risk users
function atRiskUsers($days){
        
        $userLogins = getFailedLogins $days
        $byUser = $userLogins | Group -Property 'User'
        Write-Host "At risk users:"
        $atRisks = @()
        $byUser | ForEach-Object {
            if($_.Count -gt 10){
                 $atRisks += $_.Name
            } 
        }
        return $atRisks
}
