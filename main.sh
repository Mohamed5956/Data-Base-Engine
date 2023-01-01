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
select choice in CreateDB ListDB ConnectDB DropDB Exit; do
    #echo "Reply " $REPLY
    case $choice in
    CreateDB)
        createDB.sh
        ;;
    ListDB)
        echo "ListDB"
        ls -F | grep "/"
        main.sh
        ;;
    ConnectDB)
        echo "ConnectDB"
        #read -p "Enter Name of DataBase : " name
            name=$(zenity --entry \
            --width 500 \
            --title "check Data Base" \
            --text "Enter Database ");
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
        main.sh
        ;;
    DropDB)
        name=$(zenity --entry \
            --width 500 \
            --title "check Data Base" \
            --text "Enter your Data Base ");
        if [ -e $name ]; then
            zenity --question \
                --title "Confirm Proccess" \
                --width 500 \
                --height 100 \
                --text "Choose Yes Or No to Drop the Database . "
            if [[ $? == 0 ]]; then
                rm -r $name
               # echo "DB Deleted"
                zenity --info \
                --title "Database Confirm" \
                --width 500 \
                --height 100 \
                --text "Database Deleted"
                main.sh
            else
                #echo " As you like :) "
                zenity --info \
                --title "Database Confirm" \
                --width 500 \
                --height 100 \
                --text "As you like :)"
                main.sh
            fi
        else
            #echo "DB not found"
                zenity --error \
                --title "Error Message" \
                --width 500 \
                --height 100 \
                --text "Database Not Founded."
                main.sh
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
        #echo "Enter the Right Number between 1 to 5"
        zenity --warning \
       --title "Warning Message" \
       --width 500 \
       --height 100 \
       --text "You Must Enter Number between 1 to 5"
       main.sh
        ;;
    esac
done