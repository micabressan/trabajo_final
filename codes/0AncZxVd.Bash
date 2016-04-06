#!/bin/bash

cat "$1" | tr -d "\-/" >> /tmp/audiobook.txt
espeak -f /tmp/audiobook.txt -w "$1.wav"
rm /tmp/audiobook.txt
ffmpeg -i "$1.wav" "$1.ogg"
rm "$1.wav"
rename "s/.txt//" *.txt.ogg