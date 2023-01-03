shopt -s extglob
export LC_COLLATE=C

regex="^[0-9]+"
flag=0
while [ $flag -eq 0 ]; do

    #read -p "Please enter the database name: " name
    name=$(zenity --entry \
        --width 500 \
        --title "check Data Base" \
        --text "Enter your Data Base ")
    if [[ $name == *['!''?'','@\#\$%^\&*()-+\.\/';']* ]]; then
        #echo "! @ # $ % ^ () ? + ; . -  are not allowed!"
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "! @ # $ % ^ () ? + ; . - , are not allowed!"
        continue
    fi

    if [[ $name =~ $regex ]]; then
        #echo "name can't start with number "
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "Name can't start with number!"
        continue
    fi

    if [[ $name = *" "* ]]; then
        #echo "spaces are not allowed!"
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "Spaces are not allowed!"
        continue
    fi

    if [ -z $name ]; then
        #echo "name can't be empty"
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "Name can't be empty!"
        continue
    fi
    if [ -d $name ]; then
        #echo "Database already exists"
        zenity --error \
            --title "Error Message" \
            --width 500 \
            --height 100 \
            --text "Database already exists!"

    else
        mkdir $name
        #echo "Database created successfully"
        zenity --info \
            --title "Create Database" \
            --width 500 \
            --height 100 \
            --text "Database created successfully."
        flag=1
    fi
done
