#!/bin/bash
# seven fields from /etc/passwd stored in $f1,f2...,$f7
#
grep /usr/sbin/nologin /etc/passwd > nologin_list.txt
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
 echo "$f1"
done < nologin_list.txt
