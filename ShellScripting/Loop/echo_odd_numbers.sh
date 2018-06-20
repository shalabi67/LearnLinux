#!/bin/bash
#shows how to use continue by print odd numbers

for i in 10 9 8 7 6 5 4 3 2 1 ; do
    result=$(expr $i % 2)
    if [ $result -eq 0 ] ; then
        continue
    fi
    echo -e "$i\n"
done



