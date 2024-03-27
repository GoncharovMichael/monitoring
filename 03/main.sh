#!/bin/bash

echo -e "Введите путь до файла с логами"
read url

. argument_checking.sh
. adding_logfile.sh
. delete_files_catalogs_1.sh
. delete_files_catalogs_2.sh
. delete_files_catalogs_3.sh