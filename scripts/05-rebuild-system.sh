#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# see: https://wiki.gentoo.org/wiki/Upgrading_GCC

# FIXME ignore errors with --keep-going ???
#sudo emerge --emptytree --keep-going @system
#sudo emerge --emptytree --keep-going @world
#sudo emerge --emptytree @system --exclude gcc
sudo emerge --emptytree @system

# FIXME auto update config files but keep our settings ...
#sudo etc-update --automode -7
sudo etc-update --preen

sudo emerge --emptytree @world

# FIXME auto update config files but keep our settings ...
#sudo etc-update --automode -7
sudo etc-update --preen

# TODO run perl-cleaner --reallyall ???
