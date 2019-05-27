#!/bin/bash

message="Shell Scripting is Fun!"
echo ${message}

hostName=$(hostname)
echo "This script is running on ${hostName}"

if [[ -e /etc/shadow ]]
then
    echo 'Shadow passwords are enabled.'
fi

if [[ -w /etc/shadow ]]
then
    echo 'You have permissions to edit /etc/shadow.'
else
   echo 'You do not have permissions to edit /etc/shadow.'
fi

list="man bear pig dog cat"
for item in $list
do
    echo ${item}
done


#read -p "Enter file or directory name: " name
for name in $*
do
    if [[ -f $name ]]
    then
        echo "${name} is a file"
        ls -l ${name}
    elif [[ -d $name ]]
    then
        echo "${name} is a directory"
        ls -l ${name}
    else
        echo "${name} is not a file or directory"
    fi
done


