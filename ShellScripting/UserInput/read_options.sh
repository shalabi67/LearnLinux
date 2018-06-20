#!/bin/bash
#shows how to use read

read -p "Enter first number: " value1
echo
read -p "Enter second number: " value2
echo
#-n1 read single character
#-s do not show what user input. thisn is good for password input
read -s -n1 -p "Press any key when you ready to see the result ..."
echo
let answer=$value1*$value2
echo
echo "The multiplication of $value1 and $value2 is $answer"


