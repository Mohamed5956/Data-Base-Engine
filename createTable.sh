shopt -s extglob
export LC_COLLATE=C

# typeset -i colNumber
declare -a colNames
declare -a dataType
regex="^[0-9]+" # regex for start with number
colNumberRegex='^[0-9]+$' # regex for number of column (start and end with number)
flag=0 # flag to validate name
while (($flag == 0)); do
	#read -p "Please enter the table name: " name
	name=$(zenity --entry \
		--width 500 \
		--title "Create Table" \
		--text "Enter The Table Name")

	if [[ $name == *['!''?'','@\#\$%^\&*()-+\.\/';']* ]]; then
		#echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
		zenity --error \
			--title "Error Message" \
			--width 500 \
			--height 100 \
			--text "name can't contain ! @ # $ % ^ () ? + ; . - !"
		continue
	fi

	if [[ $name =~ $regex ]]; then
		#echo "name can't start with number "
		zenity --error \
			--title "Error Message" \
			--width 500 \
			--height 100 \
			--text "name can't start with number!"
		continue
	fi

	if [[ $name = *" "* ]]; then
		#echo "spaces are not allowed!"
		zenity --error \
			--title "Error Message" \
			--width 500 \
			--height 100 \
			--text "spaces are not allowed!"
		continue
	fi

	if [ -z $name ]; then
		#echo "name can't be empty"
		zenity --error \
			--title "Error Message" \
			--width 500 \
			--height 100 \
			--text "name can't be empty!"
		continue
	fi

	if [ -f $name ]; then
		#echo "Table already exists"
		zenity --error \
			--title "Error Message" \
			--width 500 \
			--height 100 \
			--text "table already exists!"
		continue
	else
		touch $name
		#read -p "enter number of columns : " colNumber
		colNumber=$(zenity --entry \
			--width 500 \
			--title "Create Table" \
			--text "Enter Number Of Columns")
		if ! [[ $colNumber =~ $colNumberRegex && $colNumber != "0" ]]; then
			#echo "must be integer"
			zenity --error \
				--title "Error Message" \
				--width 500 \
				--height 100 \
				--text "number of columns must be integer And can't be 0 !"
			flag=1
			rm $name
			break
		else
			for ((i = 0; i < $colNumber; i++)); do
				#read -p "enter your feild : " colNames[$i]
				colNames[$i]=$(zenity --entry \
					--width 500 \
					--title "Create Table" \
					--text "Enter your column")
				# echo ${colNames[$i]}
				# validation for regex
				if [[ ${colNames[$i]} =~ $regex ]]; then
					#echo "Name Can't Start with Number !!"
					zenity --error \
						--title "Error Message" \
						--width 500 \
						--height 100 \
						--text "Name Can't Start with Number !!"
					rm $name				# numberRegex='^[0-9][a-zA-Z]+'
					flag=1
					break
				fi
				if [[ ${colNames[$i]} == *['!''?'','@\#\$%^\&*()-+\.\/';']* ]]; then
					#echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
					zenity --error \
						--title "Error Message" \
						--width 500 \
						--height 100 \
						--text "name can't contain ! @ # $ % ^ () ? + ; . - , !"
					rm $name
					flag=1
					break
				fi
				#read -p "enter data type : " dataType[$i]
				# getting datatype from user in array and validate it int or string only
				dataType[$i]=$(zenity --entry \
					--width 500 \
					--title "Create Table" \
					--text "Enter data type : Must be int or string only")
				if [[ ${dataType[$i]} == "int" ]]; then
					continue
				elif [[ ${dataType[$i]} == "string" ]]; then
					continue
				else
					#echo "Wrong value for certain data types your data type must be 'int' or 'string' only "
					zenity --error \
						--title "Error Message" \
						--width 500 \
						--height 100 \
						--text "data types your data type must be 'int' or 'string' only"
					rm $name
					flag=1
					break
				fi
				# end of validation for data
			done
			# if everything is ok with the column names and data types 
			# save it in the file created
			if (($flag == 0)); then
				echo ${colNames[@]} >>$name
				echo ${dataType[@]} >>$name
				#echo "Table created successfully"
				zenity --info \
					--title "Create Table" \
					--width 500 \
					--height 100 \
					--text "Table created successfully."
				flag=1
			fi

		fi
	fi

done