#!/bin/bash
# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <ezekiel@lcarsos.com> wrote this file.  As long as you retain this notice
# you can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return.
# Ezekiel Chopper
# -----------------------------------------------------------------------------

if [[ "$#" -lt "1" ]]; then
    cat >&2 <<EOF
Usage: $0 DEV [...]
  Provide a list of block devices relative to /dev/

  This script mounts all devices passed in, makes sure they use a partition
  table, then as a bulk operation, copies all files that end with mp3 to the
  devices, then unmounts them.
    This script runs a filesystem sync, which blocks the script until all fs'
  have completed any pending transactions. Don't run this script in one
  terminal, prep more drive and expect to start another run in another window.
    If an error occurs along the way, the script will exit with the error
  code of the program that produced the error. Check the output to see which
  step produced the error then go look up the errno.

  WARNING: This script does no safety checking. Be sure of what device you are
  writing to.
EOF
    exit 1
fi

for i in $@; do
    sudo mkdir -p /mnt/usb/$i || exit $?
    sudo mount /dev/$i /mnt/usb/$i || {
        # This is the line that murdered your device. You were warned. I'm not
        # sorry.
        sudo parted --script /dev/$i mklabel loop
        sudo mkfs.vfat -F 16 -I /dev/$i
        sudo mount /dev/$i /mnt/usb/$i
    } || exit $?
    echo "mounting $i"
done
ls *mp3
for i in $@; do
    echo "copying to $i"
    sudo cp *mp3 /mnt/usb/$i &
done
wait
echo ""
echo "syncing"
sync || exit $?
for i in $@; do
    echo "unmounting $i"
    sudo umount -R /mnt/usb/$i || echo $?
done
echo "exiting"