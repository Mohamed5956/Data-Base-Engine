shopt -s extglob
export LC_COLLATE=C

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
        read -p "Delete From  table : " name
        flag=0
        if [[ -e $name ]]; then
            read -p "where column : " column
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
            findCounter=0
            declare -i counter=0
            for ((i = 0; i < $len; i++)); do
                if [[ $column == ${feilds[$i]} ]]; then
                    read -p "$column = " value
                    ((i++))
                    # echo "iteration : " $i;
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    # echo ${valuesOfColumn[@]}
                    for ((j = 0; j <= ${#valuesOfColumn[@]}; j++)); do
                        if [[ $value == ${valuesOfColumn[$j]} ]]; then
                            let c=$j+3
                            findedValues[$findCounter]=$c
                            let findCounter=$findCounter+1
                            f=1
                        fi
                    done
                fi
            done
            
            # to shift the file then sed the file
            if ((${#findedValues[@]})); then
                for ((k = 0; k < $findCounter; k++)); do
                    $(sed -i "${findedValues[$k]}d" $name)
                    for ((m = $k; m < $findCounter; m++)); do
                        let counter=${findedValues[$m]}-1
                        findedValues[$m]=$counter
                    done
                done
                
            else
                f=0
            fi
            if [[ $f == 1 ]]; then
                echo 'Data Deleted Successfully'
            else
                echo 'column or value not found'
            fi
        else
            echo "there's no table found"
        fi
        ;;
    esac
done
