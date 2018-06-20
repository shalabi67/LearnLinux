#!/bin/bash
#print all input arguments

if [ $# -eq 0 ]; then
    echo "you did not provide any arguments"
    echo "Usage: $(basename $0) <arg1> <arg2> ..."
    exit 1
fi

for arg in $@ ; do
    echo -e "$arg\n"
done

echo -e "another way \n"
for arg ; do
    echo -e "$1\n"
    shift
done

