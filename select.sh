
select choice in selectAllfromTable SelectByCol SelectByRows
do 
    case $choice in 
        selectAllfromTable )
        read -p "Please enter table name: " name
        if [ -f $name ];then
	      sed '2d' $name
        else
	      echo "No Table Found"
        fi
        ;; 
        SelectByCol )
        read -p "Please enter table name: " name
        read -p "select * from table where =  " where 
        read -p " = " value
        sed -n [[ ^$where ]] 
        ;; 
        SelectByRows ) 
        ;;
        *) 
         echo "default"
    esac
done