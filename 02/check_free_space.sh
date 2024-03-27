#!/bin/bash

size=$(df -k / | awk 'NR==2 {print $4}')
if [[ $size -le 1048576 ]]; then
	echo "На диске осталось меньше одного ГБ памяти, поэтому скрипт остановлен!"
	if [ -f 02.log ]; then
		dateend=$(date +%s)
		datetotal=$((dateend-datestart))
		echo "Завершение-$(date +"%D-%T"). Время работы скрипта: $datetotal секунд." >> 02.log
		fi
	exit 1
	fi