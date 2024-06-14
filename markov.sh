#!/bin/bash

# Configuration process
CONFIG=~/.config/markov/markov.conf # Default: ~/.config/markov/markov.conf
echo >> $CONFIG
sed -i '/^[[:space:]]*$/d' $CONFIG
if [ ! -s $CONFIG ]
then mkdir -p $(dirname $CONFIG)
# Default: NO_COLORS=0; VERBOSE=0; SEQUENCE=0
     echo "NO_COLORS=0; VERBOSE=0; SEQUENCE=0" > $CONFIG
fi
source $CONFIG

# Processing passed arguments
for ARGUMENT in "$@"
do case "$ARGUMENT" in
   '-V'|'--version')
     echo "markov v1.0.0"
     exit ;;
   '-u'|'--usage')
     echo "Usage: $0 [GNU or POSIX style options] file ..."
     exit ;;
   '-?'|'-h'|'--help')
     echo "Help: Any ACM A. M. Turing Award..."
     exit ;;
   '-rc'|'--reset-config')
     echo -n > $CONFIG
     echo "Reset of the config file $CONFIG is done"
     exit ;;
   '-nc'|'--no-colors') NO_COLORS=1 ;;
   '-c'|'--count') COUNT=1 ;;
   '-v'|'--verbose') VERBOSE=1 ;;
   '-s'|'--sequence') SEQUENCE=1 ;;
   *)
     if [ -f "$ARGUMENT" ]
     then echo >> $ARGUMENT
          sed -i '/^[[:space:]]*$/d' $ARGUMENT
          if [ -s "$ARGUMENT" ]
          then FILES+=("$ARGUMENT")
          else EMPTY_FILES+=("$ARGUMENT")
          fi
     else UNKNOWN_ARGUMENTS+=("$ARGUMENT")
     fi
     ;;
   esac
done

# Declaring variables of escape-sequences if they are processable and requested
if [ -t 1 ] && [ "\033[0m" != $(echo -e "\033[0m") ] && [ $NO_COLORS -eq 0 ]
then RS="\033[0m" # Reset all styles and colors
     BLD="\033[1m" # Set bold style
     UND="\033[4m" # Set underline style
     R="\033[31m" # Set red color
     B="\033[34m" # Set blue color
     P="\033[35m" # Set purple color
fi

# MAWK installation if requiered
if ! command -v mawk &> /dev/null
then if [ -f /etc/os-release ]
     then source /etc/os-release
          if ! [ -z "$ID_like" ]
          then ID=$ID_like
          fi
          sudo echo "Installing MAWK ..." >&3
          case "$ID" in
          'debian'|'ubuntu') sudo apt-get install -y mawk > /dev/null ;;
          'fedora') sudo dnf install -y mawk > /dev/null ;;
          'arch') sudo pacman -S mawk > /dev/null ;;
          esac
     fi
fi
if command -v mawk &> /dev/null
then echo "MAWK installation is complete" >&3
else echo "${R}Error.${RS} Install MAWK manually as it cannot be installed automatically." >&2
     exit 2
fi

# Declaring usage message function
usage() {
  echo -e "${P}Usage:${RS} ${BLD}$0${RS} [${BLD}POSIX or GNU style options${RS}] ${UND}file${RS} ..." >&2
  exit 2
}

# Unknown argument(s) passed case
if [ ${#UNKNOWN_ARGUMENTS[@]} -ne 0 ]
then echo -e -n "${R}Error.${RS}" >&2
     if [ ${#UNKNOWN_ARGUMENTS[@]} -eq 1 ]
     then echo -n " The" >&2
     else echo -n " Each" >&2
     fi
     echo " following argument is neither option nor file: ${UNKNOWN_ARGUMENTS[@]}" >&2
     usage
fi

# Empty files passed case
if [ ${#EMPTY_FILES[@]} -ne 0 ]
then echo -e -n "${R}Error.${RS}" >&2
     if [ ${#EMPTY_FILES[@]} -eq 1 ]
     then echo -n " The" >&2
     else echo -n " Each" >&2
     fi
     echo " following file is empty: ${EMPTY_FILES[@]}" >&2
     usage
fi

# No file passed case
if [ ${#FILES[@]} -eq 0 ]
then echo -e "${R}Error.${RS} No file passed" >&2
     usage
fi

# Processing sequences if they are requested
if [ $SEQUENCE -eq 1 ]
then for SEQ in ${FILES[@]}
     do LINENR=0
        while read ALGORITHM
        do LINENR=$((LINENR + 1))
           if [ -f "$ALGORITHM" ]
           then echo >> $ALGORITHM
                sed -i '/^[[:space:]]*$/d' $ALGORITHM
                if [ -s "$ALGORITHM" ]
                then ALGORITHMS+=("$ALGORITHM")
                else echo -e "${R}Error.${RS} Line $LINENR of $SEQ: $ALGORITHM is empty" >&2
                     BOOL=1
                fi
           else echo -e "${R}Error.${RS} Line $LINENR of $SEQ: $ALGORITHM is not present" >&2
                BOOL=1
           fi
        done < $SEQ
     done
else ALGORITHMS=${FILES[@]}
     unset FILES
fi
if [ $BOOL -eq 1 ]
then exit 2 
fi

# Incorrect second word case
if [ "$(awk -v DEF=$DEF -v RED=$RED '
  {
    if ($2 != "," && $2 != ".") {
      print RED "Error." DEF " Algorithm file " FILENAME ", line " FNR \
      ": the second word must be comma or period; found " RED $2 DEF ""
    }
  }' ${ALGORITHMS[@]} | tee /dev/stderr)" ]
then exit 2
fi

# Processing input word
while true
do read -e -p "Input word: " WORD
   ALNUM_WORD=$(echo "$WORD" | tr -cd [:alnum:])
   if [ $(echo "$ALNUM_WORD" | wc -c) -gt 131072 ]
   then echo -e "${R}Error.${RS} Input word lenght exceeds the maximum value of 131 072" >&2
        exit 2
   fi
   if [ "$WORD" != "$ALNUM_WORD" ]
   then echo -e -n "${B}Warning.${RS} "
        WORD_CHARS=($(echo "$WORD" | grep -o .))
        for CHAR in "${WORD_CHARS[@]}"
        do if [ "$(echo "$CHAR")" != "$(echo "$CHAR" | tr -cd [:alnum:])" ]
           then echo -e -n "${R}$CHAR${RS}"
           else echo -n "$CHAR"
           fi
        done
        echo " includes non alpha-numerical characters"
        echo -n "Proceed with $ALNUM_WORD [n] or re-enter the word [Y]? "
        read
        if [[ $REPLY =~ ^[nNmMbBтТьЬиИ] ]]
        then echo "Input word: $ALNUM_WORD"
             break
        fi
   else break
   fi
done

# Interpreting input word with approriate options
for ALG in "${ALGORITHMS[@]}"
do WORD="$(./interp.awk WORD=$WORD $ALG)"
done
echo $WORD
