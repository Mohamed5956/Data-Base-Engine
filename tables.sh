select choice in CreateTable ListTable dropTable SelectFromTable insertIntoTable updateFromTable deleteFromTable disconnect; do

    case $choice in
    CreateTable)
        createTable.sh
        ;;
    ListTable)
        echo "Table List : "
        ls -F | grep -v "/"
        tables.sh
        ;;
    dropTable)
        #read -p "Enter Name of Table : " name
        	name=$(zenity --entry \
            --width 500 \
            --title "Create Table" \
            --text "Enter The Table Name");
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
                --text "Choose Yes Or No to Delete the Table . "
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
        tables.sh
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
        main.sh
        ;;
    *)
        #echo "Enter number between 1 to 8"
       zenity --warning \
       --title "Warning Message" \
       --width 500 \
       --height 100 \
       --text "You Must Enter Number between 1 to 8"
       tables.sh
        ;;
    esac
done
