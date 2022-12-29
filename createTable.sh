shopt -s extglob
export LC_COLLATE=C

typeset -i colNumber
declare -a colNames
declare -a dataType

regex="^[0-9]+"
colNumberRegex='^[0-9]+$'

# read -p "Please enter the table name: " name

flag=0
while (($flag == 0)); do
	read -p "Please enter the table name: " name

	if [[ $name == *['!''?'@\#\$%^\&*()-+\.\/';']* ]]; then
		echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
		continue
	fi

	if [[ $name =~ $regex ]]; then
		echo "name can't start with number "
		continue
	fi

	if [[ $name = *" "* ]]; then
		echo "spaces are not allowed!"
		continue
	fi

	if [ -z $name ]; then
		echo "name can't be empty"
		continue
	fi

	if [ -f $name ]; then
		echo "Table already exists"
		continue
	else
		touch $name
		read -p "enter number of columns : " colNumber
		if [[ $colNumber == "g" ]]; then
			echo "must be integer"
			flag=1
			rm $name
			break
		else
			for ((i = 0; i < $colNumber; i++)); do
				read -p "enter your feild : " colNames[$i]
				echo ${colNames[$i]}
				# validation for regex
				numberRegex='^[0-9][a-zA-Z]+'
				if [[ ${colNames[$i]} =~ $numberRegex ]]; then
					echo "Name Can't Start with Number !!"
					rm $name
					flag=1
					break
				fi
				if [[ ${colNames[$i]} == *['!''?'@\#\$%^\&*()-+\.\/';']* ]]; then
					echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
					rm $name
					flag=1
					break
				fi
				read -p "enter data type : " dataType[$i]
				# end of validation
				# validation for int and string dataTypes
				if [[ ${dataType[$i]} == "int" ]]; then
					continue
				elif [[ ${dataType[$i]} == "string" ]]; then
					continue
				else
					echo "Wrong value for certain data types your data type must be 'int' or 'string' only "
					rm $name
					flag=1
					break
				fi
				# end of validation for data
			done

			if (($flag == 0)); then
				echo ${colNames[@]} >>$name
				echo ${dataType[@]} >>$name
				echo "Table created successfully"
				flag=1
			fi

		fi
	fi

done

# ((i++))
