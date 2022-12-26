read -p "enter" colNumber
reg='^[0-9]+'
if ! [[ $colNumber == ^[0-9]+ ]];then
		echo "not number";
else
		echo "number";	
fi
