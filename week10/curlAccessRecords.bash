#!/bin/bash

file="/var/log/apache2/access.log"
function countingCurlAccess () {
results=$(cat "$file" | cut -d' ' -f1,12 | grep "curl" | sort | uniq -c)
}
countingCurlAccess
echo "$results"
