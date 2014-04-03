# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'chriskottom-precise64'
  config.berkshelf.enabled = true

  #  GLOBAL CONFIG FOR VIRTUALBOX PROVIDER
  #
  config.vm.provider 'virtualbox' do |v|
    v.cpus = 1
  end

  #  WEB SERVER NODE
  #
  config.vm.define 'web' do |web|
    web.vm.provider 'virtualbox' do |vb|
      vb.memory = 768
    end
    web.vm.network 'forwarded_port', guest: 80, host: 8080
    web.vm.network 'private_network', ip: '192.168.33.201'
    web.vm.network 'public_network', bridge: 'wlan0'
    web.vm.provision :chef_solo do |chef|
      chef.roles_path = 'roles'
      chef.add_role 'web'
      chef.json = {
        :set_fqdn => 'web.local'
      }
    end
  end

  #  DB SERVER NODE
  #
  config.vm.define 'db' do |db|
    db.vm.provider 'virtualbox' do |vb|
      vb.memory = 768
    end
    db.vm.network 'private_network', ip: '192.168.33.202'
    db.vm.network 'public_network', bridge: 'wlan0'
    db.vm.provision :chef_solo do |chef|
      chef.roles_path = 'roles'
      chef.add_role 'db'
      chef.json = {
        :set_fqdn => 'db.local',
        :mysql => {
          :server_root_password => 'rootpass'
        }
      }
    end
  end

  #  ELASTICSEARCH CLUSTER
  #
  es_cluster_attributes = {
    'es1' => '192.168.33.203',
    'es2' => '192.168.33.204'
  }
  es_cluster_attributes.each do |hostname, ip_address|
    config.vm.define hostname do |es|
      es.vm.provider 'virtualbox' do |vb|
        vb.memory = 1024
      end
      es.vm.network 'private_network', ip: ip_address
      es.vm.network 'public_network', bridge: 'wlan0'
      es.vm.provision :chef_solo do |chef|
        chef.roles_path = 'roles'
        chef.add_role 'elasticsearch'
        chef.json = {
          set_fqdn: "#{ hostname }.local",
          elasticsearch: {
            node: { name: hostname },
            network: { host: ip_address }
          }
        }
      end
    end
  end
end
