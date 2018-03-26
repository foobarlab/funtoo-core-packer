#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo ego sync

# FIXME: removed flags (only needed for X, we might not need it for this vm now): consolekit dbus policykit
# FIXME: removed flags (unknown): i18n nfs resolvconf
# FIXME: removed flags (better add in package.use): initramfs inotify xmp
# TODO: /etc/portage/package.use:
# .../intel-microcode initramfs
# .../cronie inotify

# global use flags:
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
USE="acl acpi bash-completion bindist cacert git gold hwdb icu idn iptables kmod lz4 lzma lzo networkmanager ncurses pci pgo pic pie posix rdp readline recursion-limit smp syslog threads tools udev udisks unicode unwind upnp utils zlib -systemd"
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
