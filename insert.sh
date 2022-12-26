read -p "Enter table name \n" name
if [ -f $name ];then
    sed -n '1p' $name | wc -w
fi
