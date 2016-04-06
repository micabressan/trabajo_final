sudo apt-get update
sudo apt-get install firmware-b43-installer
sudo modprobe -r b43 bcma
sudo modprobe -r brcmsmac bcma
sudo modprobe -r wl
sudo modprobe b43
echo "blacklist b43" | sudo tee -a /etc/modprobe.d/blacklist-broadcom-wireless.conf
sudo update-initramfs -u