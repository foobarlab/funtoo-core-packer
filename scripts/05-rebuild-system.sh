#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_GCC_VERSION:-} ]; then
	echo "BUILD_GCC_VERSION was not set. Skipping system rebuild ..."
	exit 0
fi

sudo emerge --emptytree @system
sudo etc-update --preen

sudo emerge --emptytree @world
sudo etc-update --preen

sudo perl-cleaner --reallyall
