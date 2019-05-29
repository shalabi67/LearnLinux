#!/bin/bash

#read -p "Enter command(start or stop): " command
case "$1" in
    start)
        echo 'starting server'
    ;;
    stop)
        echo 'stopping server'
    ;;
    *)
    echo 'usage progarm start | stop'
    ;;
esac
