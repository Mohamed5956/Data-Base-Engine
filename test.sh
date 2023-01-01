name=$(zenity --entry \
    --width 500 \
    --title "check Data Base" \
    --text "Enter your Data Base "); echo $name
cd ~/DataBase
if [ -e $name ]; then
    zenity --question \
        --title "Confirm Proccess" \
        --width 500 \
        --height 100 \
        --text "Choose Yes Or No to Drop the Database . "
    if [[ $? == 0 ]]; then
        rm -r $name
        echo "DB Deleted"
    elif [[ $? == 1 ]]; then
        echo " As you like :) "
    else
        echo "you enterd wrong input it must be Y/y or N/n Only"
    fi
else
    echo "DB not found"
fi
