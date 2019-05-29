#!/bin/bash

# to run this script use: ./commandArgs.sh arg1 arge2
# get parameters by number
arg1=$1
arg2=$2
argsNumber=$#
processNumber=$$
echo "The first argument is ${arg1}"
echo "The second argument is ${arg2}"
echo "The number of arguments is ${argsNumber}"
echo "The process number is ${processNumber}"


# to run this script use: ./commandArgs.sh arg1 arge2 arg3 arg4
# show how to use $* and $@
allArgs="$@"
echo "$*"
echo "$@"
echo "${allArgs}"

#print all args
for arg in $*
do
    echo ${arg}
done
