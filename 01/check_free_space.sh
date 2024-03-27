#!/bin/bash

size=$(df -k / | awk 'NR==2 {print $4}')
if [[ $size -le 1048576 ]]; then
	echo "На диске меньше 1 ГБ памяти, поэтому скрипт остановлен"
	exit 1
fi