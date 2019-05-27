#!/bin/bash

#Dispaly the user id and user name for the user executing this script.
#Identify i the user is a root user or not.


#Dispaly user id
echo "User id is ${UID}"


#Dispaly user name
userName=$(id -un)
echo "User name is ${userName}"


#is user a root user. root user has id = 0
if [[ "${UID}" -eq 0 ]]
then
    echo 'You are root.'
else
    echo 'You are not root.'

fi
