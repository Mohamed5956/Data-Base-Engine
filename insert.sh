shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a ar_type
declare -a IDArray
declare -a preInsertedData
declare -a insertedData

read -p "Enter table name " name
arr_type=($(sed -n '2p' $name))

IDArray=($(sed '1,2d' $name | cut -d' ' -f1))
feilds=($(sed -n '1p' $name))
echo ${feilds[@]}
echo ${arr_type[@]}
echo ${IDArray[@]}
for ((i=0; i<3; i++))
do
    read -p "enter the ${feilds[$i]} : " insertedData[$i]
    if [[ ${arr_type[$i]} == "string" ]];then
        if [[ ${insertedData[$i]} == ^[a-zA-z]+$ ]];then
            continue;
        else
            echo "wrong value for type string" 
            break;
        fi
    else 
        if [[ ${insertedData[$i]} == ^[0-9]+$ ]];then
            continue;
        else
            echo "wrong value for type int" 
            break;
        fi
    fi
done