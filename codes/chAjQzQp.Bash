#!/bin/bash

convert_file () {
  BN=$(echo $1 | sed s/.aac$//)
  ffmpeg -i "${BN}.aac" -acodec copy -absf aac_adtstoasc "${BN}.m4a"
  unlink "$1"
}

export -f convert_file
find $1 -iname *.aac -exec  bash -c 'convert_file "$0"' {} \;