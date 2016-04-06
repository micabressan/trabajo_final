#!/bin/bash
xo_exit() {
	disown
	exit
}
urlencode() {
    local LC_ALL=C
    local symbol
    local -i i len=${#1}
    for (( i = 0; i < len; ++i )); do
        symbol=${1:$i:1}
        if [[ $symbol == [-_.~a-zA-Z0-9] ]]; then
            printf %c "$symbol"
        else
            printf %%%02X "'$symbol"
        fi
    done
    printf '\n'
}
if [ -z "$1" ]
then
	exit
fi
case "$1" in
	g:*)
		exo-open "https://www.google.ru/search?q=$(urlencode "${*#*:}")" &
		xo_exit
	;;
	w:*)
		exo-open "https://ru.wikipedia.org/wiki/$(urlencode "${*#*:}")" &
		xo_exit
	;;
esac
if command -v -- "$1" 2>/dev/null >/dev/null && [[ $1 != *.desktop ]]
then
	"$@" &
	xo_exit
elif [ -e "$1" ]
then
	if [ -x "$1" ] && [ ! -d "$1" ] && [[ $1 != *.desktop ]]
	then
		./"$@" &
		xo_exit
	else
		exo-open "$@" &
		xo_exit
	fi
else
	exo-open "$@" &
	xo_exit
fi