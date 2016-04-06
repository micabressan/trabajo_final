#!/bin/bash
clear

echo "################################################################################################"
echo "# This scriptl will install an Arma 3 Epoch Server on a debian based linux distribution        #"
echo "# A user called steam will be created and all necessary files will be downloaded.              #"
echo "# This script was tested by me. However i am not responsibly for any problems that may occour. #"
echo "#                                                                                              #"
echo "# Script by Flow, www.pixelkiller.de                                                           #"
echo "################################################################################################"
echo

echo
echo
echo "ATTENTION: If you already have a user called steam it will be deleted (home dir also!!!!)"
echo
echo
echo -n "If you did understand and want to continue, type 'understand' : "
read answer
if echo "$answer" | grep -iq "understand" ;then
        echo
        echo "Start installing required files"
        echo "==============================="
else
    exit
fi
echo
echo
echo -n "Please enter your steam username: "
read steamuser
echo -n "Please enter your steam password: "
read steampass
echo
echo

apt-get install lib32gcc1 gcc-multilib unzip redis-server screen -y


if id -u "steam" >/dev/null 2>&1; then
        echo -n "User steam already exists. Removing user and homedir for fresh start"
        rm -rf /home/steam/*
        deluser steam --remove-home
        adduser steam --quiet --gecos GECOS --disabled-password --disabled-login
else
        echo "User steam will be created. Installing server to /home/steam."
        echo "Do not forget to set a password for the user steam. Currently login is disabled"
        echo "You have to login as root and switch to steam user when starting arma3server"
        adduser steam --quiet --gecos GECOS --disabled-password --disabled-login
fi

echo

echo "Downloading steamcmd"

cd /home/steam
mkdir epoch
mkdir steamcmd && cd steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz --quiet --no-check-certificate && tar xzf steamcmd_linux.tar.gz && rm -f steamcmd_linux.tar.gz
./steamcmd.sh +quit

echo "Installing Arma 3"
echo
./steamcmd.sh +login $steamuser $steampass +force_install_dir /home/steam/epoch +app_update 233780 validate +quit

echo "Installing Epoch"
echo
./steamcmd.sh +login $steamuser $steampass +force_install_dir /home/steam/epoch +workshop_download_item 107410 421839251 +quit

mv /home/steam/steamcmd/steamapps/workshop/content/107410/421839251 /home/steam/epoch/@epoch

clear

cp -f /home/steam/epoch/@epoch/Keys/*.bikey /home/steam/epoch/keys

mkdir /home/steam/tmpserverfiles

cd /home/steam/tmpserverfiles

echo "Installing Epoch Hive files"
echo

wget https://github.com/EpochModTeam/Epoch/archive/master.zip --quiet --no-check-certificate && unzip master.zip

cp -Rf /home/steam/tmpserverfiles/Epoch-master/Server_Install_Pack/* /home/steam/epoch/

rm -rf /home/steam/tmpserverfiles

HIVEINI=`cat /home/steam/epoch/@epochhive/EpochServer.ini`
EPOCHPASS=`date +%s | sha256sum | base64 | head -c 32 ; echo`
NEWHIVEINI=`echo "$HIVEINI" | sed -e 's/foobared/'$EPOCHPASS'/g'`
STARTSCRIPT=`cat /home/steam/epoch/epoch_linux_startscript.sh | sed -e 's:'/home/arma3':'/home/steam/epoch':g'`

echo "$STARTSCRIPT" > /home/steam/epoch/epoch_linux_startscript.sh

cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

echo "requirepass $EPOCHPASS" >> /etc/redis/redis.conf

echo "$NEWHIVEINI" > /home/steam/epoch/@epochhive/EpochServer.ini

/etc/init.d/redis-server restart

chmod +x /home/steam/epoch/epoch_linux_startscript.sh

mkdir /home/steam/epoch/logs

mv /home/steam/epoch/@epoch/Addons /home/steam/epoch/@epoch/addons

chown -R steam:steam /home/steam

clear
echo "ALL DONE, DO NOT FORGET TO EDIT YOUR CONFIGS. I ALREADY CONFIGURED REDIS FOR YOU"

exit