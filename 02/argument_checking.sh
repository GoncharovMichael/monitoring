#!/bin/bash

if [[ $# -ne 3 ]]
then
    echo "Требуется 3 аргумента"
    exit 1
    fi

 #Параметр 1 - список букв английского алфавита,
 # проверка: используемый в названии папок (не более 7 знаков). 
#Параметр 2 - список букв английского алфавита, используемый в имени файла и расширении 
# проверка: (не более 7 знаков для имени, не более 3 знаков для расширения). 
# Параметр 3 - размер файла 
# проверка(в Мегабайтах, но не более 100).

abcdir=$1
len1=${#abcdir}

if [[ ! "$abcdir" =~ [A-Za-z]+$ ]]; then
    echo "Ошибка в 1-ом аргументе. Введите только английские буквы"
    exit 1
    fi

# Длина этой части имени должна быть от 5 знаков
if [ $len1 -le 4 ]; then
    echo "Ошибка в 1-ом аргументе. Введите более 5ти символов"
    exit 1
    fi

if [ $len1 -gt 7 ]; then
    echo "Ошибка в 1-ом аргументе. Вы ввели больше 7ми символов"
    exit 1
    fi
if [[ ! "$abcdir" =~ [A-Za-z]+$ ]]; then
    echo "Ошибка в 1-ом аргументе. Введите английские буквы"
    exit 1
    fi

for (( w=0; w<$len1; w++ )); do
	z=1+$w
	for (( ; z<$len1; z++ )); do
	first=${abcdir:$w:1}
	second=${abcdir:$z:1}
		if [[ $first == $second ]]; then
			echo "Ошибка в 1-ом аргументе. Две одинаковые буквы в параметрах вводить нельзя."
			exit 1
			fi
		done
	done	

abcfile=$2
filename=${abcfile%.*}
len2=${#filename}
extension=${abcfile##*.}
len3=${#extension}
len3=${#extension}
len4=${#abcfile}
w=0
for (( q=0; q < len4; q++ ))
do
	filenamesearch=${abcfile:q:1}
	if [[ $filenamesearch  == '.' ]]; then
		((w++));
		fi
	if [[ $w  -ge 2 ]]; then
		echo "Ошибка в 2-ом аргументе. Нельзя ставить больше 1-ой точки."
    	exit 1
    	fi
done

if [[ ! "$abcfile" =~ ^[A-Za-z.]+$ ]]; then
    echo "Ошибка в 2-ом аргументе. Для расширения необходимо ввести английские буквы и точку."
    exit 1
    fi

if [[ $w -eq 0 ]]; then
	echo "Ошибка в 2-ом аргументе. Вы не ввели расширение для двух аргументов."
	exit 1
	fi

if [ $len2 -le 4 ]; then
    echo "Ошибка в 2-ом аргументе. Вы ввели менее 5 символов."
    exit 1
    fi

if [ $len2 -gt 7 ]; then
    echo "Ошибка в 2-ом аргументе. Вы ввели больше 7ми символов для filename"
    exit 1
    fi

for (( o=0; o<$len2; o++ )); do
	p=1+$o
	for (( ; p<$len2; p++ )); do
	first=${filename:$o:1}
	second=${filename:$p:1}
		if [[ $first == $second ]]; then
			echo "Ошибка во 2-ом аргументе. Замените дубликаты в параметрах"
			fi
		done
	done

if [ $len3 -eq 0 ]; then
    echo "Ошибка во 2-ом аргументе. Вы не ввели английские буквы для расширения."
    exit 1
    fi

if [ $len3 -gt 3 ]; then
    echo "Ошибка во 2-ом аргументе. Вы ввели более 3 символов для расширения."
    exit 1
    fi
	
if [[ ! "$abcfile" =~ ^[A-Za-z.]+$ ]]; then
    echo "Ошибка во 2-ом аргументе. Для расширения необходимо ввести английские буквы и точку."
    exit 1
    fi

    
size=$3
len5=${#size}
len6=$((len5-2))
kilobytes=${size:len6:2}

filesize=${3%??}
if [[ ! "$filesize" =~ ^[0-9,]+$ ]]; then
    echo "Ошибка во 3-ем аргументе. Вы должны вводить числа (до 100) и запятую, если число имеет плавающую точку."
    exit 1
    fi
if [[ "$filesize" -gt 100 ]]; then
	echo "Ошибка во 3-ем аргументе. Необходимо ввести размер файла не более 100 МБ."
	exit 1
	fi
if [[ "$kilobytes" != "mb" ]]; then
	echo "Ошибка во 3-ем аргументе. Необходимо ввести размер файлов в мегабайтах."
	exit 1
	fi

filename2=$filename

#cat 02.log | awk '{print $2}'