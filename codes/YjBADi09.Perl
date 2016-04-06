#!/usr/bin/env bash

# Set initial options
echo "arkos" > /etc/hostname
localectl set-locale "LANG=en_US.UTF-8"

# Get prerequisites
pacman --noconfirm -Sy wget git
git config --global url."https://".insteadOf "git://"

# Install arkOS package repo details
wget -O /tmp/arkos-keyring.pkg.tar.xz https://nyus.mirror.arkos.io/x86_64/arkos/arkos-keyring-20150321-1-any.pkg.tar.xz
wget -O /tmp/arkos-mirrorlist.pkg.tar.xz https://nyus.mirror.arkos.io/x86_64/arkos/arkos-mirrorlist-20150413-1-any.pkg.tar.xz
pacman --noconfirm -U /tmp/arkos-keyring.pkg.tar.xz
pacman --noconfirm -U /tmp/arkos-mirrorlist.pkg.tar.xz
#curl "https://www.archlinux.org/mirrorlist/?country=CA&protocol=http&ip_version=4" 2>/dev/null > /etc/pacman.d/mirrorlist && sed -i 's/\#Server/Server/g' /etc/pacman.d/mirrorlist

# Update the system
pacman --noconfirm -Syu

# Install system dependencies
pacman --noconfirm -Sy python2 python2-pip redis openldap fail2ban nodejs npm

# Install arkOS packages
pacman --noconfirm -S arkos-redis arkos-openldap arkos-core arkos-kraken arkos-genesis

# Make sure nginx uses the `sites-available` hierarchy
if [ ! -d /etc/nginx/sites-available ]
then
	mkdir -p /etc/nginx/sites-{available,enabled}
	mkdir -p /srv/http/webapps
	wget -O /tmp/nginx.conf https://raw.githubusercontent.com/cznweb/arkos-vagrant/master/nginx.conf
	cp /tmp/nginx.conf /etc/nginx/nginx.conf
fi

rm -r /var/cache/pacman/pkg/*