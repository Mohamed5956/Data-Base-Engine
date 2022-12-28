shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a valuesOfColumn

# IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
# feilds=($(sed -n '1p' $name))

# len=${#feilds[@]}


select choice in TruncateTable deleteSingleRecord
do 
    case $choice in
        TruncateTable )
        read -p "Enter Table you want to truncate : " name
        if [[ -e $name ]];then
            sed -i '3,$d' $name
            echo "All Data Deleted :) ";
        else
           echo "there's no table found"
        fi
        ;;
        deleteSingleRecord )
        read -p "Delete From  table : " name
        flag=0
        if [[ -e $name && $flag == 0 ]];then
            read -p "where column : " column
            IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
            for (( i=0 ;i<$len; i++ ))
            do 
                # echo ${feilds[@]}
                # echo ${feilds[1]}
                # echo $len
                # echo $column
                if [[ $column == ${feilds[$i]} ]];then
                    read -p "$column = " value
                    ((i++));
                    echo "iteration : " $i;
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    echo ${valuesOfColumn[@]}
                    for ((j=0 ;j<${#valuesOfColumn[@]}; j++))
                    do
                        if [[ $value == ${valuesOfColumn[$j]} ]];then
                            let c=$j+3
                            echo $c
                            sed -i ''"$c"d'' $name
                        fi
                    done
                fi
            done
            
            echo "Data Deleted :) ";
        else
            echo "there's no table found"
        fi
        ;;
    esac
done