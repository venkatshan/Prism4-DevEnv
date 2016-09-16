# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.define "dev1"  do |dev1|
    dev1.vm.hostname="dev1"
    dev1.vm.box = "ubuntu/trusty64"
    dev1.vm.network "private_network", ip: "192.168.33.100"
    dev1.vm.network "forwarded_port", guest: 27017, host: 37017, id: "mongo7"
	dev1.vm.network "forwarded_port", guest: 27018, host: 37018, id: "mongo8"
	dev1.vm.network "forwarded_port", guest: 8081, host: 8081, id: "mongoser"
	dev1.vm.network "forwarded_port", guest: 8080, host: 8080, id: "tomcat"
	dev1.vm.provision "shell", path: "mongodb-install.sh"
    dev1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.memory = "1024"
    end
    config.vm.synced_folder "./", "/vagrant", disabled: true
    config.vm.synced_folder "./webapps", "/webapps"

  end

end
