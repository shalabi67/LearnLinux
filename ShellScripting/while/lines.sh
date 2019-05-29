#!/usr/bin/env bash

#Write a shell script that asks the user for the number of lines they would like to display from the
#/etc/passwd file and display those lines.

read -p "Enter number of live tio shows: " lines
index=0
while read line
do
    if [[ $index -lt $lines ]]
    then
        echo $line
        ((index++))
    else
        break
    fi
done < /etc/passwd
