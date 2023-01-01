shopt -s extglob
export LC_COLLATE=C

if [ -d ~/DataBase ]; then
    cd ~/DataBase
    echo "I ' m in DataBase"
    echo "avaliable databases : "
    ls -F | grep "/"
else
    mkdir ~/DataBase
    echo "I Create  DataBase Folder"
    cd ~/DataBase
    echo "I ' m in DataBase"
fi
# export regex='+([a-zA-Z0-9_])'
select choice in CreateDB ListDB ConnectDB DropDB Exit; do
    #echo "Reply " $REPLY
    case $choice in
    CreateDB)
        createDB.sh
        ;;
    ListDB)
        echo "ListDB"
        ls -F | grep "/"
        ;;
    ConnectDB)
        echo "ConnectDB"
        read -p "Enter Name of DataBase : " name
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
            --text "Enter your Data Base ");
        echo $name
        if [ -e $name ]; then
            zenity --question \
                --title "Confirm Proccess" \
                --width 500 \
                --height 100 \
                --text "Choose Yes Or No to Drop the Database . "
            if [[ $? == 0 ]]; then
                rm -r $name
                echo "DB Deleted"
            else
                echo " As you like :) "
            fi
        else
            echo "DB not found"
        fi
        ;;
    Exit)
        echo "See You later"
        break
        ;;
    *)
        echo "Enter the Right Number between 1 to 5"
        ;;
    esac
done
