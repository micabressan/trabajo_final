#!/bin/bash
case "$1" in
	g:*)
		exo-open https://www.google.ru/search?q=`echo $* | sed 's/g\://'` &
		disown
		exit
	;;
	w:*)
		exo-open https://ru.wikipedia.org/wiki/`echo $* | sed 's/w\://'` &
		disown
		exit
	;;
esac
if [ `compgen -c | grep -x "$1"` ]
then
	$* &
	disown
	exit
elif [ -e "$1" ]
then
	if [ -x "$1" ] && [ ! -d "$1" ]
	then
		if [[ "$(dirname $1)" = "." ]]
		then
			./$* &
			disown
			exit
		else
			$* &
			disown
			exit
		fi
	else
		exo-open "$1" &
		disown
		exit
	fi
else
	exo-open "$1" &
	disown
	exit
fi