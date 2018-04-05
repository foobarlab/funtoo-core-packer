#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# FIXME: add rsyslog or some other logging facility
# FIXME: add cronie or some other cron tool

# this is needed if virtualbox should gracefully shutdown on close
sudo emerge -v sys-power/acpid
sudo rc-update add acpid default 

# this is needed for compacting free space (most likely already installed in stage3 box) 
sudo emerge -v sys-fs/zerofree

# virtualbox advanced networking only (see: https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests)
sudo emerge -v sys-apps/usermode-utilities
sudo emerge -v net-misc/bridge-utils

# install vbox guest additions (these should be already attached as cdrom, see virtualbox.json)
# FIXME: this is not working, maybe kernel config needs to be modified
#sudo mount /mnt/cdrom
#sudo /mnt/cdrom/VBoxLinuxAdditions.run
#sudo umount /mnt/cdrom

# install guest additions from inside the vm, see: https://wiki.gentoo.org/wiki/VirtualBox
# FIXME: this is neither working, installs some older version (5.2.4)
#sudo emerge -v app-emulation/virtualbox-guest-additions

# configure as needed ---- the stuff below is quite optional

# gentoo/funtoo related helper tools
sudo emerge -v app-portage/ufed app-portage/eix

# additional helpers/tools for the commandline
# TODO some more cmdline helpers: dig, mtr, HTTPie, aria2, ripgrep, exa, fzf, icdiff, progress, pv, Diffoscope
sudo emerge -v app-misc/mc app-misc/screen app-misc/tmux app-misc/byobu sys-fs/ncdu \
			   www-client/links net-ftp/ncftp app-admin/apg app-shells/bash-completion

# additional tools for status monitoring
sudo emerge -v sys-process/htop net-analyzer/iptraf-ng sys-process/glances

# TODO add zsh? (also include http://ohmyz.sh ?)
# TODO add localepurge?
# TODO add spectre-metdown-checker in /usr/local/src? (git clone https://github.com/speed47/spectre-meltdown-checker.git)

# DEBUG: show eselect options
# FIXME: configure as needed with eselect
sudo eselect
	
# FIXME: put any additional configuration here
