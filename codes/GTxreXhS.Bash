Para ver error:

startx

================

Ctrl+Alt+F1
me logue y veo si Xauthority o ICEauthority a cambiado su user y grupo por el root

ls -la | grep Xauthority
ls -la | grep ICE


sudo chown $USER:$USER ~/.Xauthority ó
sudo chown $USER:$USER ~/.ICEauthority
reboot

=====================

Entrar con el live, entrar a la HOME y luego borrar ~/.Xauthority
reboot

======================

sudo apt-get install xubuntu-desktop

========================

sudo chmod -R 775 ~
sudo chown -R $USER:$USER /home/tuusuario