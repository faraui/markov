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
   -h|--help)
     echo "Help: Any ACM A. M. Turing Award..."
     exit 0
     ;;
   -u|--usage)
     echo "Usage: $0 [GNU or POSIX style options] <file 1> [file 2] ..."
     exit 0
     ;;
   -rc|--reset-config)
     echo -n > $CONFIG
     echo "Reset of the config file $CONFIG has been performed"
     exit 0
     ;;
   -nc|--no-colors) NO_COLORS=1 ;;
   -v|--verbose) VERBOSE=1 ;;
   -s|--sequence) SEQUENCE=1 ;;
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

# Declaring variables of color escape-sequences if they are processable and requested
if [ -t 1 ] && [ "\033[0m" != $(echo -e "\033[0m") ] && [ $NO_COLORS -eq 0 ]
then DEF="\033[0m"
     RED="\033[31m"
     BLUE="\033[34m"
     PURP="\033[35m"
fi

# Unknown argument(s) passed case
if [ ${#UNKNOWN_ARGUMENTS[@]} -ne 0 ]
then echo -e -n "${RED}Error.${DEF}" >&2
     if [ ${#UNKNOWN_ARGUMENTS[@]} -eq 1 ]
     then echo -n " The" >&2
     else echo -n " Each" >&2
     fi
     echo " following argument is neither option nor file: ${UNKNOWN_ARGUMENTS[@]}" >&2
     echo -e "${PURP}Usage:${DEF} $0 [GNU or POSIX style options] <file 1> [file 2] ..." >&2
     exit 2
fi

# Empty files passed case
if [ ${#EMPTY_FILES[@]} -ne 0 ]
then echo -e -n "${RED}Error.${DEF}" >&2
     if [ ${#EMPTY_FILES[@]} -eq 1 ]
     then echo -n " The" >&2
     else echo -n " Each" >&2
     fi
     echo " following file is empty: ${EMPTY_FILES[@]}" >&2
     echo -e "${PURP}Usage:${DEF} $0 [GNU or POSIX style options] <file 1> [file 2] ..." >&2
     exit 2
fi

# No file passed case
if [ ${#FILES[@]} -eq 0 ]
then echo -e "${RED}Error.${DEF} No file passed" >&2
     echo -e "${PURP}Usage:${DEF} $0 [GNU or POSIX style options] <file 1> [file 2] ..." >&2
     exit 2
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
                else echo -e "${RED}Error.${DEF} Line $LINENR of $SEQ: $ALGORITHM is empty" >&2
                     AUS="J"
                fi
           else echo -e "${RED}Error.${DEF} Line $LINENR of $SEQ: $ALGORITHM is not present" >&2
                AUS="J"
           fi
        done < $SEQ
     done
else ALGORITHMS=${FILES[@]}
     unset FILES
fi
if [ "$AUS" = "J" ]
then exit 2 
fi

# Incorrect second word case
if [ "$(awk -v DEF=$DEF -v RED=$RED '
  { if ($2 != "," && $2 != ".") {
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
   then echo -e "${RED}Error.${DEF} Input word lenght exceeds the maximum value of 131 072" >&2
        exit 2
   fi
   if [ "$WORD" != "$ALNUM_WORD" ]
   then echo -e -n "${BLUE}Warning.${DEF} "
        WORD_CHARS=($(echo "$WORD" | grep -o .))
        for CHAR in "${WORD_CHARS[@]}"
        do if [ "$(echo "$CHAR")" != "$(echo "$CHAR" | tr -cd [:alnum:])" ]
           then echo -e -n "${RED}$CHAR${DEF}"
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

# No-verbose interpreter
awk -v WORD=$WORD '
{ if ($3 == "^") { $3 = "" }
  if (sub($1, $3, WORD)) {
    if ($2 == ",") {
      for (i = ARGC; i > ARGIND; i--)
        ARGV[i] = ARGV[i - 1]
      ARGC++
      ARGV[ARGIND + 1] = FILENAME
    }
    nextfile
  }
} END {
  print ""
  print WORD
}' ${ALGORITHMS[@]}
