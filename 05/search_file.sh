#!/bin/bash

IFS=$'\n'
#echo -e "Enter the address where the files are located."
#read url
content=$(cat access1.log <(echo) access2.log  <(echo) access3.log <(echo) access4.log <(echo) access5.log)
count=0
#if [ ! -e "$url"access1.log ]; then
#        echo "Files not found!"
#        exit 1
#else
echo "The script is running!"

#fi
