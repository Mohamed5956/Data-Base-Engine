intRegex='^[1-9]+$'
stringRegex='^[a-zA-Z]+$'
checkField=0
checkValue=0

name=$(zenity --entry \
    --width 500 \
    --title "Create Table" \
    --text "Enter The Table Name")
if [[ -f $name ]]; then
    feilds=($(sed -n '1p' $name))
    PKArray=($(sed '1,2d' $name | cut -d' ' -f1))
    columnType=($(sed -n '2p' $name))
    len=${#feilds[@]}
    #read -p "set : " column
    column=$(zenity --entry \
        --width 500 \
        --title "check Table" \
        --text "set :  ")
    for ((i = 0; i < $len; i++)); do
        if [[ $column == ${feilds[$i]} ]]; then
            checkField=1
            columnNumber=$i
            #read -p "$column = " value
            value=$(zenity --entry \
                --width 500 \
                --title "check Table" \
                --text "$column =  ")
            ((i++))
            valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
            for ((j = 0; j < ${#valuesOfColumn[@]}; j++)); do
                flag=0
                if [[ $value == ${valuesOfColumn[$j]} ]]; then
                    checkValue=1
                    let c=$j+3
                    # sed -n "$c"p $name
                    # read -p "Do you want to update this row ? Y/N  : " answer
                    zenity --question \
                        --title "Confirm Proccess" \
                        --width 500 \
                        --height 100 \
                        --text " found :
                $(sed -n "$c"p $name)
                    Are you sure you want to update it ? "
                    if [[ $? == 0 ]]; then
                        #read -p "enter new value : " newValue
                        newValue=$(zenity --entry \
                            --width 500 \
                            --title "check Table" \
                            --text "enter new value : ")
                        # to check if data type is string or int
                        if [[ ${columnType[$columnNumber]} == 'string' ]]; then
                            if [[ $newValue =~ $stringRegex ]]; then
                                flag=1
                            else
                                #echo 'column type string expected value string'
                                zenity --error \
                                    --title "Error Message" \
                                    --width 500 \
                                    --height 100 \
                                    --text "column type string expected value string"
                                ((j--))
                            fi
                        fi
                        if [[ ${columnType[$columnNumber]} == 'int' ]]; then
                            if [[ $newValue =~ $intRegex ]]; then
                                flag=1
                            else
                                #echo 'column type int expected value int'
                                zenity --error \
                                    --title "Error Message" \
                                    --width 500 \
                                    --height 100 \
                                    --text "column type int expected value int and can't be 0"
                                ((j--))
                            fi
                        fi
                        # end of check
                        f=0
                        for ((k = 0; k < ${#PKArray[@]}; k++)); do
                            if [[ $newValue == ${PKArray[$k]} ]]; then
                                f=1
                                #echo "Primary key must be unique !!!"
                                zenity --error \
                                    --title "Error Message" \
                                    --width 500 \
                                    --height 100 \
                                    --text "Primary key must be unique !!!"
                                ((j--))
                            fi
                        done
                        if [[ $f == 0 && $flag == 1 ]]; then
                            sed -i "${c}s/$value/$newValue/" $name
                        fi
                    else
                        #echo " As you like :) "
                        zenity --info \
                            --title "Update Table" \
                            --width 500 \
                            --height 100 \
                            --text "As you like :)"
                    fi
                fi
            done
            if [[ $checkValue == 0 ]]; then
                #echo "Value Not Founded"
                zenity --error \
                    --title "Error Message" \
                    --width 500 \
                    --height 100 \
                    --text "Value Not Found !!"
            fi
        fi
    done
    if [[ $checkField == 1 && $checkValue == 1 && $newValue ]]; then
        #echo "Data_Updated"
        zenity --info \
            --title "Update Table" \
            --width 500 \
            --height 100 \
            --text "Data Updated Successfully"
    fi
    if [[ $checkField == 0 ]]; then
        #echo "Field Not Founded"
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "Column Not Found !!"
    fi
else
    #echo "table not found"
    zenity --error \
        --title "Error Message" \
        --width 500 \
        --height 100 \
        --text "Table Not Found !!"
fi
