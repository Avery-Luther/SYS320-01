$Scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

#$scraped_page.Links.Count
#$Scraped_page.links 
#$Scraped_page.links | Select outerText,href
#$h2s = $Scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select outerText
#$h2s

$divs1 = $Scraped_page.ParsedHtml.body.getElementsBytagName("div") | where {$_.getAttributeNode("class").value -ilike "div-1"} | select innerText
$divs1