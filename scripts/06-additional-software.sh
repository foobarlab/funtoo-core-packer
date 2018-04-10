#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# virtualbox guest additions kernel modules
# FIXME version 5.2.4 not fully working yet, see also FL-4658 ("Virtualbox-guest-additions 5.2.4 missing functionality")
cd /usr/src/linux
sudo make oldconfig
sudo make modules_prepare
sudo emerge -v app-emulation/virtualbox-guest-additions
cat <<'DATA' | sudo tee -a /etc/conf.d/modules
# automatically load virtualbox modules
modules="vboxdrv vboxnetflt vboxnetadp vboxpci"
DATA

# gracefully shutdown on close
sudo emerge -v sys-power/acpid
sudo rc-update add acpid default

# virtualbox advanced networking only, see: https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests
sudo emerge -v sys-apps/usermode-utilities
sudo emerge -v net-misc/bridge-utils

sudo emerge -v app-admin/rsyslog
sudo rc-update add rsyslog default
	
sudo emerge -v sys-process/cronie
sudo rc-update add cronie default

# some commandline helpers
sudo emerge -v sys-fs/ncdu sys-process/htop app-portage/ufed app-misc/screen app-misc/mc app-portage/eix
