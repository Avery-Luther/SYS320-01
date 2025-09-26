function gatherClasses($things){
$page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses2025FA.html
$trs = $page.parsedhtml.body.getElementsBytagName("tr")
$fullTable = @()
   for($i=1; $i -lt $trs.length; $i++){
   $tds = $trs[$i].getElementsByTagName("td")
   $Times = $tds[5].innerText.split("-")
   
   # This bit was not in the assignment but durring deliverable 3 I found that dates
   # were in as instructors. This offset variable detects this error and corrects for it.
   if($tds[6].innerText -ilike "8/25 - 12/12"){ $Offset = -1}
   else {$Offset = 0}
   
   $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText;`
                                   "Title"      = $tds[1].innerText;`
                                   "Days"       = $tds[4].innerText;`
                                   "Time Start" = $Times[0];`
                                   "Time End"   = $Times[1];`
                                   "Instructor" = $tds[6 + $Offset].innerText;`
                                   "Location"   = $tds[9 + $Offset].innerText;`
                                   }
        }
   return $fullTable
}

function daysTranslator($FullTable){
    for($i = 0; $i -lt $FullTable.length; $i++){
        $Days = @()
        
        if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday"}
        if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}
        elseif($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday"}
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}
        if($FullTable[$i].Days -ilike "*F"){ $Days += "Friday"}
        $FullTable[$i].Days = $Days
    }
    return $FullTable
}