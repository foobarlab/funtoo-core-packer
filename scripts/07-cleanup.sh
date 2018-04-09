#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo env-update
source /etc/profile

sudo etc-update --preen

sudo emerge --depclean

sudo emerge -vt sys-boot/boot-update
sudo boot-update

cd /usr/src/linux && sudo make distclean

sudo rm -rf /usr/src/linux-debian-sources-*
sudo rm -f /etc/resolv.conf
sudo rm -f /etc/resolv.conf.bak

# FIXME: disabled below temporarily for debugging
#sudo rm -rf /var/cache/portage/distfiles/*
#sudo rm -rf /var/git/meta-repo
#sudo rm -rf /var/log/*

# FIXME: remove any /etc/._cfg* files as these have not been merged yet (boot.conf should not be replaced!)
#sudo rm -f /etc/._cfg0000_boot.conf

# DEBUG: list all config files needing an update
sudo find /etc/ -name '._cfg*'

sudo sync

# simple way to claim some free space before export (anyway we do this additionally in a better way as a second step from inside the Vagrantfile)
sudo bash -c 'dd if=/dev/zero of=/EMPTY bs=1M 2>/dev/null' || true
sudo rm -f /EMPTY

cat /dev/null > ~/.bash_history && history -c && exit
