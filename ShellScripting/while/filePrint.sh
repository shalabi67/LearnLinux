#!/bin/bash

#Write a shell script that loops through the /etc/passwd file one line at a time. Prepend each line
#with a line number followed by a colon and then a space.

index=1
while read line
do
  echo "${index}: $line"
  ((index++))
done < /etc/passwd


#another solution which display root records
index=1
grep root /etc/passwd | while read line
do
    echo "${index}: $line"
    ((index++))
done
