#!/bin/bash
#shows how to use read into multiple variables

if [ $# -eq 0 ]; then
    echo "you did not provide any arguments"
else
    echo "you provided $# arguments. They are $@"
fi


if [ $# -eq 0 ]
then
    echo "you did not provide any arguments"
else
    echo "you provided $# arguments. They are $@"
fi




