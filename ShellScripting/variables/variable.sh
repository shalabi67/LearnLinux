#!/bin/bash
#shows how to access environment variables
#see the use of $(command) to get the value of a command into variable.
#my_name=mohammad

name=$USER #no spaces at all.
first_name=$(cat /etc/passwd | grep mohammad | awk -F : '{print $5}' | cut -d "," -f1)
echo "Hello $name  $first_name" #shows variable


