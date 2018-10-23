#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo env-update
source /etc/profile

sudo emerge --verbose --depclean

sudo etc-update --preen
sudo rm -f /etc/._cfg0000_boot.conf			# prevent replacement of our boot.conf
sudo rm -f /etc/._cfg0000_genkernel.conf	# prevent replacement of our genkernel.conf
sudo find /etc/ -name '._cfg*'				# DEBUG: list all remaining config files needing an update
sudo etc-update --automode -5				# force 'auto-merge' for remaining configs 

sudo eselect kernel list
sudo boot-update

sudo rm -f /etc/resolv.conf
sudo rm -f /etc/resolv.conf.bak
sudo rm -rf /var/cache/portage/distfiles/*
sudo rm -rf /var/git/meta-repo
sudo rm -rf /var/log/*

sudo chown portage:portage /var/cache/eix

sudo sync

# simple way to claim some free space before export
sudo bash -c 'dd if=/dev/zero of=/EMPTY bs=1M 2>/dev/null' || true
sudo rm -f /EMPTY

cat /dev/null > ~/.bash_history && history -c && exit
