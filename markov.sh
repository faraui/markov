#!/bin/sh

# Declaring variables of color escape-sequences if these last are processable
if [ $(echo "\e[0m") != $(echo -e "\e[0m") ]; then
    DEF="\e[0m"; RED="\e[31m"; GREEN="\e[32m"; BLUE="\e[34m"; PURP="\e[35m"
fi

# Handling no algorithm(s) passed case
if [ $# -eq 0 ]; then
    echo -e "${RED}Error type 1:${DEF} no algorithm(s) passed.
       ${PURP}Usage:${DEF} $0 [options] <algorithm 1> [algorithm 2] ..." >&2
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
       ${PURP}Usage:${DEF} $0 [options] <algorithm 1> [algorithm 2] ..." | sed 's/,$/./' >&2
    exit 2
fi

# Handling word to be processed
while true; do
    read -e -p "Word processed: " WORD
    ALNUM_WORD=$(echo "$WORD" | tr -cd [:alnum:])
    if [ "$WORD" != "$ALNUM_WORD" ]; then
        echo -e -n "${BLUE}Warning type 1:${DEF} \"$WORD\" includes non alpha-numerical characters.
        ${GREEN}Action:${DEF} re-enter the word [Y] or proceed with \"$ALNUM_WORD\" [n]? "; read;
        if [[ $REPLY =~ ^[nNmMbBтТьЬиИ] ]]; then echo "Word processed: $ALNUM_WORD"; break; fi
    else break
    fi
done



for algorithm in "$@"; do
    ###
    while true; do
        ###
    done
done
