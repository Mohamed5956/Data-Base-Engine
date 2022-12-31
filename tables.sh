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
        read -p "are you sure u want to delete $name " answer
            rm $name
            echo "Table Deleted"
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
    Exit)
        echo "See You later"
        break
        ;;
    *)
        echo "default"
        ;;
    esac
done
