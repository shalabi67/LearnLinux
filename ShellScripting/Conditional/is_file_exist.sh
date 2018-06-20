#!/bin/bash
#shows how to use read into multiple variables

if [ $# -eq 0 ]; then
    echo "you did not provide any arguments"
    echo "Usage: $(basename $0) <arg1> <arg2> ..."
    exit 1
fi

fileName="$1"

if [ -e $fileName ]; then
    echo -e "\n $fileName exists.\n"
else
    echo -e "\n $fileName does not exist.\n"
fi


