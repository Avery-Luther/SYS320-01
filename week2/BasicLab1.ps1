# Getting the IPv4 Address from the Ethernet interface

Write-Host "Getting the IPv4 Address from the Ethernet interface"
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {($_.InterfaceAlias -ilike "Ethernet")}).IPAddress

# Getting the IPv4 prefix length from the Ethernet interface
Write-Host "`r`Getting the IPv4 prefix length from the Ethernet interface"
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {($_.InterfaceAlias -ilike "Ethernet")}).PrefixLength

# All of the Win32 libraries that start with 'net' sorted alphabetically
Write-Host "`r`All of the Win32 libraries that start with 'net' sorted alphabetically"
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_net*"} | Sort-Object 
 
# Geting thge DHCP server address and hiding the table headers
Write-Host "`r`Geting thge DHCP server address and hiding the table headers"
Get-CimInstance Win32_NetworkAdapterConfiguration | select DHCPServer | Format-Table -HideTableHeaders 

# Getting the DNS server IPs but only displaying the first
Write-Host "`r`Getting the DNS server IPs but only displaying the first"
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

# Getting all of the files in the working directory
Write-Host "`r`Getting all of the files in the working directory"
cd $PSScriptRoot

$files=(Get-ChildItem)

for ($j=0; $j -le $files.Length; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}


# Creating a folder called 'outfolder' if it doesn't exist 
Write-Host "Creating a folder called 'outfolder' if it doesn't exist"
$folderpath="$PSScriptRoot\outfolder"
if (Test-Path -Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -Path $folderpath -ItemType Directory
}


# Listing all of the files in my current directory with a '.ps1' file extension, then outputing the results to a csv. 
Write-Host "Listing all of the files in my current directory with a '.ps1' file extension, then outputing the results to a csv."
$FilePath = New-Item -ItemType File -Path $folderpath -Name "out.csv"
$files | Where-Object Extension -eq ".ps1" | Export-Csv -Path $FilePath

# Recursivly finding all of the subdirectories  and replacing all '.csv' file extensions with '.log'
Write-Host "Recursivly finding all of the subdirectories  and replacing all '.csv' file extensions with '.log'"
$files = Get-ChildItem -Recurse -File
$files |  Rename-Item -NewName {$_.Name -replace '.csv','.log'}
Get-ChildItem -Recurse -File 