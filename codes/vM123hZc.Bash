~/script/patch-diff % ls -l rc.conf.3 
-rw-r--r--  1 fnoyanisi  fnoyanisi  380 Aug 24 22:50 rc.conf.3
~/script/patch-diff % grep wlans_iwn0 rc.conf.3 
wlans_iwn0="wlan0"
~/script/patch-diff % ex -sc '%s/wlans_iwn0="wlan0"/XXX/g|x' ./rc.conf.3
^Z
zsh: suspended  ex -sc '%s/wlans_iwn0="wlan0"/XXX/g|x' ./rc.conf.3
~/script/patch-diff %