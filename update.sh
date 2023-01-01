# declare -a feilds
# declare -a valuesOfColumn
# declare -a PKArray
# declare -a columnType

intRegex='^[0-9]+$'
stringRegex='^[a-zA-Z]+$'
checkField=0
checkValue=0

read -p "update from Table : " name

if [[ -f $name ]]; then
    feilds=($(sed -n '1p' $name))
    PKArray=($(sed '1,2d' $name | cut -d' ' -f1))
    columnType=($(sed -n '2p' $name))
    len=${#feilds[@]}
    read -p "set : " column
    for ((i = 0; i < $len; i++)); do
        if [[ $column == ${feilds[$i]} ]]; then
            checkField=1
            columnNumber=$i
            read -p "$column = " value
            ((i++))
            valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
            for ((j = 0; j < ${#valuesOfColumn[@]}; j++)); do
                flag=0
                if [[ $value == ${valuesOfColumn[$j]} ]]; then
                checkValue=1
                    let c=$j+3
                    sed -n "$c"p $name
                    read -p "Do you want to update this row ? Y/N  : " answer
                    if [[ $answer == 'y' || $answer == 'Y' ]]; then
                        read -p "enter new value : " newValue
                        # to check if data type is string or int
                        if [[ ${columnType[$columnNumber]} == 'string' ]]; then
                            if [[ $newValue =~ $stringRegex ]]; then
                                flag=1
                            else
                                echo 'column type string expected value string'
                                ((j--))
                            fi
                        fi
                        if [[ ${columnType[$columnNumber]} == 'int' ]]; then
                            if [[ $newValue =~ $intRegex ]]; then
                                flag=1
                            else
                                echo 'column type int expected value int'
                                ((j--))
                            fi
                        fi
                        # end of check
                        f=0
                        for ((k = 0; k < ${#PKArray[@]}; k++)); do
                            if [[ $newValue == ${PKArray[$k]} ]]; then
                                f=1
                                echo "Primary key must be unique !!!"
                                ((j--))
                            fi
                        done
                        if [[ $f == 0 && $flag == 1 ]]; then
                            sed -i "${c}s/$value/$newValue/" $name
                        fi
                    elif [[ $answer == 'n' || $answer == 'N' ]]; then
                        echo " As you like :) "
                        tables.sh
                    else
                        echo "you enterd wrong input it must be Y/y or N/n Only"
                        ((j--))
                    fi
                fi
            done
      if [[ $checkValue == 0 ]]; then
      echo "Value Not Founded"
      tables.sh
      fi
        fi
        
    done
     if [[ $checkField == 0 ]]; then
      echo "Field Not Founded"
      tables.sh
      fi
else
    echo "table not found"
    tables.sh
fi
# update from tableName
# set id = dgfsk
# where id =
