shopt -s extglob
export LC_COLLATE=C
while true; do
    choice=$(zenity --list \
        --column "select option" \
        --width 600 \
        --height 300 \
        TruncateTable \
        DeleteRecords \
        back)
    # select choice in TruncateTable deleteSingleRecord returnTOtablesChoise; do
    case $choice in
    TruncateTable)
        #read -p "Enter Table you want to truncate : " name
        name=$(zenity --entry \
            --width 500 \
            --title "Table Delete" \
            --text "Enter Table you want to truncate : ")
        if [[ -e $name ]]; then
            sed -i '3,$d' $name #deleting from line 3 to the end of the file
            #echo "All Data Deleted :) "
            zenity --info \
                --title "Table Confirm" \
                --width 500 \
                --height 100 \
                --text "All Data Deleted :)"
        else
            #echo "Table Not Founded"
            zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
        fi
        ;;
    DeleteRecords)
        #read -p "Delete From  table : " name
        name=$(zenity --entry \
            --width 500 \
            --title "Table Delete" \
            --text "Delete From  table : ")
        flag=0
        if [[ -e $name ]]; then
            #read -p "where column : " column
            column=$(zenity --entry \
                --width 500 \
                --title "Table Delete" \
                --text "where column : ")
            feilds=($(sed -n '1p' $name)) # getting columns in the file to array
            len=${#feilds[@]} 
            findCounter=0 # counter to count data finded
            declare -i counter=0
            for ((i = 0; i < $len; i++)); do
                if [[ $column == ${feilds[$i]} ]]; then
                    #read -p "$column = " value
                    value=$(zenity --entry \
                        --width 500 \
                        --title "Table Delete" \
                        --text "$column =  ")
                    ((i++))
                    # echo "iteration : " $i;
                    # adding i++ because there's no feild of 0 start from 1
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    # echo ${valuesOfColumn[@]}
                    for ((j = 0; j <= ${#valuesOfColumn[@]}; j++)); do
                        if [[ $value == ${valuesOfColumn[$j]} ]]; then
                            # c because we need to find start of line 3
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
                    f=1
                done

            else
                f=0
            fi
            if [[ $f == 1 ]]; then
                #echo 'Data Deleted Successfully'
                zenity --info \
                    --title "Table Confirm" \
                    --width 500 \
                    --height 100 \
                    --text "Data Deleted Successfully"
                f=0
            else
                #echo 'column or value not found'
                zenity --error \
                    --title "Error Message" \
                    --width 500 \
                    --height 100 \
                    --text "column or value not found"
            fi
        else
            #echo "Table Not Founded"
            zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
        fi
        ;;
    back)
        break
        ;;
    *)
        #echo "select between 1 to 3"
        break;
        ;;
    esac
done
