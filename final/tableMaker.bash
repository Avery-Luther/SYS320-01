#!/bin/bash

file="report.txt"

echo -e "<html>\n\t<head>\n\t\t<style> td {border: 1px solid black;}</style>\n\t</head>\n\t<body>\n\t\t<p>Access logs with IOC indicators:</p>\n\t\t<table>" > report.html
cat "$file" | sed 's/ / <\/td> <td> /g' \
	  | sed -e 's/^/\t\t\t<tr> <td> /' \
	  | sed -e 's/$/ <\/td><\/tr>/'>> report.html
echo -e "\t\t</table>\n\t</body>\n</html>" >> report.html

