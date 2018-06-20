#!/bin/bash
#shows how to use reply and read

read -s -p "Enter your password: "
# since we did not specify a value after read command it will read to $REPLY
echo
echo "You entered $REPLY"



