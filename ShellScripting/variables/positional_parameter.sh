#!/bin/bash
#shows how to access enviromen variables
#my_name=mohammad

echo "$# is the total number of arguments."
echo "$* all arguments."
echo -e "\nThe first parameter $1 the second parameter $2.\n"
param3=$3
echo -e "The third parameter $param3"

shift 2  # shift arguments to left by 2
echo "shifting by 2"
echo "$# is the total number of arguments."
echo "$* all arguments."
echo -e "\nThe first parameter $1 the second parameter $2.\n"




