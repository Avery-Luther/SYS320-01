#!/bin/bash

link="10.0.17.47/IOC.html"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
	xmlstarlet format --html --recover 2>/dev/null | \
	xmlstarlet select --template --copy-of "//html//body//table//tr" 2>/dev/null)

echo "$toolOutput" | sed 's/<\/tr>//g' \
		   | sed '/<tr>/d' \
		   | sed 's/&#13//g' \
		   | sed '/<\/th>/d' \
		   | sed 's/<td>//g' \
		   | sed 's/<\/td>//g' \
		   | sed 's/\t\t//g' \
		   | sed 'N;s/;\n/ /g' \
		   | sed '$d' \
		   | awk '{print $1}' > IOC.txt
