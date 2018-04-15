#!/bin/bash -e

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${SCRIPTS:-} ]; then
  SCRIPTS=.
fi

chmod +x $SCRIPTS/scripts/*.sh

for script in \
  01-prepare \
  02-kernel \
  03-system-update \
  04-gcc-upgrade \
  05-rebuild-system \
  06-additional-software \
  07-cleanup	
do
  echo "**** Running $script ******"
  "$SCRIPTS/scripts/$script.sh"
done

echo "All done."
