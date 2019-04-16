
# run at pkg_svc_path/data
cd $1 || {
  echo Failed to enter pkg_svc_path $1
  exit 1
}

# fetch bootstrap CD
[[ -e ipxe.iso ]] || curl -qls http://boot.ipxe.org/ipxe.iso > ipxe.iso

# fetch/rsync netboot images
# curl -qSL http://images.vedge.io/netboot.tar.gz
# extract
# tar xzvf netboot.tar.gz -C boot
# ln -fs $(ls boot/ves-*|tail -n1) boot/ves-re-full

# TODO, index page
[[ -e index.html ]] || {
  cat <<-EOF > index.html
  <html>
  <body>
  <h1>VES iPXE</h1>
  <ul>
    <li> <a href="./ipxe.iso">ipxe.iso</a> </li>
  </ul>
  </body>
  </html>
EOF
}

