#!/bin/bash

VERSION="${1:-{{cfg.ves.image_revision}}}"
[[ $VERSION =~ ^.*cfg ]] && VERSION=

# fetch .iso to bootstrap from upstream servers
test -e boot || mkdir boot
rsync -avh vesop@images.vedge.io:/dump/ves-ipxe/*${VERSION}* ./boot/ || exit 1

# remove old
ls -ti ./*ves-re-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./*ves-ce-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./*ves-re-mini-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./*ves-ce-mini-*.iso | tail -n +4 | xargs -rt rm --
