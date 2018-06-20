#!/bin/bash
#shows how to use read

read -p "Enter first number: " value1
echo
read -p "Enter second number: " value2
echo
read -p "Press enter when you ready to see the result ..."
echo
let answer=$value1*$value2
echo
echo "The multiplication of $value1 and $value2 is $answer"


