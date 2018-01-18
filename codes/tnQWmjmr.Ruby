# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_BASE = "bento/centos-7.4"
VM_NAME = "devox"

VM_CORES = 2
VM_MEMORY = 2048

if !Vagrant.has_plugin?("vagrant-proxyconf")
        system('vagrant plugin install vagrant-proxyconf')
        raise("vagrant-proxyconf installed. Run command again.")
end

Vagrant.configure("2") do |config|
        # config.vm.box_download_location_trusted # treats redirects as trusted
        config.vm.box = VM_BASE
        config.vm.hostname = VM_NAME

        config.vm.provider "virtualbox" do |vb|
                vb.name = VM_NAME
                vb.cpus = VM_CORES
                vb.memory = VM_MEMORY
                vb.gui = true
        end

#       if Vagrant.has_plugin?("vagrant-proxyconf")
#               config.proxy.http     = "http://10.10.10.12:8080/"
#               config.proxy.https    = "https://10.10.10.12:8080/"
#               config.proxy.no_proxy = "localhost,127.0.0.1"
#       end

# yum install -y build-essential zsh wget git vim
# yum install -y bzip2 unzip p7zip-full
# yum install -y openssl htopi
# if [ ! -d ~vagrant/.oh-my-zsh ]; then
#  git clone https://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
# fi
# cp ~vagrant/.oh-my-zsh/templates/zshrc.zsh-template ~vagrant/.zshrc
# chown vagrant: ~vagrant/.zshrc
# chsh -s /bin/zsh vagrant

        config.vm.provision "shell", inline: <<-SHELL
                yum -y update --exclude=kernel*
                yum -y install epel-release
                yum -y groupinstall Xfce
                systemctl set-default graphical.target
        SHELL
end