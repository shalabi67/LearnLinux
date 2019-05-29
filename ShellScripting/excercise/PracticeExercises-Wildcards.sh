#!/bin/bash
#usage command [directoryName]

#excercise 1
#rename files with specific extension to include date at the beginning of the file name.
function renameFiles() {
    echo "renaming files with : $1"
    local dateString=$(date +%Y-%m-%d)
    for fileName in $1
    do
        mv $fileName "${dateString}${fileName}"
    done

}

#run command to create a set of png files: touch {a..g}.png
renameFiles '*.png'


#excercise 2

#read files extension
read -p "Enter file extension(*.png): " fileExtension
renameFiles "${fileExtension}"
