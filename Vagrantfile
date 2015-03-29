# -*- mode: ruby -*-
# vi: set ft=ruby :

# Group name (used in VirtualBox GUI)
GROUP = "Video"

# VM settings
NAME = "Video Web Server"
MEMORY = 384
CPU = 1


Vagrant.configure("2") do |config|
  config.vm.define :web, primary: true do |web|
    web.vm.box = "ubuntu/trusty64"
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
    end
    web.vm.hostname = "web"
    web.vm.network :forwarded_port, host: 8080, guest: 80
    web.vm.provider "virtualbox" do |v|
      v.name = "Video Web Server"
      v.memory = MEMORY
      v.cpus = CPU
      v.customize [ 
        "modifyvm", :id,
        "--groups", "/#{GROUP}"
      ]
    end

    web.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install --assume-yes nginx
      cp /vagrant/index.html /usr/share/nginx/html/
      ln -s /vagrant/video /usr/share/nginx/html/video
      chmod 644 /usr/share/nginx/html/index.html
    SHELL

  end
end
