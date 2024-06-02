#!/bin/sh

if [ $# -eq 0 ]; then
    echo -e "\e[31mError type 1:\e[0m no algorithm(s) passed.
       \e[35mUsage:\e[0m $0 <algorithm 1> [algorithm 2] ..." >&2
    exit 2
fi




missing_algorithms=( "missing algorithm(s)" )
for passed_algorithm in "$@"; do
    if ! [ -f "$passed_algorithm" ]; then
        missing_algorithms+=("$passed_algorithm,")
    fi
done

if [ ${#missing_algorithms[@]} -ne 1 ]; then
    echo -e "\e[31mError type 2:\e[0m ${missing_algorithms[@]}
       \e[35mUsage:\e[0m $0 <algorithm 1> [algorithm 2] ..." | sed 's/,$/./' >&2
    exit 2
fi




while true; do
    read -e -p "Word processed: " WORD
    ALNUM_WORD=$(echo "$WORD" | tr -cd [:alnum:])
    if [ "$WORD" != "$ALNUM_WORD" ]; then
        echo -e -n "\e[34mWarning type 1:\e[0m \"$WORD\" includes non alpha-numerical characters.
        \e[32mAction:\e[0m re-enter the word [Y] or proceed with \"$ALNUM_WORD\" [n]? "; read;
        if [[ $REPLY =~ ^[nNmMbBтТьЬиИ] ]]; then echo "Word processed: $ALNUM_WORD"; break; fi
    else break
    fi
done