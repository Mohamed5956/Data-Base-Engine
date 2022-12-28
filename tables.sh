select choice in CreateTable ListTable dropTable SelectFromTable insertIntoTable updateFromTable deleteFromTable disconnect
do
echo "Reply " $REPLY 
    case $choice in 
        CreateTable )
        createTable.sh
        ;; 
        ListTable ) 
        echo "ListTable"
          ls -F | grep -v "/"  
        ;; 
        dropTable )
        read -p "Enter Name of Table : " name
            if [ -e $name ] ;then
                rm $name
                echo "Table Deleted"
            else 
                echo "Table not found"
            fi 
        ;;
        SelectFromTable ) 
            select.sh
        ;;
        insertIntoTable )
        insert.sh
        ;;
        updateFromTable )
        update.sh
        ;;
        Exit )
        echo "See You later";
        break;
        ;;
        *) 
         echo "default"
    esac
done