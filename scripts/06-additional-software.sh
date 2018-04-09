#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# this is needed if virtualbox should gracefully shutdown on close
sudo emerge -v sys-power/acpid
sudo rc-update add acpid default 

# this is needed for compacting free space (most likely already installed in stage3 box) 
sudo emerge -v sys-fs/zerofree

# virtualbox advanced networking only (see: https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests)
sudo emerge -v sys-apps/usermode-utilities
sudo emerge -v net-misc/bridge-utils

# install vbox guest additions (these should be already attached as cdrom, see virtualbox.json)
# FIXME: this is not working, maybe kernel config needs to be modified
#sudo mount /mnt/cdrom
#sudo /mnt/cdrom/VBoxLinuxAdditions.run
#sudo umount /mnt/cdrom

# install guest additions from inside the vm, see: https://wiki.gentoo.org/wiki/VirtualBox
# FIXME: this is neither working, installs some older version (5.2.4)
#sudo emerge -v app-emulation/virtualbox-guest-additions
