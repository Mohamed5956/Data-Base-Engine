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
        read -p "Enter Name of Table : " name
        if [ -e $name ]; then
        read -p "Do you want to Drop Table ? Y/N  : " answer
        if [[ $answer == 'y' || $answer == 'Y' ]]; then
            rm $name
            echo "Table Deleted"
        elif [[ $answer == 'n' || $answer == 'N' ]]; then
            echo " As you like :) "
        else
        echo "you enterd wrong input it must be Y/y or N/n Only"
        fi
        else
            echo "Table not found"
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
        echo "Enter number between 1 to 8"
        ;;
    esac
done
