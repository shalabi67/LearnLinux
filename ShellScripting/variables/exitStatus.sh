#!/bin/bash
#show the exit status variables and command
#${?} get the last command status. the variable ? holds the last command status.
#exit exit shill script and return the last command status.
#exit n return n to the shell
#shows how to use string compare

#this script require normal access
if [[ ${UID} -lt "1000" ]]
then
    echo 'You are a system user. please, login in as normal user.'
    exit 1
fi

echo "The script is running as user: $(id -un)"

#show the use of ? variable
result=$(ifconfig)  #$(ip a s)
if [[ "${result}" -ne 0 ]]
then
    echo 'could not get network interface'
fi


#show how to use string compare
shalabi='mshalabi'
userName=$(id -un)
if [[ "${userName}" = "${shalabi}" ]]
then
    echo "Welcome ${shalabi}"
else
    echo "This script can run only by ${shalabi}."
    exit 2
fi