#!/bin/bash
#shows how to show menu

options="option1 option2 option3 option4"

select choice in $options ; do
    echo "Reply variable is $REPLY"
    echo "choice is $choice"

    case $REPLY in
    "1")
    echo "selected option 1"
    break
    ;;
    "2")
    echo "selected option 2"
    break
    ;;
    "3")
    echo "selected option 3"
    break
    ;;
    "4")
    echo "selected option 4"
    break
    ;;
    *)
    echo "Invalid selection."
    ;;

    esac
done
