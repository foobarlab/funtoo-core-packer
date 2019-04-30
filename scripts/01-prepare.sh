#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

echo "$BUILD_BOX_DESCRIPTION" >> /home/vagrant/.$BUILD_BOX_NAME
sed -i 's/<br>/\n/g' /home/vagrant/.$BUILD_BOX_NAME

cat <<'DATA' | sudo tee -a /etc/portage/make.conf
USE="acl acpi bash-completion bindist cacert git gold hwdb icu idn iptables kmod lzma lzo networkmanager ncurses pci pgo pic pie posix rdp readline recursion-limit smp syslog threads tools udev udisks unicode unwind upnp utils zlib -systemd"
ACCEPT_LICENSE="-* @FREE @BINARY-REDISTRIBUTABLE"
FEATURES="split-elog clean-logs"
VIDEO_CARDS="virtualbox"
# TODO portage logging: log everything (only debugging for now, keep logging on a minimum later!)
#PORT_LOGDIR="/var/log/portage"
#PORTAGE_ELOG_CLASSES="warn error qa"
PORTAGE_ELOG_CLASSES="info warn error log qa"
PORTAGE_ELOG_SYSTEM="echo save save_summary"
# TODO custom command for portage logging: put all logs somewhere before they are lost (e.g. whenever packer fails) 
#PORTAGE_ELOG_SYSTEM="custom echo save"
#PORTAGE_ELOG_COMMAND="/path/to/logprocessor -p '\${PACKAGE}' -f '\${LOGFILE}'"
# TODO custom clean command:
#PORT_LOGDIR_CLEAN="find \"\${PORT_LOGDIR}\" -type f ! -name \"summary.log*\" -mtime +7 -delete"
DATA

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-kernel
sys-kernel/genkernel -cryptsetup
sys-kernel/debian-sources-lts -binary
sys-firmware/intel-microcode initramfs
DATA

cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-defaults
# FIXME avoid pull-in of media-libs/freetype:
#sys-boot/grub -fonts -themes -truetype
app-misc/mc -edit -slang
DATA

cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-fixes
# FIX need to apply policykit USE flag in consolekit after pam/pambase updates (April 2019):
>=sys-auth/consolekit-0.4.6 policykit
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
