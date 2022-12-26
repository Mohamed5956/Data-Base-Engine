shopt -s extglob
export LC_COLLATE=C

typeset -i colNumber
declare -a colNames
declare -a dataType

read -p "Please enter the table name: " name

flag=0
while [ $flag -eq 0 ];do

if [[ $name == *['!''?'@\#\$%^\&*()-+\.\/';']* ]];then
	echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
	read -p "Please enter a valid name: " name
	continue
fi

if [[ $name == *[0-9]* ]];then
	echo "Name Can't Start With Number!!"
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

if [ -f $name ];then
	echo "Table already exists"
	read -p "Please enter another name: " name
else
	touch $name
	read -p "enter number of columns : " colNumber
	for ((i=0; i<$colNumber; i++))
	do
	read -p "enter your feild : " colNames[$i]
	read -p "enter data type : " dataType[$i]
	echo ${dataType[$i]};
	if [[ ${dataType[$i]} == "int" ]];then
		continue
	elif [[ ${dataType[$i]} == "string" ]];then
		continue
	else
	echo "Wrong value for certain data types"
	flag=1
	break;
	fi
	done
	# "${array[i]}$i"
	if [[ $flag == 0 ]];then
	echo ${colNames[@]} >> $name
	echo ${dataType[@]} >> $name
	echo "Table created successfully"
	flag=1
	fi
fi

done