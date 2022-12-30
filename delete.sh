shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a valuesOfColumn
declare -a findedValues
declare -i findCounter=0
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
        read -p "Delete From  table : " name
        flag=0
        if [[ -e $name ]]; then
            read -p "where column : " column
            IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
            declare -i counter=0
            if [[ $column == ${feilds[$i]} ]]; then
                for ((i = 0; i < $len; i++)); do
                    read -p "$column = " value
                    ((i++))
                    # echo "iteration : " $i;
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    # echo ${valuesOfColumn[@]}
                        for ((j = 0; j <= ${#valuesOfColumn[@]}; j++)); do
                            if [[ $value == ${valuesOfColumn[$j]} ]]; then
                                if ! [[ ${valuesOfColumn[0]} =~ $intRegex ]]; then
                                    let c=$j+3
                                    # echo $c
                                    # echo "im string"
                                    # $(sed -i "/"$value"/d" $name)
                                else
                                    let c=$j+3
                                    # echo $c
                                    findedValues[$findCounter]=$c
                                    let findCounter=$findCounter+1
                                fi
                            fi
                        done
                done
            else
            echo "there's no column found"
            echo "the feilds are : "
            echo ${feilds[@]}
            delete.sh
            fi
            f=0
            # to shift the file then sed the file
            if ((${#findedValues[@]}));then
                for ((k = 0; k < $findCounter; k++)); do
                    $(sed -i "${findedValues[$k]}d" $name)
                    for ((m = $k; m < $findCounter; m++)); do
                        let counter=${findedValues[$m]}-1
                        findedValues[$m]=$counter
                    done
                done
                f=1
                else
                f=0
            fi
            echo $f
            if [[ $f == 1 ]];then
                echo 'Data Deleted Successfully'
                # echo ${findedValues[@]} 
                findedValues=()
            else
                echo 'value not found'
            fi
        else
            echo "there's no table found"
        fi
        ;;
    esac
done
