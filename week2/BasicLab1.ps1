#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {($_.InterfaceAlias -ilike "Ethernet")}).IPAddress
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {($_.InterfaceAlias -ilike "Ethernet")}).PrefixLength
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_net*"} | Sort-Object 
 
#Get-CimInstance Win32_NetworkAdapterConfiguration | select DHCPServer | Format-Table -HideTableHeaders 
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet"}).ServerAddresses[0]

cd $PSScriptRoot

$files=(Get-ChildItem)

for ($j=0; $j -le $files.Length; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

$folderpath="$PSScriptRoot\outfolder"
if (Test-Path -Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
    New-Item -Path $folderpath -ItemType Directory
}
