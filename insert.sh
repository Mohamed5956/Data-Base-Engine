shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a arr_type
declare -a IDArray
declare -a insertedData
intRegex='^[0-9]+$'
stringRegex='^[a-zA-z]+$'
read -p "Enter table name : " name
if [[ -f $name ]]; then
arr_type=($(sed -n '2p' $name))
IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
feilds=($(sed -n '1p' $name))
# length of feilds array
len=${#feilds[@]}
flag=0
    for ((i = 0; i < $len; i++)); do
        read -p "enter the ${feilds[$i]} : " insertedData[$i]
        if [[ ${arr_type[$i]} == "string" ]]; then
            if [[ ${insertedData[$i]} =~ $stringRegex ]]; then
                continue
            else
                echo "wrong value for type string"
                flag=1
                tables.sh
            fi
        else
            if [[ ${insertedData[$i]} =~ $intRegex ]]; then
                for ((j = 0; j < ${#IDArray[@]}; j++)); do
                    if [[ ${insertedData[$i]} == ${IDArray[$j]} ]]; then
                        echo "ID must be unique"
                        ((j--))
                        read -p "enter the ${feilds[$i]} : " insertedData[$i]
                    fi
                done
                continue
            else
                echo "wrong value for type int"
                flag=1
                tables.sh
            fi
        fi
    done
    if [[ $flag == 0 ]];then
    echo "data Inserted"
    echo ${insertedData[@]} >>$name
    tables.sh
    fi
else
    echo "table not found"
    tables.sh
fi
