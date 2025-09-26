.(Join-Path $PSScriptRoot scrapingClasses.ps1)
$FullTable = daysTranslator(gatherClasses)
#$FullTable | Select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
#    Where {$_.Instructor -match "Furkan"}

#$FullTable | Where-Object { ($_.Location -match "Joyc 310") -and ($_.days -match "Monday")} |`
#    Sort-Object "Time Start" | Select "Time Start", "Time End", "Class Code"

$ITSInstructors = $FullTable | Where-Object {($_."Class Code" -match "SYS*") -or `
                                             ($_."Class Code" -match "NET*") -or `
                                             ($_."Class Code" -match "SEC*") -or `
                                             ($_."Class Code" -match "FOR*") -or `
                                             ($_."Class Code" -match "CSI*") -or `
                                             ($_."Class Code" -match "DAT*")}`
                             | Select-Object "Instructor" -Unique
#$ITSInstructors 

$FullTable | Where {$_.Instructor -in $ITSInstructors.Instructor} `
           | Group "Instructor" `
           | Select Count,name `
           | Sort-Object Count -Descending
