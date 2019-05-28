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

  <b>iPXE netboot images:</b>
  <ul>
    <li> <a href="./boot/ipxe.iso">ipxe.iso</a> </li>
    <li> <a href="./boot/ipxe.usb.img">ipxe.usb.img</a> </li>
    <li> <a href="./boot/ipxe.efi.img">ipxe.efi.img</a> </li>
  </ul>

  <b>Volterra System Bootstrap images:</b>
  <ul>
EOF

ls boot/*ves-* | xargs -r -I{}  echo "    <li> <a href="./{}">{}</a> </li>" >> index.html

cat <<-EOF >> index.html
  </ul>
  </body>
  </html>
EOF

# SET RIGHTS to sync user if exist
if getent passwd imagesync &>/dev/null; then
  chown -R imagesync . 2>/dev/null || true
fi

