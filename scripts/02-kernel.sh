#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-core-kernel
# some kernel related settings for vbox-core
sys-kernel/genkernel -cryptsetup
sys-kernel/debian-sources -binary
DATA

sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src

sudo emerge -vt1 sys-kernel/genkernel
sudo mv /etc/genkernel.conf /etc/genkernel.conf.dist

# FIXME insert build var ${MAKEOPTS} here?
# FIXME include firmware/microcode?
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
FIRMWARE="no"
#FIRMWARE_SRC="/lib/firmware"
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
CMD_CALLBACK="emerge --quiet @module-rebuild"
DATA

source /etc/profile
sudo env-update

sudo emerge -v sys-kernel/gentoo-sources

# FIXME: install firmware / microcode / earlyboot ucode / ... ???

# DEBUG:
sudo eselect kernel list

# FIXME this seems to work for gentoo-sources, possibly check by name to select the correct entry (must be gentoo-sources)
sudo eselect kernel set 1

sudo genkernel --kernel-config=/usr/src/kernel.config --install initramfs all

source /etc/profile
sudo env-update
	
# FIXME unmerge/depclean debian-sources?
# FIXME this will forcibly remove the previous kernel, most likely does not work while running the same kernel
#sudo emerge --depclean

# FIXME this is probably not needed anymore:
#sudo emerge -v1 app-admin/eclean-kernel
#sudo eclean-kernel -n 1
# FIXME use eclean-kernel with --destructive (-d) to force unmerging debian-sources


# Disklabels from stage 3 install:
# FIXME get these from blkid and insert dynamically into boot.conf
# /dev/sda1: UUID="8be39851-51f6-4f7c-a9d3-c3a36da077db" TYPE="ext2" PARTLABEL="boot" PARTUUID="f412838c-a07a-4bc0-b342-73e27be5241f"
# /dev/sda2: PARTLABEL="BIOS boot partition" PARTUUID="5e8ed02e-3d2e-428d-92af-39050dca26f2"
# /dev/sda3: UUID="9ed48602-fbb8-40d6-a249-0422019bbebf" TYPE="swap" PARTLABEL="swap" PARTUUID="c2f4b010-b3d1-41bd-b80c-bb335c3cf7f0"
# /dev/sda4: UUID="97a445dd-b2b5-4b5e-ba6e-37b0b45604bc" TYPE="ext4" PARTLABEL="rootfs" PARTUUID="291e35ec-77e2-4456-ab30-89acd6a34d55"

sudo mv /etc/boot.conf /etc/boot.conf.old
cat <<'DATA' | sudo tee -a /etc/boot.conf
boot {
    generate grub
    default "Funtoo Linux"
    timeout 10
}
display {
	gfxmode 800x600
}
"Funtoo Linux" {
    kernel kernel[-v]
    initrd initramfs[-v]
	params += real_root=/dev/sda4 root=LABEL=291e35ec-77e2-4456-ab30-89acd6a34d55 rootfstype=ext4
}
DATA

sudo boot-update
