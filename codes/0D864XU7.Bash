#!/bin/bash

# Written by Shrimadhav U K

CURDIR=`pwd`

# learn sed from this link
# http://www.grymoire.com/Unix/Sed.html
STUDIO=`curl -s http://developer.android.com/sdk/index.html | grep dl.google.com |  sed s/'href=\"/'''/g  | grep linux.zip | sed s/'\"/'''/g`

wget -c ${STUDIO} -O "androidstudio.zip"

sudo unzip androidstudio.zip -d "/opt/"

sudo mkdir -p /opt/android-sdk

sudo chown ${USERNAME} -R /opt/android-studio 

sudo chown ${USERNAME} -R /opt/android-sdk

/opt/android-studio/bin/studio.sh

rm -i "androidstudio.zip"