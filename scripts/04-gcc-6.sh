#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# install gcc version 6.4.0
# see: https://wiki.gentoo.org/wiki/Upgrading_GCC

sudo mkdir -p /etc/portage/package.unmask
cat <<'DATA' | sudo tee -a /etc/portage/package.unmask/gcc
=sys-devel/gcc-BUILD_GCC_VERSION
DATA
sudo sed -i 's/BUILD_GCC_VERSION/'"$BUILD_GCC_VERSION"'/g' /etc/portage/package.unmask/gcc
sudo cat /etc/portage/package.unmask/gcc

# DEBUG: check if version is correctly set
sudo cat /etc/portage/package.unmask/gcc

sudo emerge --oneshot sys-devel/gcc:${BUILD_GCC_VERSION}

# DEBUG:
sudo gcc-config --list-profiles

sudo gcc-config "x86_64-pc-linux-gnu-${BUILD_GCC_VERSION}"

# DEBUG:
sudo gcc-config --list-profiles

sudo emerge --oneshot sys-devel/libtool

# DEBUG:
sudo gcc --version

sudo emerge --depclean sys-devel/gcc

# DEBUG:
sudo gcc-config --list-profiles

# FIXME not needed as we do a complete rebuild ...
#sudo revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc
