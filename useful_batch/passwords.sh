#!/bin/bash
# seven fields from /etc/passwd stored in $f1,f2...,$f7
#
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7 f8
do
type=${f2:0:3}
if [ "$type" = "\$1\$" ]; then
    type="MD5"
elif [ "$type" = "\$2a\$" ]; then
         type="Blowfish"
elif [ "$type" = "\$2y\$" ]; then
         type="Blowfish"
elif [ "$type" = "\$5\$" ]; then
         type=" SHA-256"
elif [ "$type" = "\$6\$" ]; then
         type="SHA-512"
else
   type="*"
fi
 echo "User $f1 encryption type $type"
 #echo "warn days befor expire:$f6 days left before the user is allowed to change his/her password $f4"
 #echo "Last changed: $f3 The maximum number of days the password is valid: $f5"
 #echo "when the login may no longer be used: $f8"
done < /etc/shadow
