#!/bin/bash
#shows how to show file type
#for block file /dev/sda
#for a directory /dev
#for character file: /dev/pts/0
#executable /bin/bash
#plain text file /etc/fstab

if [ $# -eq 0 ]; then
    echo "you did not provide any arguments"
    echo "Usage: $(basename $0) <arg1> <arg2> ..."
    exit 1
fi

fileName="$1"

if [ -e "$fileName" ]; then
    echo -e "\n $fileName exists.\n"
    fileType=$(file "$fileName" | cut -d " " -f2)
    case $fileType in
        "ASCII")
            echo  -e "\n File: $fileName is a plain text file.\n"
        ;;
        "Bourne-Again")
            echo  -e "\n File: $fileName is a shell scripting.\n"
        ;;
        "ELF")
            echo  -e "\n File: $fileName is a executable.\n"
        ;;
        "directory")
            echo  -e "\n File: $fileName is a directory.\n"
        ;;
        "block")
            echo  -e "\n File: $fileName is a block.\n"
        ;;
        "character")
            echo  -e "\n File: $fileName is a character.\n"
        ;;
        *)
            echo -e "\n not defined. \n"
        ;;
    esac

else
    echo -e "\n $fileName does not exist.\n"
fi


