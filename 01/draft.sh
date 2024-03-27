#!/bin/bash

# Проверка наличия необходимого количества аргументов
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <absolute_path> <nested_folders_count> <folder_letters> <files_count> <file_letters> <file_size_kb>"
    exit 1
fi

# Проверка наличия достаточного места на диске
required_space_kb=$(( $4 * $2 * $6 ))
available_space_kb=$(df -k --output=avail / | tail -n 1)
if [ "$required_space_kb" -gt "$available_space_kb" ]; then
    echo "Not enough space on disk."
    exit 1
fi

# Генерация случайной даты в формате DDMMYY
date=$(date +"%d%m%y")

# Функция для создания случайного имени
generate_name() {
    local length=$((RANDOM % 4 + 4)) # Случайная длина имени от 4 до 7 символов
    local letters=$1
    local name=""

    for (( i=0; i<$length; i++ )); do
        random_index=$((RANDOM % ${#letters}))
        name="${name}${letters:$random_index:1}"
        letters=${letters:0:$random_index}${letters:$((random_index + 1))}
    done

    echo "${name}_${date}"
}

# Функция для создания папок и файлов
create_folders_and_files() {
    local path=$1
    local nested_count=$2
    local folder_letters=$3
    local files_count=$4
    local file_letters=$5
    local file_size_kb=$6

    mkdir -p "$path"
    cd "$path" || exit 1

    local folder_name=$(generate_name "$folder_letters")
    mkdir -p "$folder_name"
    cd "$folder_name" || exit 1

    for (( i=0; i<$files_count; i++ )); do
        local file_name=$(generate_name "$file_letters")
        local file_extension=$(generate_name "$file_letters")
        dd if=/dev/zero of="$file_name.$file_extension" bs=1024 count="$file_size_kb" &>/dev/null
        echo "$(date +"%Y-%m-%d %H:%M:%S") | $(realpath "$file_name.$file_extension") | Size: ${file_size_kb}KB" >> "$log_file"
    done

    if [ "$nested_count" -gt 1 ]; then
        for (( j=1; j<$nested_count; j++ )); do
            create_folders_and_files "$(generate_name "$folder_letters")" "$((nested_count - 1))" "$folder_letters" "$files_count" "$file_letters" "$file_size_kb"
        done
    fi
}

# Инициализация переменных
absolute_path="$1"
nested_folders_count="$2"
folder_letters="$3"
files_count="$4"
file_letters="$5"
file_size_kb="$6"
log_file="$absolute_path/script_log.txt"

# Создание папок и файлов
create_folders_and_files "$absolute_path" "$nested_folders_count" "$folder_letters" "$files_count" "$file_letters" "$file_size_kb"
