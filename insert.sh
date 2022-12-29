shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a ar_type
declare -a IDArray
declare -a insertedData
intRegex='^[0-9]+$'
stringRegex='^[a-zA-z]+$'
read -p "Enter table name " name
if [[ -f $name ]];then
    arr_type=($(sed -n '2p' $name))

    IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
    feilds=($(sed -n '1p' $name))
    # test
    #echo ${feilds[@]}
    #echo ${arr_type[@]}
    #echo ${IDArray[@]}
    # length of feilds array
    len=${#feilds[@]}
    # lenOfIdArray=${#IDArray[@]}
    #echo $len
    #echo ${arr_type[1]}+ '0'
    for ((i=0; i<$len; i++))
    do
        read -p "enter the ${feilds[$i]} : " insertedData[$i]
        if [[ ${arr_type[$i]} == "string" ]];then
            if [[ ${insertedData[$i]} =~ $stringRegex ]];then
                continue;
            else
                echo "wrong value for type string" 
                break;
            fi
        else 
            if [[ ${insertedData[$i]} =~ $intRegex ]];then
                for ((j=0; j<${#IDArray[@]}; j++))
                do
                    # echo ${insertedData[$i]}
                   #   echo ${IDArray[$j]}
                    if [[ ${insertedData[$i]} == ${IDArray[$j]} ]];then
                    echo "ID must be unique";
                    read -p "enter the ${feilds[$i]} : " insertedData[$i];
                    fi
                done
                continue;
            else
                echo "wrong value for type int" 
                break;
            fi
        fi
    done
    echo "data Inserted"
    echo ${insertedData[@]} >> $name
    else
    echo "table not found"
fi
