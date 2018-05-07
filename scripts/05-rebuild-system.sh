#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo emerge -vt --emptytree @system
sudo etc-update --preen

sudo emerge -vt --emptytree @world
sudo etc-update --preen

sudo emerge -vt @preserved-rebuild

sudo perl-cleaner --reallyall
