# Инициализация переменных

# main.sh /opt/test 4 az 5 az.az 3kb

# Параметр 1 - это абсолютный путь. 
# Параметр 2 - количество вложенных папок. 
# Параметр 3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). 
# Параметр 4 - количество файлов в каждой созданной папке. 
# Параметр 5 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). 
# Параметр 6 - размер файлов (в килобайтах, но не более 100).

absolute_path="$1"
nested_folders_count="$2"
folder_letters="$3"
files_count="$4"
file_letters="$5"
file_size_kb="$6"
log_file="$absolute_path/script_log.txt"

# Проверка наличия необходимого количества аргументов
if [[ "$#" -ne 6 ]]; then
    echo "Скрипт: $0 не будет работать без 6 аргументов <абсолютный путь> <число вложенных папок> <буквы> <число файлов> <список букв английского алфавита, используемый в имени файла и расширении> < размер файлов >"
    echo "Пример: main.sh ~/ 4 az 5 az.az 3kb"
    exit 1
    elif [ "$#" -eq 6 ]; then
        echo "Проверка кол-ва аргументов пройдена"
fi

required_space_kb=$(( $4 * $2 * $6 ))
available_space_kb=$(df -k --output=avail / | tail -n 1)
if [ "$required_space_kb" -gt "$available_space_kb" ]; then
    echo "На диске меньше 1 гб памяти"
    exit 1
    elif [ "$required_space_kb" -lt "$available_space_kb" ]; then
    echo "проверка памяти пройдена"
fi

date=$(date +"%d%m%y")
echo "Дата запуска скрипта: $date"

generate_name() {
    local length=$((RANDOM % 4 + 4))
    local letters=$1
    local name=""

    for (( i=0; i<$length; i++ )); do
        random_index=$((RANDOM % ${#letters}))
        name="${name}${letters:$random_index:1}"
        letters=${letters:0:$random_index}${letters:$((random_index + 1))}
    done

    echo "${name}_${date}"
}
generate_name 