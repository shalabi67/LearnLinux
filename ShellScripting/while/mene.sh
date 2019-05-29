#!/usr/bin/env bash

#Write a shell script that that allows a user to select an action from the menu. The actions are to
#show the disk usage, show the uptime on the system, and show the users that are logged into
#the system. Tell the user to enter q to quit. Display "Goodbye!" just before the script exits.
#If the user enters anything other than 1 , 2 , 3 , or q , tell them that it is an "Invalid option."
#You can show the disk usage by using the df command. To show the uptime, use the uptime
#command. To show the users logged into the system, use the who command. Print a blank
#line after the output of each command.

while true
do
    read -p "Select 1)show disk usage 2)show system up time 3)show logged in users q)quit" option
    case "$option" in
        1)
        df
        ;;
        2)
        uptime
        ;;
        3)
        who
        ;;
        q)
        break
        ;;
    esac
done
