#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo ego sync

# FIXME: check which USE flags are required/optional, remove X11 related flags
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
#USE="bindist -systemd"
USE="acl acpi bindist cacert consolekit dbus git gold hwdb i18n icu idn initramfs inotify iptables kmod lz4 lzma lzo ncurses networkmanager nfs pci pgo pic pie policykit posix rdp readline recursion-limit resolvconf smp syslog threads tools udev udisks unicode unwind upnp utils xmp zlib -systemd"
DATA

sudo epro mix-ins +no-systemd

# DEBUG:
sudo epro show
sudo epro list

# TODO replace /etc/motd - use a template ...
sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux - Experimental Vagrant box
Build by Foobarlab
DATA

source /etc/profile
sudo locale-gen
sudo eselect locale set en_US.UTF-8
source /etc/profile
sudo env-update
