#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# logging facility: rsyslog
sudo emerge -v app-admin/rsyslog
sudo rc-update add rsyslog default
	
# cron service: cronie
sudo emerge -v sys-process/cronie
sudo rc-update add cronie default

# this is needed if virtualbox should gracefully shutdown on close
sudo emerge -v sys-power/acpid
sudo rc-update add acpid default

# this is needed for compacting free space (most likely already installed in stage3 box) 
#sudo emerge -v sys-fs/zerofree

# virtualbox advanced networking only (see: https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests)
sudo emerge -v sys-apps/usermode-utilities
sudo emerge -v net-misc/bridge-utils
