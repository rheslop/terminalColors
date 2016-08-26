#!/bin/bash
#
# colors.sh
#
# Roger Heslop
#
# Used to display text with attributes
# with accompanying terminal arguments for 
# copy/paste
#
# Variables
#
FONT_COLOR=0
BACKGROUND_COLOR=0
ATTRIBUTE=0
#
# Present menu
function DISPLAY_MENU {
clear
echo "MENU:"
echo "==============="
echo ""
echo -e "FONT\t\tBACKGROUND\tATTRIBUTE"
echo ""
echo -e "\E[30m30\E[0m\t\t\E[40m40\E[0m\t\t0 Reset (Global)"
echo -e "\E[31m31\E[0m\t\t\E[41m41\E[0m\t\t\E[1m1 Bold / Bright\E[0m"
echo -e "\E[32m32\E[0m\t\t\E[42m42\E[0m\t\t\E[2m2 Faded \E[0m"
echo -e "\E[33m33\E[0m\t\t\E[43m43\E[0m\t\t\E[3m3 Italics \E[0m"
echo -e "\E[34m34\E[0m\t\t\E[44m44\E[0m\t\t\E[4m4 Underline \E[0m"
echo -e "\E[35m35\E[0m\t\t\E[45m45\E[0m\t\t\E[5m5 Blink \E[0m"
echo -e "\E[36m36\E[0m\t\t\E[46m46\E[0m\t\t\E[6m6 (No affect) \E[0m"
echo -e "\E[37m37\E[0m\t\t\E[47m47\E[0m\t\t\E[7m7 Highlight \E[0m"
echo -e "\t\t\t\t\E[8m8\E[0m (Invisible)"
echo -e "\t\t\t\t\E[9m9 Strike through\E[0m"
echo ""
echo "Type '0' to be prompted on which category to reset."
echo "^C to Exit"
echo ""
}

DISPLAY_MENU

function GET_INPUT {

DISPLAY_MENU
FORMAT_INPUT
DISPLAY_TEXT

read -p "COLORS: > " INPUT


# First, check that we're being provided an integer

IS_NUMBER='^[0-9]+$'
if ! [[ $INPUT =~ $IS_NUMBER ]] ; then
echo ""
echo "\"$INPUT\" is not not an integer."
sleep 1
GET_INPUT
fi

if [ "$INPUT" -eq 0 ] ; then

	FONT_COLOR=0
	BACKGROUND_COLOR=0
	ATTRIBUTE=0

#	echo ""
#	echo "Which would you like to reset?"
#	echo "==============="
#	echo ""
#	echo "1. Font Color"
#	echo "2. Background Color"
#	echo "3. Attribute"
#	echo ""
#	read -p "COLORS: > " ZERO_OPTION
#
#	case $ZERO_OPTION in
#		1) FONT_COLOR=0
#		;;
#		2) BACKGROUND_COLOR=0
#		;;
#		3) ATTRIBUTE=0
#		;;
#		*) echo "" 
#		echo "Out of range: $ZERO_OPTION"
#		sleep 1
#		;;
#	esac

	FORMAT_INPUT
	DISPLAY_TEXT
	GET_INPUT

elif [ "$INPUT" -ge 1 -a "$INPUT" -le 9 ] ; then
	ATTRIBUTE=$INPUT
elif [ "$INPUT" -ge 30 -a "$INPUT" -le 37 ] ; then
	FONT_COLOR=$INPUT
elif [ "$INPUT" -ge 40 -a "$INPUT" -le 47 ] ; then
	BACKGROUND_COLOR=$INPUT
else
	echo ""
	echo "Out of range: $INPUT"
	sleep 1
fi

GET_INPUT	
}

function FORMAT_INPUT {
STYLE_UNFORMATTED=$( echo -e "${ATTRIBUTE}\n${FONT_COLOR}\n${BACKGROUND_COLOR}" | sort -un )
STYLE_FORMATTED=$( echo $STYLE_UNFORMATTED | awk 'BEGIN { OFS = ";" } { $1 = $1; print}' )
echo "Style: $STYLE_FORMATTED"
echo ""
}

function DISPLAY_TEXT {
#echo -e "\E[${STYLE_FORMATTED}m echo -e \"\\\E[${STYLE_FORMATTED}mEXAMPLE TEXT: UNTERMINATED\"" 
#echo -e "\E[${STYLE_FORMATTED}m echo -e \"\\\E[${STYLE_FORMATTED}mEXAMPLE TEXT:\E[0m\\\E[0mTERMINATED\""
echo -e "echo -e \"\\\E[${STYLE_FORMATTED}mEXAMPLE TEXT: UNTERMINATED\""
echo -e "\E[${STYLE_FORMATTED}mEXAMPLE TEXT: UNTERMINATED\E[0m\n"
echo -e "echo -e \"\\\E[${STYLE_FORMATTED}mEXAMPLE TEXT:\E[0m\\\E[0m TERMINATED\""
echo -e "\E[${STYLE_FORMATTED}mEXAMPLE TEXT:\E[0m TERMINATED"
echo ""
}

GET_INPUT

