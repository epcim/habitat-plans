#!/bin/bash

BASE=$(dirname $0)
DATA=$BASE/../data
VERSION="${1:-{{cfg.ves.image_revision}}}"

# get partition offset
offset() {
  IMAGE=$1
  PART=$2
  sfdisk -l $IMAGE | grep $IMAGE$PART |\
  awk 'BEGIN { FS="[ *\t]+"}
     /.+/ { print $2*512; found=1 }
     END { if(!found) exit 1 }'\
  || { echo "No such partition in the image"; exit 1; }
}

cd $DATA

# extract .bz2, if not yet
for i in $(ls boot/vsb-$VERSION*.img.bz2); do
  test -e $(basename $i .bz2) ||\
    ls $i | xargs -r bunzip2 -kf
done

set -e
# find and mount latest .img
# mount -o loop .img in data directory to expected netboot folders
for j in "ves-re" "ves-ce" "ves-re-mini" "ves-ce-mini"; do
  for i in $(ls boot/vsb-$j*.img 2>/dev/null| grep "$VERSION" | sort | tail -n 1); do
    echo Found: $i
    [[ -e boot/$j ]] || mkdir -p boot/$j
    mount | grep "boot/$j" &&\
      umount -f ./boot/$j
    OFFSET=$(offset $i 3)
    echo mount -o ro,loop,offset=$OFFSET $DATA/$i $DATA/boot/$j
    #NOTE, mount sometimes returns "Invalid argument", next try it works
    sleep 5
    bash -c "/bin/mount -o loop,offset=$OFFSET $DATA/$i $DATA/boot/$j"
    test -e boot/$j/initrd
    test -e boot/$j/vmlinuz
    test -e boot/$j/live/filesystem.squashfs
  done
done
