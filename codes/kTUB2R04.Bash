#!/bin/bash
xo_spawn() {
    "$@" &
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
		xo_spawn exo-open "https://www.google.ru/search?q=$(urlencode "${*#*:}")"
	;;
	w:*)
		xo_spawn exo-open "https://ru.wikipedia.org/wiki/$(urlencode "${*#*:}")"
	;;
esac
if command -v -- "$1" 2>/dev/null >/dev/null && [[ $1 != *.desktop ]]
then
	xo_spawn "$@"
elif [ -e "$1" ]
then
	if [ -x "$1" ] && [ ! -d "$1" ] && [[ $1 != *.desktop ]]
	then
		xo_spawn ./"$@"
	else
		xo_spawn exo-open "$@"
	fi
else
	xo_spawn exo-open "$@"
fi