#!/bin/sh

# usage: takes 0 or more arguments
# if no arguments, assumes a valid image URL resides in the clipboard (command + c)
# if any arguments (also takes multiple), opens images normally using
# the image viewer Xee

# takes urls
# dload (md5 hash url string -> filename(s))

if [ "$#" -ge 1 ]; then
    # use given path
    FILENAME="$@"
else
    # assume clipboard url
    CLIPBOARD="$(pbpaste)"
    echo "CLIPBOARD: $CLIPBOARD"

    # dload image from remote URL
    FILENAME="/tmp/xee_images/$(echo '$CLIPBOARD' | md5)"
    echo "FILENAME: $FILENAME"
    curl "$CLIPBOARD" --create-dirs -o "$FILENAME"
fi

# # # open FILENAME(s)
open -a "Xee" "$FILENAME"
# TODO get return val of Xee using something like
# $HOME/Software/Xee.app/Contents/MacOS/Xee "/tmp/xee_images/$FILENAME"
# then you can return bash script early on failure (prevent pressing xee keys...)
# echo "xee return: $?"
sleep 0.01s
osascript -e 'tell application "System Events" to keystroke "f"'
sleep 0.01s
osascript -e 'tell application "System Events" to keystroke "*"'