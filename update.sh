shopt -s extglob
export LC_COLLATE=C

declare -a feilds
declare -a valuesOfColumn
declare -a PKArray
# intRegex='^[0-9]+$'

read -p "update from Table : " name
feilds=($(sed -n '1p' $name))
PKArray=($(sed '1,2d' $name | cut -d' ' -f1))
len=${#feilds[@]}

if [[ -f $name ]]; then
    read -p "set : " column
    # flag=0
    for ((i = 0; i < $len; i++)); do
        if [[ $column == ${feilds[$i]} ]]; then
            read -p "$column = " value
            ((i++))
            valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
            for ((j = 0; j < ${#valuesOfColumn[@]}; j++)); do
                if [[ $value == ${valuesOfColumn[$j]} ]]; then
                    let c=$j+3
                    sed -n "$c"p $name
                    read -p "Do you want to update this row ? Y/N" answer
                    if [[ $answer == 'y' || $answer == 'Y' ]]; then
                        read -p "enter new value : " newValue
                        f=0
                        for ((k = 0; k < ${#PKArray[@]}; k++)); do
                            if [[ $newValue == ${PKArray[$k]} ]]; then
                                f=1
                                echo "Primary key must be unique !!!"
                                break
                            fi
                        done
                        if [[ $f == 0 ]]; then
                            sed -i "${c}s/$value/$newValue/" $name
                        fi
                    elif [[ $answer == 'n' || $answer == 'N' ]]; then
                        echo " As you like :) "
                    else
                        echo "you enterd wrong input it must be Y/y or N/n Only"
                        ((j--))
                    fi
                fi
            done
        fi
    done
else
    echo "table not found"
fi
