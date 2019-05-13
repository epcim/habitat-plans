#!/bin/bash -e

BASE=$(dirname $0)
DATA=$BASE/../data
VERSION="${1:-{{cfg.ves.image_revision}}}"

cd $DATA

# extract
bunzip2 vsb-$i*${VERSION}*.img.bz2 || true

# find and mount latest .img
# mount -o loop .img in data directory to expected netboot folders
for j in "ves-re" "ves-ce" "ves-re-mini" "ves-ce-mini"; do
  for i in $(ls boot/vsb-$j*.img 2>/dev/null| grep "$VERSION" | sort | tail -n 1); do
    echo Found: $i
    [[ -e boot/$j ]] || mkdir -p boot/$j
    mount | grep "boot/$j" &&\
      umount -f ./boot/$j
    mount -o ro,loop $(basename $i .bz2) ./boot/$j
    test -e boot/$j/initrd
    test -e boot/$j/vmlinuz
    test -e boot/$j/live/filesystem.squashfs
  done
done

