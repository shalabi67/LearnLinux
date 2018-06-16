#!/bin/bash
# seven fields from /etc/passwd stored in $f1,f2...,$f7
#
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
 echo "User $f1 use $f7 shell and stores files in $f6 directory. groupdId:$f4"
done < /etc/passwd
