#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# logging facility
sudo emerge -vt app-admin/rsyslog
sudo rc-update add rsyslog default

# cron service
sudo emerge -vt sys-process/cronie
sudo rc-update add cronie default

# some commandline helpers/utils
sudo emerge -vt sys-fs/ncdu sys-process/htop app-misc/screen app-misc/mc net-analyzer/iptraf-ng \
	            www-client/links net-ftp/ncftp app-shells/bash-completion

# gentoo/funtoo related helper tools
sudo emerge -vt app-portage/ufed app-portage/eix
