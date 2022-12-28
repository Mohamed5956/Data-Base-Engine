shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a valuesOfColumn
intRegex='^[0-9]+$'

read -p "update from Table : " name
feilds=($(sed -n '1p' $name))
len=${#feilds[@]}

if [[ -f $name ]];then
    read -p "set : " column
    flag=0
    for (( i=0 ;i<$len; i++ ))
        do 
            if [[ $column == ${feilds[$i]} ]];then
                read -p "$column = " value
                ((i++));
                echo "iteration : " $i;
                valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                echo ${valuesOfColumn[@]}
                    for ((j=0 ;j<${#valuesOfColumn[@]}; j++))
                    do
                # sed -i "s/$value/$newValue/g" $name
                        if [[ $value == ${valuesOfColumn[$j]} ]];then
                            read -p "enter your new value" newValue
                            # let c=$j+3
                        # echo $c
                            sed -i "s/$value/$newValue/g" $name
                        fi
                    done
                fi
            done
else 
echo "table not found"
fi


# update from tableName
# set id = dgfsk
# where id = 