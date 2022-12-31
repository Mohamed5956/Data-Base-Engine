shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a valuesOfColumn
declare -a findedValues
declare -i findCounter=0
declare -i NofColumn=0
intRegex='^[0-9]+$'
select choice in TruncateTable deleteSingleRecord; do
    case $choice in
    TruncateTable)
        read -p "Enter Table you want to truncate : " name
        if [[ -e $name ]]; then
            sed -i '3,$d' $name
            echo "All Data Deleted :) "
        else
            echo "there's no table found"
        fi
        ;;
    deleteSingleRecord)
        flag2=0
        flag=0
        read -p "Delete From  table : " name
        if [[ -e $name ]]; then
            feilds=($(sed -n '1p' $name))
            echo ${feilds[@]}
            len=${#feilds[@]}
            read -p "where column : " column
            for ((i = 0; i < $len; i++)); do
                if [[ $column == ${feilds[$i]} ]]; then
                    flag2=1
                    NofColumn=$i+1
                    break
                fi
            done
            if [[ $flag2 == 1 ]]; then
                echo "column found"
                valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$NofColumn))
                echo ${valuesOfColumn[@]}
                read -p "$column = " value
                for ((j = 0; j < ${#valuesOfColumn[@]}; j++)); do
                    if [[ $value == ${valuesOfColumn[$j]} ]]; then
                        let c=$j+3
                        $(sed -i "$c"d $name)
                        echo 'Data Deleted Successfully'
                        flag=1
                    fi
                done
                if [[ $flag == 0 ]]; then
                    echo "Value Not founded"
                fi
            else
                echo "column not found"
            fi
        else
            echo "there's no table found"
        fi
        ;;
    esac
done
