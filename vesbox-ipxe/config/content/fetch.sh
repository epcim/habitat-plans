#!/bin/bash -e

BASE=$(dirname $0)
DATA=$BASE/../data

# pipe separated list of required revisions to sync
VERSION="${1:-{{cfg.ves.image_revision}}}"

# try to fetch bootstrap images from upstream servers
test -e boot || mkdir boot
test -e $BASE/id_rsa_imagesync && RSYNC_KEY="-i $BASE/id_rsa_imagesync" || RSYNC_KEY=""

for PATTERN in $(echo "${VERSION}" | tr '|' ' ' |xargs -n1); do
  rsync -avh -e "ssh -o StrictHostKeyChecking=no $RSYNC_KEY" --include "*ipxe*" --include "*${PATTERN}*" --exclude "*" \
    "imagesync@images.vedge.io:data/boot/" $DATA/boot/ || exit 0
done

# failover
[[ -e $DATA/boot/ipxe.iso ]] || curl -qls http://boot.ipxe.org/ipxe.iso > $DATA/boot/ipxe.iso
[[ -e $DATA/boot/ipxe.usb ]] || curl -qls http://boot.ipxe.org/ipxe.usb > $DATA/boot/ipxe.usb.img
[[ -e $DATA/boot/ipxe.efi ]] || curl -qls http://boot.ipxe.org/ipxe.efi > $DATA/boot/ipxe.efi.img

# housekeeping
for i in re ce; do
  for j in iso img img.bz2; do
    ls -i $DATA/boot/*ves-$i-*.$j | tail -n +5 | xargs -rt rm --
  done
done
