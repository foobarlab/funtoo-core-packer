# Funtoo Core Vagrant box

This is a minimal core Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.
It is based on the [Funtoo Stage3 Vagrant box](https://github.com/foobarlab/funtoo-stage3-packer).

### What's included?

 - Minimal Funtoo Linux installation with core flavor
 - Architecture: pure64, generic_64 (currently only tested on Intel CPU)
 - 100 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default ssh authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel: debian-sources 4.12.x, stripped down for use with Virtualbox
 - Optional: move from default GCC 5.4 to another GCC version (6.4.0 tested)
 - List of additional installed software:
    - *virtualbox-guest-additions*
    - kernel tools: *genkernel, eclean-kernel*
    - services: *rsyslog, cronie*
    - commandline tools: *htop, ncdu, ufed, screen, mc, iptraf-ng, links, ncftp, apg, bash-completion*
    - any additional software installed in the [stage3 box](https://github.com/foobarlab/funtoo-stage3-packer)

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/funtoo-core](https://app.vagrantup.com/foobarlab/boxes/funtoo-core) (Soon available)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh Virtualbox box

 - Run ```./build.sh```

#### Quick test the box file

 - Run ```./test.sh```

#### Upload the box to Vagrant Cloud (experimental)

 - Run ```./upload.sh```

### Regular use cases

#### Initialize a fresh box (initial state, any modifications are lost)

 - Run ```./init.sh```

#### Power on the box (keeping previous state) 

 - Run ```./startup.sh```

## Feedback welcome

Please create an issue.
