#!/bin/bash

link="10.0.17.47/Assignment.html"

fullPage=$(curl -sL "$link")

tables=$(echo "$fullPage" | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --copy-of "/html/body/table/tr" 2>/dev/null)

echo "$tables" | sed 's/<\/tr>//g' \
	       		 | sed '/<tr>/d' \
	                 | sed 's/&#13//g' \
	                 | sed '/<\/th>/d' \
	                 | sed 's/<td>//g' \
	                 | sed 's/<\/td>//g' \
	                 | sed 's/\t\t//g' \
			 | sed 'N;s/;\n/ /g' \
			 | sed '$d'\
			 | sed 's/-6:/-06:/g'\
			 | sort -b -k 2.17 -k 2.12,2.13 -k 2.15,2.16 \
			 | sed 'N;s/;\n/ /g' \
			 | awk '{print $1 " " $3 " " $2 " "}'
