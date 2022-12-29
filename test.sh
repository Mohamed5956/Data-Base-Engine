	flag=0
	read -p "enter number of columns : " colNumber
	colNumberRegex='^[0-9]+$'
	if ! [[ $colNumber =~ $colNumberRegex ]];then
		echo "must be integer";
		flag=1
	else
		flag=0
	fi

	echo $flag