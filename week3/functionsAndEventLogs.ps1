# Getting the login and logoff records from the windows event logs
Function loginLogoffEvents($days){
#Getting the events within the stated time frame
$loginout = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)
# Creating the table to prevent future errors
$loginoutTable = @()
#Looping through each entry inside of the event logs I pulled
for($i=0; $i -lt $loginout.Count; $i++){
    #creating the event variable to prevent future errors
    $event = ""
    # Defining logins and log offs based on instance ID
    if($loginout[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginout[$i].InstanceId -eq 7002) {$event="Logoff"}

    #This is a pretty large one liner that translates the user feild from an SID to a hostname\username format
    $user = (New-Object System.Security.Principal.SecurityIdentifier($loginout[$i].ReplacementStrings[1])).Translate([System.Security.Principal.NTAccount]).Value
    # Creating a custom object and adding all of the parameters that we pulled
    $loginoutTable += [PSCustomObject]@{"Time" = $loginout[$i].TimeGenerated; `
                                         "Id"  = $loginout[$i].InstanceId; `
                                       "Event" = $event; `
                                        "User" = $user;
                                         }
    
}
Return $loginoutTable
}

#This function will pull all of the event logs for startup and shutdowns and place them into a table simmilar to the privious function
Function shutdownStartupEvents($days){
# Pulling all of the event logs that we need
$startupShutdown = Get-EventLog System -Source EventLog -After (Get-Date).AddDays(-$days)

# Creating the table to prevent future errors
$startupShutdownTable = @()

#looping through each table entry
for($i=0; $i -lt $startupShutdown.Count; $i++){
    #checking if the event is a start up or shutdown before making an entry
    if($startupShutdown[$i].EventID -ne 6005 -and $startupShutdown[$i].EventID -ne 6006) {continue}
    
    $event = ""
    #Checking to see if it is a startup or shutdown then setting the event parameter accordingly
    if($startupShutdown[$i].EventID -eq 6006) {$event="Shutdown"}
    if($startupShutdown[$i].EventID -eq 6005) {$event="Startup"}
     
    #placing everything into a custom object
    $startupShutdownTable += [PSCustomObject]@{"Time" = $startupShutdown[$i].TimeGenerated; `
                                         "Id"  = $startupShutdown[$i].EventId; `
                                       "Event" = $event; `
                                        "User" = "System";
                                         }
    
}
Return $startupShutdownTable
}
#Testing the functions
loginLogoffEvents(100)
shutdownStartupEvents(100)