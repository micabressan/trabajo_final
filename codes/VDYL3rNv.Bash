#!/bin/sh

blkdev=`dirname $DEVPATH`
hdorsd=`echo "$device" | grep '[sh]d*' `

if [ `basename $blkdev` != "block" ]; then
        device=`basename $DEVPATH`

        case "$ACTION" in
                add)

                        #when boot, the devices may not be ready, strange
                        sleep 5
                        #first time, wait unit the jffs is built
                        if [ -z  "$(mount |grep 'overlayfs:/overlay')" ]
                        then
                                sleep 40
                        fi

                        s=`blkid /dev/$device|sed -n 's/.*TYPE="\([^"]*\)".*/\1/p'`
                        label=`blkid /dev/$device|sed -n 's/.*LABEL="\([^"]*\)".*/\1/p'`
                        [ -z "$label" ] && label=$device

                        if [ "$s" != 'vfat' -a "$s" != 'ntfs' -a "$s" != 'ext2' -a "$s" != "ext3" -a "$s" != "ext4" -a "$s" != "exfat" ];then
                                  return;
                        fi

                        mkdir -p /mnt/$label

                        if [ "$s" = 'vfat' ];then
                                mount -t $s -o utf8,rw,sync,fmask=0000,dmask=0000 /dev/$device /mnt/$label
                        fi

                        if [ "$s" = 'ntfs' ];then
                                          mount -t ntfs-3g -o utf8 /dev/$device /mnt/$label
                        fi

                        if [ "$s" = 'ext2' -o "$s" = 'ext3' -o "$s" = 'ext4' ];then
                                mount -t ext4 -o rw,sync /dev/$device /mnt/$label
                                chmod 777 /mnt/$label
                                chown root:root /mnt/$label
                        fi

                        if [ "$s" = "exfat" ]; then
                                mount -t exfat -o utf8,rw,sync /dev/$device /mnt/$label
                        fi

                ;;
                remove)
                        folder="$(grep /dev/$device /etc/mtab |awk '{print $2}')"
                        sync

                        #umount -l /dev/$device
                        umount "$folder"
                        #rmdir /mnt/$device
                        rmdir "$folder"
                ;;
        esac
fi