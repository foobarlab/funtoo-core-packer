#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo ego sync

# global use flags:
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
USE="acl acpi bash-completion bindist cacert git gold hwdb icu idn iptables kmod lz4 lzma lzo networkmanager ncurses pci pgo pic pie posix rdp readline recursion-limit smp syslog threads tools udev udisks unicode unwind upnp utils zlib -systemd"
DATA

# package specific use flags go into /etc/portage/package.use dir
sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
# default package flags for vbox
DATA

sudo epro mix-ins +no-systemd

# FIXME replace /etc/motd - use a template ...
sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux - Experimental Vagrant box v0.0.5 (core)
Build by Foobarlab
DATA

sudo locale-gen
sudo eselect locale set en_US.UTF-8
source /etc/profile

sudo emerge -1v portage
# normally we would do a @world update right after portage emerge, but we do it after the kernel build

sudo env-update
source /etc/profile
