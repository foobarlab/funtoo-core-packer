#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# TEST in any case we rebuild our system
#if [ -z ${BUILD_GCC_VERSION:-} ]; then
#	echo "BUILD_GCC_VERSION was not set. Skipping system rebuild ..."
#	exit 0
#fi

sudo eselect kernel list
#cd /usr/src/linux && sudo make distclean
#sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
#sudo boot-update

sudo emerge -vt --emptytree @system
sudo etc-update --preen

sudo emerge -vt --emptytree @world
sudo etc-update --preen

sudo perl-cleaner --reallyall

sudo eselect kernel list
#cd /usr/src/linux && sudo make distclean
#sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all
#sudo boot-update
