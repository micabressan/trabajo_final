#!/bin/bash

#  DIR je zkoumaný adresář předaný na příkazové řádce při spuštění skriptu. V případě, že skriptu nebyl zadán adresář, je DIR aktuální pracovní adresář (cwd).

if [ -z $1 ]; then
  root=$PWD
elif [ ! -d ${root=`readlink -f $1`} ]; then
  echo 'Directory does not exists!'
  exits
fi

echo $root