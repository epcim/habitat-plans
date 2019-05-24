#!/bin/bash -e

BASE=$(dirname $0)
DATA=$BASE/../data
VERSION="${1:-{{cfg.ves.image_revision}}}"

cd $DATA

# try to fetch bootstrap images from upstream servers
test -e boot || mkdir boot
test -e $BASE/id_rsa_imagesync && RSYNC_KEY="-i $BASE/id_rsa_imagesync" || RSYNC_KEY=""
rsync -avh $RSYNC_KEY --include "*ipxe*" --exclude "*" \
  "imagesync@images.vedge.io:data/" ./ || exit 0
rsync -avh $RSYNC_KEY --include "*${VERSION}*.iso" --include "*${VERSION}*.img.bz2" --exclude "*"
  "imagesync@images.vedge.io:data/boot/" ./boot/ || exit 0

# fetch boostrap ipxe images, failover
#[[ -e ipxe.iso ]] || curl -qls http://boot.ipxe.org/ipxe.iso > boot/ipxe.iso
#[[ -e ipxe.usb ]] || curl -qls http://boot.ipxe.org/ipxe.usb > boot/ipxe.usb.img
#[[ -e ipxe.efi ]] || curl -qls http://boot.ipxe.org/ipxe.efi > boot/ipxe.efi.img

# housekeeping
for i in re ce; do
  for j in iso img img.bz2; do
    ls -ti ./boot/*ves-$i-*.$j | tail -n +4 | xargs -rt rm --
  done
done
