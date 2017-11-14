VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :splunk do |splunk|
    # we use this box... It's small and base.
    splunk.vm.box = "minimal/centos6"

    # server bootstrap script.
    #splunk.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk "
    splunk.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk verbose"

    # uncomment this is fyou want to specify and ip for each host.
    splunk.vm.network "private_network", ip: "192.168.3.61"
    #  virtualbox__intnet:true

    # Uncomment this if you want to forward the ports to the host. i.e.
    splunk.vm.network "forwarded_port", guest: 8000, host: 8101
    #splunk.vm.network "forwarded_port", guest: 8443, host: 8443
  end

  config.vm.define :splunk_misc do |splunk_misc|
    # we use this box... It's small and base.
    splunk_misc.vm.box = "minimal/centos6"

    # server bootstrap script.
    splunk_misc.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk_misc verbose"

    # uncomment this is fyou want to specify and ip for each host.
    splunk_misc.vm.network "private_network", ip: "192.168.3.64"

    # Uncomment this if you want to forward the ports to the host. i.e.
    splunk_misc.vm.network "forwarded_port", guest: 8100, host: 8401
    splunk_misc.vm.network "forwarded_port", guest: 8200, host: 8402
    splunk_misc.vm.network "forwarded_port", guest: 8300, host: 8403
    splunk_misc.vm.network "forwarded_port", guest: 8400, host: 8404
    splunk_misc.vm.network "forwarded_port", guest: 8500, host: 8405
  end

  config.vm.define :splunk_idxc do |splunk_idxc|
    # we use this box... It's small and base.
    splunk_idxc.vm.box = "minimal/centos6"

    # server bootstrap script.
    splunk_idxc.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk_idxc verbose"

    # uncomment this is fyou want to specify and ip for each host.
    splunk_idxc.vm.network "private_network", ip: "192.168.3.62"

    # Uncomment this if you want to forward the ports to the host. i.e.
    splunk_idxc.vm.network "forwarded_port", guest: 8100, host: 8201
    splunk_idxc.vm.network "forwarded_port", guest: 8200, host: 8202
    splunk_idxc.vm.network "forwarded_port", guest: 8300, host: 8203
    splunk_idxc.vm.network "forwarded_port", guest: 8400, host: 8204
  end

  config.vm.define :splunk_shc do |splunk_shc|
    # we use this box... It's small and base.
    splunk_shc.vm.box = "minimal/centos6"

    # server bootstrap script.
    splunk_shc.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk_shc verbose"

    # uncomment this is fyou want to specify and ip for each host.
    splunk_shc.vm.network "private_network", ip: "192.168.3.63"

    # Uncomment this if you want to forward the ports to the host. i.e.
    splunk_shc.vm.network "forwarded_port", guest: 8100, host: 8301
    splunk_shc.vm.network "forwarded_port", guest: 8200, host: 8302
    splunk_shc.vm.network "forwarded_port", guest: 8300, host: 8303
  end

  config.vm.define :splunk_lb do |splunk_lb|
    # we use this box... It's small and base.
    splunk_lb.vm.box = "minimal/centos6"

    # server bootstrap script.
    #splunk_lb.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk_lb "
    splunk_lb.vm.provision :shell, inline: "/vagrant/bootstrap.sh splunk_lb verbose"

    # uncomment this is fyou want to specify and ip for each host.
    splunk_lb.vm.network "private_network", ip: "192.168.3.65"
    #  virtualbox__intnet:true

    # Uncomment this if you want to forward the ports to the host. i.e.
    splunk_lb.vm.network "forwarded_port", guest: 8080, host: 8080
    splunk_lb.vm.network "forwarded_port", guest: 443, host: 8443
  end

 end
