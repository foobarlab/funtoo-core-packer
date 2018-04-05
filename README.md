# Funtoo core Vagrant box

This is a minimal core Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.

Currently development is highly experimental and is not ready for stable use yet. 

### What's included?

 - Minimal core Funtoo Linux installation derived from a [stage3 box](https://github.com/foobarlab/funtoo-stage3-packer)
 - Architecture: pure64, generic_64
 - 100 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default ssh authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel: gentoo-sources 4.15.x with customizations for Virtualbox (experimental: right now only Intel CPUs are supported, AMD is untested and will be most likely be broken)
 - Moved from default GCC 5.4.0 to GCC 6.4.0
 - TODO: list additional software installed

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/funtoo-core](https://app.vagrantup.com/foobarlab/boxes/funtoo-core) (Soon available)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build fresh Virtualbox

 - Run ```./build.sh```
 
#### Test box file

 - Run ```./test.sh```
