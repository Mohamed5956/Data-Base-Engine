while true; do
    choice=$(zenity --list \
        --column "select option" \
        --width 600 \
        --height 300 \
        CreateTable \
        ListTable \
        dropTable \
        SelectFromTable \
        insertIntoTable \
        updateFromTable \
        deleteFromTable \
        disconnect)

    # select choice in CreateTable ListTable dropTable SelectFromTable insertIntoTable updateFromTable deleteFromTable disconnect; do

    case $choice in
    CreateTable)
        createTable.sh
        ;;
    ListTable)
        echo "Table List : "
        # ls -F | grep -v "/"
        zenity --info \
            --title "Info Message" \
            --width 500 \
            --height 100 \
            --text " $(ls -F | grep -v "/")"
        ;;
    dropTable)
        #read -p "Enter Name of Table : " name
        name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter The Table Name")
        if [ -e $name ]; then
            # read -p "Do you want to Drop Table ? Y/N  : " answer
            # if [[ $answer == 'y' || $answer == 'Y' ]]; then
            #     rm $name
            #     echo "Table Deleted"
            # elif [[ $answer == 'n' || $answer == 'N' ]]; then
            #     echo " As you like :) "
            # else
            # echo "you enterd wrong input it must be Y/y or N/n Only"
            # fi
            # else
            #     echo "Table not found"
            # fi
            zenity --question \
                --title "Confirm Proccess" \
                --width 500 \
                --height 100 \
                --text "Are you sure you want to delete $name . "
            if [[ $? == 0 ]]; then
                rm -r $name
                # echo "DB Deleted"
                zenity --info \
                    --title "Table Confirm" \
                    --width 500 \
                    --height 100 \
                    --text "Table Deleted"
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
                --text "Table Not Founded."
        fi
        ;;
    SelectFromTable)
        select.sh
        ;;
    insertIntoTable)
        insert.sh
        ;;
    updateFromTable)
        update.sh
        ;;
    deleteFromTable)
        delete.sh
        ;;
    disconnect)
        zenity --info \
            --title "You Exit" \
            --width 500 \
            --height 100 \
            --text "disconnected Succefully "
        break
        ;;
    *)
        break
        ;;
    esac
done
