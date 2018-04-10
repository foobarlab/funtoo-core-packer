#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# logging facility
sudo emerge -v app-admin/rsyslog
sudo rc-update add rsyslog default

# cron service
sudo emerge -v sys-process/cronie
sudo rc-update add cronie default

# some commandline helpers
sudo emerge -v sys-fs/ncdu sys-process/htop app-portage/ufed app-misc/screen app-misc/mc app-portage/eix
