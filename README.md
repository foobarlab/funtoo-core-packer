# Funtoo core Vagrant box

This is a minimal core Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.

Currently development is quite experimental and is not yet ready for stable use. 

### What's included?

 - Minimal core Funtoo Linux installation derived from a [stage3 box](https://github.com/foobarlab/funtoo-stage3-packer)
 - Architecture: pure64, generic_64 (currently only tested on Intel CPU)
 - 100 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default ssh authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel: debian-sources 4.12.x, stripped down for use with Virtualbox
 - Optional: move from default GCC 5.4 to another GCC version (6.4.0 tested)
 - List of additional installed software:
    - *genkernel*
    - *eclean-kernel*
    - *rsyslog*
    - *cronie*
    - *acpid* (graceful acpi shutdown for virtualbox)
    - *usermode-utilities* and *bridge-utils* for advanced networking
    - any additional software installed in the [stage3 box](https://github.com/foobarlab/funtoo-stage3-packer)
    
#### Todo

 - Install virtualbox guest additions

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
