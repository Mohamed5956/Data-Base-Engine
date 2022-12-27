
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
        read -p "Please enter table name : " name
            if [[ -f $name ]];then
                read -p "select * from $name where column : " column
                declare -i flag=0
                declare -a feilds
                feilds=($(sed -n '1p' $name))
                len=${#feilds[@]}
                echo ${feilds[@]}
                echo $len
                for ((i=0; i<$len; i++))
                do
                    if [[ $column == ${feilds[$i]} ]];then
                        read -p "value = " value
                        echo $name
                        awk -F" " -v userData="$value" '
                        BEGIN{
                            f=0
                        }
                        {
                            i=1
                            while(i <= NF){
                                if($i == userData)
                                {
                                    print $0
                                    f=1
                                }
                                i++
                            }
                        }
                        END{
                            if(f == 0){
                                print "no values found"
                            }
                        }
                        ' $name
                        flag=1
                        break;
                    fi
                done
                if [[ $flag == 0 ]];then
                    echo "there's no column found"
                fi
            else
            echo "table not found";
            fi
        ;; 
        SelectByRows ) 
        ;;
        *) 
         echo "default"
    esac
done