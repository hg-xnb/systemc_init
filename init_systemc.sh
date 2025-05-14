#! /bin/sh

export BOLD="\e[1m"
export FAINT="\e[2m"
export ITALIC="\e[3m"
export UNDERLINED="\e[4m"

export BLACK="\e[30m"
export RED="\e[31m"
export GREEN="\e[32m"
export YELLOW="\e[33m"
export BLUE="\e[34m"
export MEGENTA="\e[35m"
export CYAN="\e[36m"
export LIGHT_GRAY="\e[37m"
export NORMAL="\e[0m"

export BLUE_WHITE="\e[94m"
export SYSTEMC_INIT_DIR=/mnt/sda1/Linux_Applications/.my_bin/systemc_init


STAY_OR_EXIT(){
	EXIT_FLAG=0
	while true; do
		echo "\nDo you want to keep the Terminal? (Y/N) "
		read EXIT_FLAG
		case "$EXIT_FLAG" in
			[Yy]* ) echo "Still exiting ...";sleep 2; exit 0;;
			[Nn]* ) echo "Exiting ..."; sleep 2; exit 0;;
			* ) echo "Please answer yes (y) or no (n).";;
		esac
	done
}

# printf "${BOLD}${BLUE_WHITE}1. Clone \`Makefile\` from <systemc_init/Makefile> ...\n${NORMAL}"
printf "${BOLD}${BLUE_WHITE}1. Enter the *cpp filename (w/o space(s))${NORMAL}\nE.g: 'hehe' NOT 'he he.cpp'\n\n${BOLD}FILENAME${NORMAL}="
read FILENAME

echo

FILENAME=$(echo "$FILENAME" | sed 's/[^a-zA-Z0-9]/_/g' | tr a-z A-Z)

if [ -z "$FILENAME" ]; then
	printf "${YELLOW}W${NORMAL}: FILENAME is ${UNDERLINED}empty${NORMAL}! \n--> use default value: FILENAME=sc_proj\n"
	FILENAME='sc_proj'
fi

printf "${BOLD}NEW_FILENAME=${NORMAL}${BOLD}${YELLOW}$FILENAME${NORMAL}\n"

echo
printf "${BOLD}${BLUE_WHITE}2. Make HELLOWORLD $FILENAME.cpp file...${NORMAL}\n"

if [ -e "$FILENAME.cpp" ] | [ -e "$FILENAME.h" ]; then
	printf "${YELLOW}W${NORMAL}: $FILENAME.cpp ${UNDERLINED}existed${NORMAL}!\n--> Aborted!\n"
	STAY_OR_EXIT
#	if [ -z $? ]; then return 0; fi
else
	printf "${YELLOW}W${NORMAL}: ${UNDERLINED}$FILENAME.h${NORMAL}\n"
	touch $FILENAME.h
	HEADER_DEFINE=$(echo "$FILENAME" | tr ' -' '_' | tr a-z A-Z)_H
    {
        echo "#ifndef __${HEADER_DEFINE}__"
        echo "#define __${HEADER_DEFINE}__"
        echo "#include <systemc.h>"
        echo "/// put your module here !!"
        echo "/// put your module here !!"
        echo "/// put your module here !!"
        echo "#endif"
    } | tee -a ./$FILENAME.h
	
	printf "${YELLOW}W${NORMAL}: ${UNDERLINED}$FILENAME.cpp${NORMAL}\n"
	cat $SYSTEMC_INIT_DIR/cppFile | tee -a ./$FILENAME.cpp
fi

echo
printf "${BOLD}${BLUE_WHITE}3. Clone Makefile into the project...${NORMAL}\n"
CLONE_FLAG=1

if [ -e 'Makefile' ]; then
	printf "${RED}Error${NORMAL}: Makefile existed, remove the existed Makefile to continue!\n"
	CLONE_FLAG=0
	# exit 1;
	STAY_OR_EXIT
#	if [ -z $? ]; then return 0; fi
fi

if [ $CLONE_FLAG -eq 1 ]; then  
	cat $SYSTEMC_INIT_DIR/Makefile.p1 | tee -a ./Makefile
	echo "SRC=$FILENAME.cpp" | tee -a ./Makefile
	cat $SYSTEMC_INIT_DIR/Makefile.p2 | tee -a ./Makefile
	# exit 0
fi

printf "4. Clone gtkwave.tcl into the project...\n"

cat $SYSTEMC_INIT_DIR/gtkwave | tee -a ./gtkwave.tcl


printf "\n${BOLD}${BLUE_WHITE}DONE!${NORMAL} Check \`SRC\` in ${BOLD}Makefile${NORMAL} file and change if needed\!\n"
