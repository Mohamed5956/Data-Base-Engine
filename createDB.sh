shopt -s extglob
export LC_COLLATE=C


regex="^[0-9]+"
flag=0
while [ $flag -eq 0 ];do

read -p "Please enter the database name: " name

if [[ $name == *['!''?'@\#\$%^\&*()-+\.\/';']* ]];then
	echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
	continue
fi

if [[ $name =~ $regex ]];then
	echo "name can't start with number "
	continue
fi

if [[ $name = *" "* ]]; then
	echo "spaces are not allowed!"
	continue
fi

if [ -z $name ];then
echo "name can't be empty"
continue
fi

if [ -d $name ];then
	echo "Database already exists"
else
	mkdir $name
	echo "Database created successfully"
	flag=1
fi

done
