#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# we rebuild everything (recommended when gcc was compiled)
# see: https://wiki.gentoo.org/wiki/Upgrading_GCC

sudo emerge --emptytree @system
sudo etc-update --preen

sudo emerge --emptytree @world
sudo etc-update --preen

sudo perl-cleaner --reallyall
