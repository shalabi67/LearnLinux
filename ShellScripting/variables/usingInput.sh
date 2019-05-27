#!/bin/bash
#This will create a user by prompting the user for user name and password.

#Enter user name
read -p 'Username: ' userName

#Enter real name
read -p 'Real name: ' realName


#Enter password
read -p 'password:' password


#create user
useradd -m -c "${relName}" ${userName}


#set user password
echo ${password} | passwd --stdin ${userName}

#force user to change password first time they login.
