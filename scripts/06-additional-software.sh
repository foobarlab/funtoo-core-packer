#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo emerge -v app-admin/rsyslog
sudo rc-update add rsyslog default
	
sudo emerge -v sys-process/cronie
sudo rc-update add cronie default

# gracefully shutdown on close
sudo emerge -v sys-power/acpid
sudo rc-update add acpid default

# virtualbox advanced networking only, see: https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests
sudo emerge -v sys-apps/usermode-utilities
sudo emerge -v net-misc/bridge-utils

# some commandline helpers
sudo emerge -v sys-fs/ncdu sys-process/htop app-portage/ufed app-misc/screen app-misc/mc
