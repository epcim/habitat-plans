#!/bin/bash

VERSION="${1:-{{cfg.ves.image_revision}}}"

# find and mount latest .iso
# mount -o loop .iso in data directory to expected netboot folders

for j in "ves-re" "ves-ce" "ves-re-mini" "ves-ce-mini"; do
  for iso in $(ls vsb-$j*.iso| grep $VERSION | sort | tail -n 1); do
    [[ -e boot/$j ]] || mkdir -p boot/$j
    mount | grep "boot/$j" &&\
      umount -f ./boot/$j
    mount -o loop $iso ./boot/$j || true
  done
done

