#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-kernel
# kernel related flags
sys-kernel/genkernel -cryptsetup
sys-kernel/debian-sources -binary
DATA

sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src

sudo emerge -vt1 sys-kernel/genkernel
sudo mv /etc/genkernel.conf /etc/genkernel.conf.dist

cat <<'DATA' | sudo tee -a /etc/genkernel.conf
INSTALL="yes"
OLDCONFIG="yes"
MENUCONFIG="no"
CLEAN="yes"
MRPROPER="yes"
MOUNTBOOT="yes"
SYMLINK="no"
SAVE_CONFIG="yes"
USECOLOR="yes"
CLEAR_CACHE_DIR="yes"
POSTCLEAR="1"
#MAKEOPTS="" 
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
FIRMWARE="yes"
FIRMWARE_SRC="/lib/firmware"
DISKLABEL="yes"
BOOTLOADER=""	# grub not needed, we will use boot-update
TMPDIR="/var/tmp/genkernel"
BOOTDIR="/boot"
GK_SHARE="${GK_SHARE:-/usr/share/genkernel}"
CACHE_DIR="/usr/share/genkernel"
DISTDIR="${CACHE_DIR}/src"
LOGFILE="/var/log/genkernel.log"
LOGLEVEL=2
DEFAULT_KERNEL_SOURCE="/usr/src/linux"
DEFAULT_KERNEL_CONFIG="/usr/src/kernel.config"
KNAME="genkernel"
REAL_ROOT="/dev/sda4"
CMD_CALLBACK=""	# to auto compile modules after kernel use: "emerge --quiet @module-rebuild"
DATA

sudo env-update
source /etc/profile

# NOTE: including binary blobs into kernel can violate GPL2 
#sudo emerge -vt sys-kernel/linux-firmware

# include cpu microcode
sudo emerge -vt sys-firmware/intel-microcode sys-apps/iucode_tool

sudo emerge -v sys-kernel/gentoo-sources

# FIXME eselect first kernel entry (this seems to work for gentoo-sources, could also be selected by name)
sudo eselect kernel set 1

sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all

sudo emerge --depclean sys-kernel/debian-sources

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
