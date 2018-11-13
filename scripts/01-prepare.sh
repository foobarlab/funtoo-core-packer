#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

echo "$BUILD_BOX_DESCRIPTION" >> /home/vagrant/.$BUILD_BOX_NAME
sed -i 's/<br>/\n/g' /home/vagrant/.$BUILD_BOX_NAME

cat <<'DATA' | sudo tee -a /etc/portage/make.conf
USE="acl acpi bash-completion bindist cacert git gold hwdb icu idn iptables kmod lz4 lzma lzo networkmanager ncurses pci pgo pic pie posix rdp readline recursion-limit smp syslog threads tools udev udisks unicode unwind upnp utils zlib -systemd"
ACCEPT_LICENSE="-* @FREE @BINARY-REDISTRIBUTABLE"
VIDEO_CARDS="virtualbox"
DATA

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-kernel
sys-kernel/genkernel -cryptsetup
# TODO remove debian-sources when switch to lts happened
sys-kernel/debian-sources -binary
sys-kernel/debian-sources-lts -binary
sys-firmware/intel-microcode initramfs
DATA

sudo mkdir -p /etc/portage/package.accept_keywords
cat <<'DATA' | sudo tee -a /etc/portage/package.accept_keywords/vbox-kernel
>=sys-kernel/debian-sources-4.17 **
DATA

sudo ego sync

sudo epro mix-ins +no-systemd
sudo epro list

lsblk

sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd
Funtoo GNU/Linux (BUILD_BOX_NAME) - Vagrant box BUILD_BOX_VERSION
DATA
sudo sed -i 's/BUILD_BOX_NAME/'"$BUILD_BOX_NAME"'/g' /etc/motd
sudo sed -i 's/BUILD_BOX_VERSION/'"$BUILD_BOX_VERSION"'/g' /etc/motd
sudo cat /etc/motd

sudo locale-gen
sudo eselect locale set en_US.UTF-8
source /etc/profile

sudo emerge -1v portage

sudo env-update
source /etc/profile
