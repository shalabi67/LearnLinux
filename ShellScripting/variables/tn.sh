#!/bin/bash
 
# Simple note-taking script
# you can use it as  ./tn.sh [topic]
# you can use it as  ./tn.sh
# you can use it as  ./tn.sh my
# Author: reindert

# this shows how to get a command into variable. the command here is date and variable is date.
# get the date
date=$(date)

#shows how to get the first command argument.
# get the topic
topic="$1"

#shows the important of using {} with variable name.
# filename to write to
filename="${HOME}/${topic}notes.txt"

# Ask user for input
read -p "Your note: " note

echo "$date: $note" >> "$filename"
echo "Note '$note' saved to $filename"
