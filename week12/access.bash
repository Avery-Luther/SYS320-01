#! /bin/bash

logline="File was accessed $(date)"
echo $logline >> fileaccesslog.txt

echo "To: avery.luther@mymail.champlain.edu" > emailform.txt
echo 'Subject: File Accessed' >> emailform.txt
echo '' >> emailform.txt
cat fileaccesslog.txt >> emailform.txt
cat emailform.txt | ssmtp avery.luther@mymail.champlain.edu
