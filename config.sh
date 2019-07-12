#!/bin/bash

. version.sh

export BUILD_BOX_NAME="funtoo-core"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_PARENT_BOX_NAME="funtoo-stage3"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="$BUILD_BOX_USERNAME/$BUILD_PARENT_BOX_NAME"

export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

export BUILD_BOX_PROVIDER="virtualbox"

export BUILD_TIMESTAMP="$(date --iso-8601=seconds)"

export BUILD_BOX_RELEASE_NOTES="Funtoo 1.4, Debian Kernel 4.9 LTS, GCC 9.1, VirtualBox Guest Additions 5.2"	# edit this to reflect actual setup

BUILD_BOX_DESCRIPTION="$BUILD_BOX_NAME version $BUILD_BOX_VERSION"
if [ -z ${BUILD_TAG+x} ]; then
	# without build tag
	BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION (custom)"
else
	# with env var BUILD_TAG set
	# NOTE: for Jenkins builds we got some additional information: BUILD_NUMBER, BUILD_ID, BUILD_DISPLAY_NAME, BUILD_TAG, BUILD_URL
	BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION ($BUILD_TAG)"
fi
export BUILD_BOX_DESCRIPTION="$BUILD_BOX_RELEASE_NOTES<br><br>$BUILD_BOX_DESCRIPTION<br>created @$BUILD_TIMESTAMP"

export BUILD_GCC_VERSION="9.1.1"		# specify which GCC version to install or leave empty to keep the default
export BUILD_REBUILD_SYSTEM=true		# set to true when GCC version is not default 

export BUILD_KEEP_MAX_CLOUD_BOXES=7		# set the maximum number of boxes to keep in Vagrant Cloud

# get the latest parent version from Vagrant Cloud API call:
. parent_version.sh

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
