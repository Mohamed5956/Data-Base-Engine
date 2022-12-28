shopt -s extglob
export LC_COLLATE=C

read -p "Please enter the database name: " name
regex="^[0-9]+"
flag=0
while [ $flag -eq 0 ];do

if [[ $name == *['!''?'@\#\$%^\&*()-+\.\/';']* ]];then
	echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
	read -p "Please enter a valid name: " name
	continue
fi

if [[ $name =~ $regex ]];then
	echo "name can't start with number "
	read -p "Please enter a valid name: " name
	continue
fi

if [[ $name = *" "* ]]; then
	echo "spaces are not allowed!"
	read -p "Please enter a valid name: " name
	continue
fi

if [ -z $name ];then
read -p "Please enter a name: " name
continue
fi

if [ -d $name ];then
	echo "Database already exists"
	read -p "Please enter another name: " name
else
	mkdir $name
	echo "Database created successfully"
	flag=1
fi

done