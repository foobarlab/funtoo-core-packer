# Funtoo Core Vagrant box

This is a minimal core Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.
It is based on the [Funtoo Stage3 Vagrant box](https://github.com/foobarlab/funtoo-stage3-packer). This box serves for bootstrapping an initial base box for the [Funtoo Server Vagrant box](https://github.com/foobarlab/funtoo-server-packer).

### What's included?

 - Minimal Funtoo Linux 1.3 installation with core flavor
 - Architecture: x86-64bit, generic_64
 - 20 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP (virtio)
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default SSH authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel: debian-sources-lts 4.9, stripped down for use with VirtualBox
 - Optional: switch and rebuild GCC version (experimental, untested)
 - List of additional installed software:
    - *virtualbox-guest-additions* (vboxguest, vboxsf and vboxvideo modules)
    - Kernel tools: *genkernel, eclean-kernel*
    - Portage utils: *eix, ufed, elogv*
    - *vim* as default editor
    - Commandline helpers/tools: *lsof, bash-completion, screen, tmux, htop, ncdu, mc*
	- Network utils for www, ftp and email: *links, ncftp, mutt*
    - Any additional software installed in the [stage3 box](https://github.com/foobarlab/funtoo-stage3-packer)

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/funtoo-core](https://app.vagrantup.com/foobarlab/boxes/funtoo-core)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh VirtualBox box

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

### Special use cases

#### Show current build config

 - Run ```./config.sh```

#### Cleanup build environment (poweroff all Vagrant and VirtualBox machines)

 - Run ```./clean_env.sh```

#### Generate Vagrant Cloud API Token

 - Run ```./vagrant_cloud_token.sh```

#### Keep only a maximum number of boxes in Vagrant Cloud (experimental)

 - Run ```./clean_cloud.sh```

## Feedback welcome

Please create an issue.
