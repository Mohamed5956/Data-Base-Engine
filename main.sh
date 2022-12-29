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
            echo "Error i Can't Connect to this DB "
        fi
        ;;
    DropDB)
        read -p "Enter Name of DataBase : " name
        if [ -e $name ]; then
            rm -r $name
            echo "DB Deleted"
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
