#!/bin/bash
xo_exit() {
	disown
	exit
}
case "$1" in
	g:*)
		exo-open "https://www.google.ru/search?q=`echo $* | sed 's/g\://'`" &
		xo_exit
	;;
	w:*)
		exo-open "https://ru.wikipedia.org/wiki/`echo $* | sed 's/w\://'`" &
		xo_exit
	;;
esac
if [ `compgen -c | grep -x "$1"` ]
then
	$* &
	xo_exit
elif [ -e "$1" ]
then
	if [ -x "$1" ] && [ ! -d "$1" ]
	then
		if [[ "$(dirname $1)" = "." ]]
		then
			./$* &
			xo_exit
		else
			$* &
			xo_exit
		fi
	else
		exo-open "$1" &
		xo_exit
	fi
else
	exo-open "$1" &
	xo_exit
fi