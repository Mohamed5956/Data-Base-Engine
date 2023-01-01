shopt -s extglob
export LC_COLLATE=C

select choice in TruncateTable deleteSingleRecord returnTOtablesChoise; do
    case $choice in
    TruncateTable)
        #read -p "Enter Table you want to truncate : " name
            name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter Table you want to truncate : ");
        if [[ -e $name ]]; then
            sed -i '3,$d' $name
            #echo "All Data Deleted :) "
                zenity --info \
                --title "Database Confirm" \
                --width 500 \
                --height 100 \
                --text "All Data Deleted :)"
            delete.sh
        else
            #echo "Table Not Founded"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
            delete.sh
        fi
        ;;
    deleteSingleRecord)
        #read -p "Delete From  table : " name
            name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Delete From  table : ");
        flag=0
        if [[ -e $name ]]; then
            #read -p "where column : " column
            column=$(zenity --entry \
            --width 500 \
            --title "check Table" \
            --text "where column : ");
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
            findCounter=0
            declare -i counter=0
            for ((i = 0; i < $len; i++)); do
                if [[ $column == ${feilds[$i]} ]]; then
                    #read -p "$column = " value
                    value=$(zenity --entry \
                    --width 500 \
                    --title "check Table" \
                    --text "$column =  ");
                    ((i++))
                    # echo "iteration : " $i;
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    # echo ${valuesOfColumn[@]}
                    for ((j = 0; j <= ${#valuesOfColumn[@]}; j++)); do
                        if [[ $value == ${valuesOfColumn[$j]} ]]; then
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
                --title "Database Confirm" \
                --width 500 \
                --height 100 \
                --text "Data Deleted Successfully"
                f=0
                delete.sh
            else
                #echo 'column or value not found'
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "column or value not found"
                delete.sh
            fi
        else
            #echo "Table Not Founded"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
            delete.sh
        fi
        ;;
    returnTOtablesChoise )
        tables.sh
       ;;
    *)
        #echo "select between 1 to 3"
        zenity --warning \
       --title "Warning Message" \
       --width 500 \
       --height 100 \
       --text "You Must Enter Number between 1 to 3"
        delete.sh
        ;;
    esac
done
tables.sh