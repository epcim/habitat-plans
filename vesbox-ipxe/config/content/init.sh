#!/bin/bash

# run at pkg_svc_path/data
cd $1 || {
  echo Failed to enter pkg_svc_path $1
  exit 1
}

# SIMPLE INDEX.HTML
[[ -e index.html ]] && rm -f index.html
cat <<-EOF > index.html
  <html>
  <body>
  <h1>Volterra VESBOX</h1>
  <ul>
    <li> <a href="./ipxe.iso">ipxe.iso</a> </li>
    <li> <a href="./ipxe.usb.img">ipxe.usb.img</a> </li>
    <li> <a href="./ipxe.efi.img">ipxe.efi.img</a> </li>
EOF

ls boot/*ves-* | xargs -r -I{}  echo "     <li> <a href="./{}">{}</a> </li>" >> index.html

cat <<-EOF >> index.html
  </ul>
  </body>
  </html>
EOF

