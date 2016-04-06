#!/bin/bash
xo_exit() {
	disown
	exit
}
case "$1" in
	g:*)
		exo-open "https://www.google.ru/search?q=${*#*:}" &
		xo_exit
	;;
	w:*)
		exo-open "https://ru.wikipedia.org/wiki/${*#*:}" &
		xo_exit
	;;
esac
if hash -- "$1" 2>/dev/null
then
	$@ &
	xo_exit
elif [ -e "$1" ]
then
	if [ -x "$1" ] && [ ! -d "$1" ]
	then
		if [[ $1 == /* ]]
		then
			"$@" &
			xo_exit
		else
			./"$@" &
			xo_exit
		fi
	else
		exo-open "$@" &
		xo_exit
	fi
else
	exo-open "$@" &
	xo_exit
fi