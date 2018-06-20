#!/bin/bash
#shows how to use while

counter=10
while [ $counter -gt 0 ] ; do
    echo -e "$counter \n"
    let counter=$counter-1
done



