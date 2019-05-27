#!/bin/bash

function file_count() {
    if [[ -d $1 ]]
    then
        local count=$(ls $1 | wc -l)
        echo $count
    else
        echo "Please provide a directiry"
    fi
}

file_count
