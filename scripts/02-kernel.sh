#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src

sudo emerge -vt sys-kernel/genkernel
sudo mv /etc/genkernel.conf /etc/genkernel.conf.dist

cat <<'DATA' | sudo tee -a /etc/genkernel.conf
INSTALL="yes"
OLDCONFIG="yes"
MENUCONFIG="no"
CLEAN="yes"
MRPROPER="no"
MOUNTBOOT="yes"
SYMLINK="no"
SAVE_CONFIG="no"
USECOLOR="yes"
CLEAR_CACHE_DIR="yes"
POSTCLEAR="1"
#MAKEOPTS=""	# determined by Vagrantfile
LVM="no"
LUKS="no"
GPG="no"
DMRAID="no"
SSH="no"
BUSYBOX="no"
MDADM="no"
MULTIPATH="no"
ISCSI="no"
UNIONFS="no"
BTRFS="no"
FIRMWARE="yes"	# include cpu microcode firmware
FIRMWARE_SRC="/lib/firmware"
DISKLABEL="yes"
BOOTLOADER=""	# grub not needed, we will use boot-update (ego boot) command
TMPDIR="/var/tmp/genkernel"
BOOTDIR="/boot"
GK_SHARE="${GK_SHARE:-/usr/share/genkernel}"
CACHE_DIR="/usr/share/genkernel"
DISTDIR="${CACHE_DIR}/src"
LOGFILE="/var/log/genkernel.log"
LOGLEVEL=2
DEFAULT_KERNEL_SOURCE="/usr/src/linux"
DEFAULT_KERNEL_CONFIG="/usr/src/kernel.config"
KNAME="debian-sources-lts"
REAL_ROOT="/dev/sda4"
CMD_CALLBACK="emerge --quiet @module-rebuild"
DATA

sudo env-update
source /etc/profile

sudo eselect kernel list

sudo emerge -vt sys-firmware/intel-microcode sys-apps/iucode_tool

sudo emerge -vt --unmerge sys-kernel/debian-sources || true
sudo emerge -vt --unmerge sys-kernel/debian-sources-lts || true

sudo rm -rf /usr/src/linux-debian-sources-*

sudo emerge -vt sys-kernel/debian-sources-lts

sudo eselect kernel list
sudo eselect kernel set 1

cd /usr/src/linux
sudo make distclean

# apply 'make olddefconfig' on 'kernel.config' in case kernel config is outdated
sudo cp /usr/src/kernel.config /usr/src/kernel.config.old
sudo mv -f /usr/src/kernel.config /usr/src/linux/.config
sudo make olddefconfig
sudo mv -f /usr/src/linux/.config /usr/src/kernel.config

sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all

sudo emerge -vt app-admin/eclean-kernel
sudo eclean-kernel -n 1

sudo env-update
source /etc/profile

sudo mv /etc/boot.conf /etc/boot.conf.old
cat <<'DATA' | sudo tee -a /etc/boot.conf
boot {
    generate grub
    default "Funtoo Linux"
    timeout 1
}
display {
	gfxmode 800x600
}
"Funtoo Linux" {
    kernel kernel[-v]
    initrd initramfs[-v]
    params += real_root=/dev/sda4 root=PARTLABEL=rootfs rootfstype=ext4
}
DATA

sudo boot-update
