#!/bin/bash -e

cd $(dirname $0)

VERSION="${1:-{{cfg.ves.image_revision}}}"
[[ $VERSION =~ "cfg" ]] && VERSION=

# find and mount latest .iso
# mount -o loop .iso in data directory to expected netboot folders
for j in "ves-re" "ves-ce" "ves-re-mini" "ves-ce-mini"; do
  for iso in $(ls boot/vsb-$j*.iso| grep "$VERSION" | sort | tail -n 1); do
    echo Found: $i
    [[ -e boot/$j ]] || mkdir -p boot/$j
    mount | grep "boot/$j" &&\
      umount -f ./boot/$j
    mount -o ro,loop $iso ./boot/$j || true
    test -e boot/$j/initrd
    test -e boot/$j/vmlinuz
    test -e boot/$j/live/filesystem.squashfs
  done
done

