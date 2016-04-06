VBoxManage createvm --name "WinXP" --ostype WindowsXP --register
VBoxManage modifyvm "WinXP" --memory 1024 --acpi on --nic1 nat
VBoxManage storagectl "WinXP" --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach "WinXP" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "/path/to/WinXP.vdi"
VBoxManage startvm "WinXP"