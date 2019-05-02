#!/bin/bash

# run at pkg_svc_path/data
cd $1 || {
  echo Failed to enter pkg_svc_path $1
  exit 1
}

# fetch bootstrap CD
[[ -e ipxe.iso ]] || curl -qls http://boot.ipxe.org/ipxe.iso > ipxe.iso
[[ -e ipxe.usb ]] || curl -qls http://boot.ipxe.org/ipxe.usb > ipxe.usb
[[ -e ipxe.efi ]] || curl -qls http://boot.ipxe.org/ipxe.efi > ipxe.efi

# SIMPLE INDEX.HTML
[[ -e index.html ]] && rm -f index.html
cat <<-EOF > index.html
  <html>
  <body>
  <h1>Volterra VESBOX</h1>
  <ul>
    <li> <a href="./ipxe.usb">ipxe.usb</a> </li>
    <li> <a href="./ipxe.efi">ipxe.efi</a> </li>
EOF

ls *.iso | xargs -r -I{}  echo "     <li> <a href="./{}">{}</a> </li>" >> index.html

cat <<-EOF >> index.html
  </ul>
  </body>
  </html>
EOF

