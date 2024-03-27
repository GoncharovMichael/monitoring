#!/bin/bash

if [[ "$variety" -eq 1 ]]; then
	    echo "Файл с логами должен храниться в этой папке"
	    content=$(cat 02.log | awk '{print $2}' | tac)
	    if [ -e 02.log ]; then
		    echo "Файл найден. Скрипт запущен."
		    for delcontent in $content
		    do
			    echo "$delcontent" >> 03.log
			    rm -rf $delcontent
		    done
	    else
		    echo "Файл не найден"
	    fi
fi