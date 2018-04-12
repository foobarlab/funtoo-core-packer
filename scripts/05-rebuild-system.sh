#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_GCC_VERSION:-} ]; then
	echo "BUILD_GCC_VERSION was not set. Skipping system rebuild ..."
	exit 0
fi

# TODO test with excluded debian-sources

cd /usr/src/linux && sudo make distclean
sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
sudo boot-update

sudo emerge --emptytree @system --exclude debian-sources
sudo etc-update --preen

sudo emerge --emptytree @world --exclude debian-sources
sudo etc-update --preen

sudo perl-cleaner --reallyall
