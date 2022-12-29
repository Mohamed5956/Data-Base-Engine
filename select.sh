select choice in selectAllfromTable SelectRowsByValue SelectAllRowsByCol; do
    case $choice in
    selectAllfromTable )
        read -p "Please enter table name: " name
        if [ -f $name ]; then
            sed '2d' $name
        else
            echo "No Table Found"
        fi
        ;;
    SelectRowsByValue )
        read -p "Please enter table name : " name
        if [[ -f $name ]]; then
            read -p "select * from $name where column : " column
            declare -i flag=0
            declare -a feilds
            feilds=($(sed -n '1p' $name))
            len=${#feilds[@]}
            for ((i = 0; i < $len; i++)); do
                if [[ $column == ${feilds[$i]} ]]; then
                    read -p "$column = " value
                    ((i++))
                    # echo "iteration : " $i;
                    valuesOfColumn=($(sed '1,2d' $name | cut -d' ' -f$i))
                    # echo ${valuesOfColumn[@]}
                    for ((j = 0; j <= ${#valuesOfColumn[@]}; j++)); do
                        if [[ $value == ${valuesOfColumn[$j]} ]]; then
                            let c=$j+3
                            sed -n "$c p" $name
                            flag=1
                        fi
                    done
                fi
            done
            if [[ $flag == 0 ]]; then
                echo "there's no column found"
            fi
        else
            echo "table not found"
        fi
        ;;
    SelectAllRowsByCol )
        read -p "Please enter table name: " name
        declare -a feilds
        feilds=($(sed -n '1p' $name))
        len=${#feilds[@]}
        echo ${feilds[@]}
        echo $len
        read -p "enter the feild you want to select : " feild
        declare -i flag=0
        for ((i = 0; i < $len; i++)); do
            if [[ $feild == ${feilds[$i]} ]]; then
                declare -i increment=$i+1
                cut -d" " -f$increment $name | sed '2d'
                flag=1
                break
            fi
        done
        if [[ $flag == 0 ]]; then
            echo "feild not found"
            echo ${feilds[@]}
        fi
        ;;
    *)
        echo "default"
        ;;
    esac
done
