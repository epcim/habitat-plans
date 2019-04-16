
cd {{ pkg_svc_data_path }}

# fetch bootstrap CD
[[ -e ipxe.iso ]] && curl -qls http://boot.ipxe.org/ipxe.iso > ipxe.iso

# fetch netboot images
# curl -qSL http://images.vedge.io/netboot.tar.gz
# extract
# tar xzvf netboot.tar.gz -C boot
# ln -fs $(ls boot/ves-*|tail -n1) boot/ves-re-full

cat <<-EOF > index.html
Nothing to index
EOF

