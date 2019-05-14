#!/bin/bash -e

BASE=$(dirname $0)
DATA=$BASE/../data
VERSION="${1:-{{cfg.ves.image_revision}}}"

cd $DATA

# FIXME, update way to sync VES upstream images
# fetch bootstrap vsb images from upstream servers
test -e boot || mkdir boot
rsync -avh vesop@images.vedge.io:/dump/ves-ipxe/ipxe.* ./ || exit 0
rsync -avh vesop@images.vedge.io:/dump/ves-ipxe/*${VERSION}* ./boot/ || exit 0

# fetch boostrap ipxe images, failover
[[ -e ipxe.iso ]] || curl -qls http://boot.ipxe.org/ipxe.iso > boot/ipxe.iso
[[ -e ipxe.usb ]] || curl -qls http://boot.ipxe.org/ipxe.usb > boot/ipxe.usb.img
[[ -e ipxe.efi ]] || curl -qls http://boot.ipxe.org/ipxe.efi > boot/ipxe.efi.img

# housekeeping
ls -ti ./boot/*ves-re-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./boot/*ves-ce-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./boot/*ves-re-mini-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./boot/*ves-ce-mini-*.iso | tail -n +4 | xargs -rt rm --
