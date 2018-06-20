#!/bin/bash
#shows how to access enviromen variables
#my_name=mohammad

name=$USER #no spaces at all.
first_name=$(cat /etc/passwd | grep mohammad | awk -F : '{print $5}' | cut -d "," -f1)
echo "Hello $name  $first_name" #shows variable


