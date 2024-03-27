#!/bin/bash

if [[ "$variety" -eq 2 ]]; then
	echo -e "Чтобы удалить файлы, необходимо ввести диапазон дат."
	echo -e "Введите дату и время в формате YYYY-MM-DD HH:MI:SS : "
	read firstdate;
	if [[ -z  "$firstdate" ]]; then
        echo "EПустое значение, скрипт завершен."
		exit 1
    fi
	echo -e "Введите дату и время в формате YYYY-MM-DD HH:MI:SS : "
	read secondate;
	if [[ -z  "$secondate" ]]; then
        echo "Пустое значение, скрипт завершен."
		exit 1
    fi
	echo "Даты введены! Скрипт запущен."
	v=0

	for url in $(find / -name '*_*' -type d -not -path  '*sbin*' -not -path '*bin*' -newerct "$firstdate" ! -newerct "$secondate" 2>/dev/null)
	do
		((v++))
		echo "$url" >> 03.log
		rm -rf "$url";
	done
fi