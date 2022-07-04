#!/bin/bash -e

# check folder permissions
var_datetime=$(date '+%Y-%m-%d %H:%M:%S')  # get formatted datetime	
SCRIPT_OUTPUT=./script_output_$(whoami).log

# if SCRIPT_OUTPUT exists, then dont keep appending to configuration text files
LOCKFILE=$SCRIPT_OUTPUT
if [ -f $SCRIPT_OUTPUT ]  # conditional check if file exists
then
	printf "$var_datetime: Script already executed. Exiting.\n" | tee --append $SCRIPT_OUTPUT
	printf \\a  # beep!
	read -p "Press ENTER to continue..."
	exit
else
	touch $SCRIPT_OUTPUT
	printf "Please notify your manager if you lack read access to any of the following folders:\n" | tee --append $SCRIPT_OUTPUT

	DIR_READ_ACCESS=~/ntuser
	[ -r $DIR_READ_ACCESS ] && R="OK" || R="No Read access!"
	printf "$DIR_READ_ACCESS: $R\n" | tee --append $SCRIPT_OUTPUT

	DIR_READ_ACCESS=~/taxes/
	[ -r $DIR_READ_ACCESS ] && R="OK" || R="No Read access!"
	printf "$DIR_READ_ACCESS: $R\n" | tee --append $SCRIPT_OUTPUT

	DIR_READ_ACCESS=~/Videos/
	[ -r $DIR_READ_ACCESS ] && R="OK" || R="No Read access!"
	printf "$DIR_READ_ACCESS: $R\n" | tee --append $SCRIPT_OUTPUT
	read -p "Press ENTER to continue..."
fi


# search for string in files
var_file=./folder1/sample1.txt
var_search=hehe
printf "\nChecking if file $var_file has been updated to contain $var_search...\n" | tee --append $SCRIPT_OUTPUT
if ! grep -q $var_search $var_file
then
	# backup file in case of problems
	cp $var_file $var_file.bak

	# add new content to file
	printf "File $var_file has not been updated. Appending commands to $var_file\n" | tee --append $SCRIPT_OUTPUT
	echo -e "\nalias code='cd /hehe/code/'\n" >> $var_file  # -e to interpret char escape
	read -p "Press ENTER to continue..."
else
	printf "$var_datetime: File $var_file was already updated.\n" | tee --append $SCRIPT_OUTPUT
	read -p "Press ENTER to continue..."
fi

var_file=./folder2/sample2.txt
var_search=pip
printf "\nChecking if file $var_file has been updated to contain $var_search...\n" | tee --append $SCRIPT_OUTPUT
if ! grep -q $var_search $var_file
then
	# backup file in case of problems
	cp $var_file $var_file.bak

	# add new content to file
	printf "File $var_file has not been updated. Appending commands to $var_file\n" | tee --append $SCRIPT_OUTPUT
	echo -e "\npip install -r ./requirements.txt\n" >> $var_file  # -e to interpret char escape
	read -p "Press ENTER to continue..."
else
	printf "$var_datetime: File $var_file was already updated.\n" | tee --append $SCRIPT_OUTPUT
	read -p "Press ENTER to continue..."
fi
