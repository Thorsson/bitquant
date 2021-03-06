#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $SCRIPT_DIR/../web/scripts/rootcheck.sh

# install deps to build oz image

urpmi --no-suggests --auto \
   oz qemu libguestfs-tools \
   libvirt-utils tigervnc \
   dnsmasq dnsmasq-utils lvm2 make supermin \
   cdrkit-genisoimage vdfuse

systemctl start libvirtd.service

chmod 0666 /dev/kvm
cat > /etc/udev/rules.d/65-kvm.rules <<EOF
KERNEL=="kvm", NAME="%k", MODE="0666"
EOF

chmod a+r /usr/bin/gpasswd
