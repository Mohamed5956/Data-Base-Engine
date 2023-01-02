shopt -s extglob
export LC_COLLATE=C

if [ -d ~/DataBase ]; then
    cd ~/DataBase
    echo "I ' m in DataBase"
else
    mkdir ~/DataBase
    echo "I Create  DataBase Folder"
    cd ~/DataBase
    echo "I ' m in DataBase"
fi
# export regex='+([a-zA-Z0-9_])'
while true; do
    choice=$(zenity --list \
        --column "select option" \
        --width 600 \
        --height 300 \
        CreateDB \
        ListDB \
        ConnectDB \
        DropDB \
        Exit)
    #select choice in CreateDB ListDB ConnectDB DropDB Exit; do
    #echo "Reply " $REPLY
    case $choice in
    CreateDB)
        createDB.sh
        ;;
    ListDB)
        echo "ListDB"
        # ls -F | grep "/"
        zenity --info \
            --title "Info Message" \
            --width 500 \
            --height 100 \
            --text " $(ls -F | grep "/")"
        ;;
    ConnectDB)
        echo "ConnectDB"
        #read -p "Enter Name of DataBase : " name
        name=$(zenity --entry \
            --width 500 \
            --title "check Data Base" \
            --text "Enter Database ")
        if [ -d $name ]; then
            echo "I connect DB : $name"
            cd $name
            tables.sh
        else
            zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Error i Can't Connect to this DB ."
        fi
        ;;
    DropDB)
        name=$(zenity --entry \
            --width 500 \
            --title "check Data Base" \
            --text "Enter your Data Base ")
        if [ -e $name ]; then
            zenity --question \
                --title "Confirm Proccess" \
                --width 500 \
                --height 100 \
                --text "Are you sure to Drop Database : $name . "
            if [[ $? == 0 ]]; then
                rm -r $name
                # echo "DB Deleted"
                zenity --info \
                    --title "Database Confirm" \
                    --width 500 \
                    --height 100 \
                    --text "Database Deleted"
            else
                #echo " As you like :) "
                zenity --info \
                    --title "Database Confirm" \
                    --width 500 \
                    --height 100 \
                    --text "As you like :)"
            fi
        else
            #echo "DB not found"
            zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Database Not Founded."
        fi
        ;;
    Exit)
        #echo "See You later"
        zenity --info \
            --title "You Exit" \
            --width 500 \
            --height 100 \
            --text "OK! See You later"
        break
        ;;
    *)
        break
        ;;
    esac
done
