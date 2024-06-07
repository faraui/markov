#!/bin/sh

# Configuration process
CONFIG=~/.config/markov/markov.conf # Default: ~/.config/markov/markov.conf
if [ ! -s $CONFIG ]; then
  mkdir -p $(dirname $CONFIG)
  if [ ! -e $CONFIG ]; then
    touch $CONFIG
  fi                            # Default:
  echo "NO_COLORS=0" >> $CONFIG # NO_COLORS=0
  echo "VERBOSE=1" >> $CONFIG   # VERBOSE=1
  echo "SEQUENCE=0" >> $CONFIG  # SEQUENCE=0
fi; source $CONFIG

# Processing passed arguments
for ARGUMENT in "$@"; do
  case "$ARGUMENT" in
    -h|--help)
      echo "Help: Any ACM A. M. Turing Award..."
      exit 0
      ;;
    -u|--usage)
      echo "Usage: $0 [GNU or POSIX style options] <file 1> [file 2] ..."
      exit 0
      ;;
    -rc|--reset-config)
      rm -rf $CONFIG
      echo "Reset of the configuration file \"$CONFIG\" has been performed"
      exit 0
      ;;
    -f|--format)
      # ...
      ;;
    -nc|--no-colors)
      NO_COLORS=1
      ;;
    -v|--verbose)
      VERBOSE=1
      ;;
    -s|--sequence)
      SEQUENCE=1
      ;;
    *)
      if [ -f "$ARGUMENT" ]; then
        FILES+=("$ARGUMENT")
      else
        UNKNOWN_ARGUMENTS+=("$ARGUMENT")
      fi
      ;;
  esac
done

# Declaring variables of color escape-sequences if they are processable and requested
if [ -t 1 ] && [ $(echo "\033[0m") != $(echo -e "\033[0m") ] && [ $NO_COLORS -eq 0 ]; then
  DEF="\033[0m"
  RED="\033[31m"
  BLUE="\033[34m"
  PURP="\033[35m"
fi

# Unknown argument(s) passed case
if [ ${#UNKNOWN_ARGUMENTS[@]} -ne 0 ]; then
  echo -e -n "${RED}Error.${DEF}" >&2
  if [ ${#UNKNOWN_ARGUMENTS[@]} -eq 1 ]; then
    echo -n " The" >&2
  else
    echo -n " Each" >&2
  fi
  echo " following argument is neither option nor file: ${UNKNOWN_ARGUMENTS[@]}" >&2
  echo -e "${PURP}Usage:${DEF} $0 [GNU or POSIX style options] <file 1> [file 2] ..." >&2
  exit 2
fi

# No file passed case
if [ ${#FILES[@]} -eq 0 ]; then
  echo -e "${RED}Error.${DEF} No file passed" >&2
  echo -e "${PURP}Usage:${DEF} $0 [GNU or POSIX style options] <file 1> [file 2] ..." >&2
  exit 2
fi

# Incorrect second word case
if [ "$(awk -v DEF=$DEF -v RED=$RED '
{
  if ($2 != "," && $2 != ".") {
    print RED "Error." DEF " File " FILENAME ", line " FNR \
    ": the second word must be comma or period; found " RED $2 DEF ""
  }
}' ${FILES[@]} | tee /dev/stderr)" ]; then
  exit 2
fi

# Handling word to be processed
while true; do
  read -e -p "Word processed: " WORD
  ALNUM_WORD=$(echo "$WORD" | tr -cd [:alnum:])
  if [ "$WORD" != "$ALNUM_WORD" ]; then
    echo -e -n "${BLUE}Warning.${DEF} "
    WORD_CHARS=($(echo "$WORD" | grep -o .))
    for CHAR in "${WORD_CHARS[@]}"; do
      if [ "$( echo "$CHAR" )" != "$( echo "$CHAR" | tr -cd [:alnum:] )" ]; then
        echo -e -n "${RED}$CHAR${DEF}"
      else
        echo -n "$CHAR"
      fi
    done
    echo " includes non alpha-numerical characters"
    echo -n "Proceed with $ALNUM_WORD [n] or re-enter the word [Y]? "
    read
    if [[ $REPLY =~ ^[nNmMbBтТьЬиИ] ]]; then
      echo "Word processed: $ALNUM_WORD"
      break
    fi
  else
    break
  fi
done





































###
