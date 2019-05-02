#!/bin/bash

VERSION="${1:-{{cfg.ves.image_revision}}}"

# fetch .iso to bootstrap from upstream servers
test -e boot || mkdir boot
rsync -avh vesop@images.vedge.io:/dump/ves-ipxe/*${VERSION}* ./boot/ || exit 1

# remove old
ls -ti ./vsb-ves-re-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./vsb-ves-ce-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./vsb-ves-re-mini-*.iso | tail -n +4 | xargs -rt rm --
ls -ti ./vsb-ves-ce-mini-*.iso | tail -n +4 | xargs -rt rm --
