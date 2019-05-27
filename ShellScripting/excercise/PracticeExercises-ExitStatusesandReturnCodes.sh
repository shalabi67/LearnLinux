#!/bin/bash
echo "useage file.sh fileOrDirectoryName"

#to test this scrip after running it run echo $? and you should se 0
#echo 'This script will exit with a 0 exit status.'
#exit 0

fileName=$1
if [[ -d $fileName ]]
then
    echo "${fileName} is a directory"
    exit 1
elif [[ -f $fileName ]]
then
    echo "${fileName} is a file"
    exit 0
else
    echo "${fileName} is a not file or directory"
#    exit 2
fi

cat /etc/shadow
if [[ $?=0 ]]
then
    echo 'Command succeeded'
    exit 0
else
    echo 'Command failed'
    exit 1
fi
