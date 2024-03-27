#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Принимается только один аргумент"
    exit 1
fi

variety=$1

if [[ ! "$variety" =~ [0-9]+$ ]]; then
    echo "Введи число от 1-го до 3-ех"
    exit 1
fi

if [[ "$variety" -gt 4 ]]; then
	echo "Принимается только один аргумент"
	exit 1
fi