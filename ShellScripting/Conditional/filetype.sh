#!/bin/bash
#shows how to show file type
#for block file /dev/sda
#for a directory /dev
#for character file: /dev/pts/0

if [ $# -eq 0 ]; then
    echo "you did not provide any arguments"
    echo "Usage: $(basename $0) <arg1> <arg2> ..."
    exit 1
fi

fileName="$1"

if [ -e "$fileName" ]; then
    echo -e "\n $fileName exists.\n"
    if [ -d "$fileName" ] ; then
        echo  -e "\n File: $fileName is a directory.\n"
    elif [ -f "$fileName" ]; then
        echo -e "\nFile: $fileName is a regular file.\n"
    elif [ -c "$fileName" ]; then
        echo -e "\nFile: $fileName is a character file.\n"
    elif [ -b "$fileName" ]; then
        echo -e "\nFile: $fileName is a block file.\n"
    else
        echo -e "\n undefined file type for file $fileName."
    fi
else
    echo -e "\n $fileName does not exist.\n"
fi


