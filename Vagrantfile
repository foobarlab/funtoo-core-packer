# -*- mode: ruby -*-
# vi: set ft=ruby :

system("./config.sh >/dev/null")

$script_guest_additions = <<SCRIPT
# prepare kernel
sudo cp /usr/src/kernel.config /usr/src/linux/.config
cd /usr/src/linux
sudo make oldconfig
sudo make modules_prepare
# copy iso and start install
sudo mkdir -p /mnt/temp
sudo mv /home/vagrant/VBoxGuestAdditions.iso /tmp
sudo mount -o loop /tmp/VBoxGuestAdditions.iso /mnt/temp
sudo /mnt/temp/VBoxLinuxAdditions.run
sudo umount /mnt/temp
# DEBUG:
sudo cat /var/log/vboxadd-setup.log
## auto-load modules:
#cat <<'DATA' | sudo tee -a /etc/conf.d/modules
#modules="vboxguest vboxsf"
#DATA
SCRIPT

$script_cleanup = <<SCRIPT
# clean kernel sources after vbox-guest-additions install
cd /usr/src/linux && sudo make distclean
# stop rsyslog to allow zerofree to proceed
sudo /etc/init.d/rsyslog stop
# /boot
sudo mount -o remount,ro /dev/sda1
sudo zerofree /dev/sda1
# /
sudo mount -o remount,ro /dev/sda4
sudo zerofree /dev/sda4
# swap
sudo swapoff /dev/sda3
sudo bash -c 'dd if=/dev/zero of=/dev/sda3 2>/dev/null' || true
sudo mkswap /dev/sda3
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.hostname = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "#{ENV['BUILD_GUEST_MEMORY']}"
    vb.cpus = "#{ENV['BUILD_GUEST_CPUS']}"
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]
  end
  config.ssh.pty = true
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provision "guest-additions", type: "shell", inline: $script_guest_additions
  config.vm.provision "cleanup", type: "shell", inline: $script_cleanup
end
