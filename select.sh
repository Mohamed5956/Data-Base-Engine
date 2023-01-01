select choice in selectAllfromTable SelectRowsByValue SelectAllRowsByCol returnTOtablesChoise; do
    case $choice in
    selectAllfromTable )
        #read -p "Please enter table name: " name
            name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter The Table Name");
        if [ -f $name ]; then
            #sed '2d' $name
            zenity --text-info \
            --title "Data Information" \
            --filename "$name"
            select.sh
        else
            #echo "No Table Found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
            select.sh
        fi
        ;;
    SelectRowsByValue )
        #read -p "Please enter table name : " name
            name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter The Table Name");
        if [[ -f $name ]]; then
            #read -p "select * from $name where column : " column
            column=$(zenity --entry \
            --width 500 \
            --title "check Table" \
            --text "select * from $name where column : ");
            declare -i flag=0
            declare -a feilds
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
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
                            sed -n "$c p" $name
                            flag=1
                            select.sh
                        fi
                    done
                fi
            done
            if [[ $flag == 0 ]]; then
                #echo "there's no column found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Column or Data NOT Founded"
                select.sh
            fi
        else
            #echo "table not found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
            select.sh
        fi
        ;;
    SelectAllRowsByCol )
        #read -p "Please enter table name: " name
            name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter The Table Name");
        if [[ -f $name ]]; then
        declare -a feilds
        feilds=($(sed -n '1p' $name))
        len=${#feilds[@]}
        echo ${feilds[@]}
        #read -p "enter the feild you want to select : " feild
            feild=$(zenity --entry \
            --width 500 \
            --title "check Table" \
            --text "enter the feild you want to select : ");
        declare -i flag=0
        for ((i = 0; i < $len; i++)); do
            if [[ $feild == ${feilds[$i]} ]]; then
                declare -i increment=$i+1
                cut -d" " -f$increment $name | sed '2d'
                flag=1
                select.sh
            fi
        done
        if [[ $flag == 0 ]]; then
            #echo "feild not found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "feild not found"
            echo ${feilds[@]}
            select.sh
        fi
         else
            #echo "table not found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Table Not Founded."
            select.sh
        fi
        ;;
    returnTOtablesChoise )
        tables.sh
    ;;
    *)
        #echo "select between 1 to 4"
        zenity --warning \
       --title "Warning Message" \
       --width 500 \
       --height 100 \
       --text "You Must Enter Number between 1 to 4"
        select.sh
        ;;
    esac
done
