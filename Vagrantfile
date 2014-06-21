# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ### Define options for all VMs ###
    # Using vagrant-cachier improves performance if you run repeated yum/apt updates
    if defined? VagrantPlugins::Cachier
      config.cache.auto_detect = true
    end
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "4", "--ioapic", "on"]
    end

    ### VM-Specific Options ###
    config.vm.define :centos6_latest do |node|

      node.vm.box = 'centos-65-x64-virtualbox-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box'
      node.vm.hostname = 'centos6.boxnet'
      node.vm.network :private_network, ip: "192.168.37.24"

      # puppet install script to avoid re-writing the same code over and over
      node.vm.provision "shell", inline: "curl http://getpuppet.deployto.me | bash"
    end

    config.vm.define :debian7_latest do |node|

      node.vm.box = 'debian-73-x64-virtualbox-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-nocm.box'
      node.vm.hostname = 'debian7.boxnet'
      node.vm.network :private_network, ip: "192.168.37.23"

      # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # puppet install script to avoid re-writing the same code over and over
      node.vm.provision "shell", inline: "curl http://getpuppet.deployto.me | bash"
    end
end

