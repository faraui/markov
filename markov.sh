#!/bin/sh

# Configuration
CONFIG=~/.config/markov/markov.conf # Default: ~/.config/markov/markov.conf
if [ ! -s $CONFIG ]; then
  mkdir -p $(dirname $CONFIG)
  if [ ! -e $CONFIG ]; then
    touch $CONFIG
  fi
  echo "HELP=0
NO_COLORS=0
VERBOSE=0
FILE=0" > $CONFIG
fi

source $CONFIG
unset CONFIG


# Handling options
if [[ $HELP -ne 0 ]]; then
  echo $HELP
fi


# Declaring variables of color escape-sequences if they are processable and requested
if [ $(echo "e[0m") != $(echo -e "e[0m") ] || [[ $NO_COLORS -ne 0  ]]; then
  DEF="\e[0m"
  RED="\e[31m"
  GREEN="\e[32m"
  BLUE="\e[34m"
  PURP="\e[35m"
fi


# Handling no algorithm(s) passed case
if [ $# -eq 0 ]; then
  echo -e "${RED}Error type 1:${DEF} no algorithm(s) passed.
       ${PURP}Usage:${DEF} $0 [POSIX or GNU style options] <algorithm 1> [algorithm 2] ..." >&2
  exit 2
fi

# Handling missing algorithm(s) passed case
for passed_algorithm in "$@"; do
  if ! [ -f "$passed_algorithm" ]; then
    missing_algorithms+=("$passed_algorithm,")
  fi
done

if [ ${#missing_algorithms[@]} -ne 0 ]; then
  echo -e "${RED}Error type 2:${DEF} missing algorithm(s) ${missing_algorithms[@]}
       ${PURP}Usage:${DEF} $0 [POSIX or GNU style options] <algorithm 1> [algorithm 2] ..." | sed 's/,$/./' >&2
  exit 2
fi


# Handling word to be processed
while true; do
  read -e -p "Word processed: " WORD
  ALNUM_WORD=$(echo "$WORD" | tr -cd [:alnum:])
  if [ "$WORD" != "$ALNUM_WORD" ]; then
    echo -e -n "${BLUE}Warning type 1:${DEF} \""
    WORD_CHARS=($(echo "$WORD" | grep -o .))
    for CHAR in "${WORD_CHARS[@]}"; do
      if [ "$( echo "$CHAR" )" != "$( echo "$CHAR" | tr -cd [:alnum:] )" ]; then
        echo -e -n "${RED}$CHAR${DEF}"
      else
        echo -n "$CHAR"
      fi
    done
    echo -e -n "\" includes non alpha-numerical characters.
        ${GREEN}Action:${DEF} re-enter the word [Y] or proceed with \"$ALNUM_WORD\" [n]? "
    read
    if [[ $REPLY =~ ^[nNmMbBтТьЬиИ] ]]; then
      echo "Word processed: $ALNUM_WORD"
      break
    fi
  else
    break
  fi
done
