# -*- mode: ruby -*-
# vi: set ft=ruby :
# Written with Vagrant 1.1 in mind

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-12.04.1-nfs"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # Make sure the box has nfs-common installed.
  config.vm.box_url = ""

  # Private (hostonly) network
  config.vm.network :private_network, ip: "192.168.33.10"

  # Bridged network
  # config.vm.forward_port 3000, 3000

  config.vm.synced_folder(".", "/vagrant", :nfs => true)

  # Change the memory to what's needed
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  #
  #/// Chef Provisioning
  #

  config.vm.provision :chef_solo do |prechef|
    # If using a recipe_url for the cookbooks, include it here too
    # prechef.recipe_url = 
    prechef.add_recipe "vagrantfun::update_chef" #for Chef 11

    # Can also update with the omnibus_updater cookbook, but that adds
    # about 20-30 seconds to the process and has trouble
    # with the pg gem (but manages to successfully install it).
    # prechef.json = {
    #   :omnibus_updater => {
    #     :version => '11.4.0',
    #     :remove_chef_system_gem => true
    #   }
    # }
    # prechef.add_recipe "omnibus_updater"

  end

  config.vm.provision :chef_solo do |chef|
    # Specify TAR ball uri if you are using one:
    # chef.recipe_url = 

    chef.json = { 

      #If you're installing Java
      'java' => {
        'jdk_version' => 7,
        'install_flavor' => 'oracle',
        'oracle' => {
          "accept_oracle_download_terms" => true
        }
      },
      
      # JRuby
      'rbenv' => {
        'global' => 'jruby-1.7.2',
        'rubies' => [ 'jruby-1.7.2' ],
        'gems'   => {
          'jruby-1.7.2' => [
            { 'name'   => 'bundler' }
          ]
        }
      },

      # # MRI Ruby
      # 'rbenv' => {
      #   'global' => '1.9.3-p392',
      #   'rubies' => [ '1.9.3-p392' ],
      #   'gems'   => {
      #     '1.9.3-p392' => [
      #       { 'name'   => 'bundler' }
      #     ]
      #   }
      # },
      
      'mysql' => {
        "bind_address" => "127.0.0.1",
        "server_root_password" => "redLemurs",
        "server_repl_password" => "redLemurs",
        "server_debian_password" => "redLemurs",
        "dbs" => [
          {
            :name => 'junto_box_test',
            :user => 'junto',
            :user_pass => 'password'
          },
          {
            :name => 'junto_box_dev',
            :user => 'junto',
            :user_pass => 'password'
          }
        ]
      },

      # :postgresql => {
      #   :version => "9.2",
      #   'config' => {
      #     'ssl' => false
      #   },
      #   'password' => {
      #     'postgres' => "redLemurs"
      #     },
      #   "dbs" => [
      #     {
      #       :name => 'test',
      #       :user => 'test',
      #       :user_pass => 'password'
      #     },
      #     {
      #       :name => 'development',
      #       :user => 'test',
      #       :user_pass => 'password'
      #     }
      #   ]
      # }
    }


    #
    # RECIPES: without these nothing happens.
    #

    # For Java
    chef.add_recipe "java"

    # For installing Ruby (version specified in chef.json above)
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::system"
    
    # For Postgres
    # chef.add_recipe "vagrantfun::add_repos"
    # chef.add_recipe "postgresql::server"
    # chef.add_recipe "postgresql::ruby"

    # For MySQL
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::ruby"

    # For automatiaclly creating databases/users as specified in the 'dbs' hashes in the chef.json above
    chef.add_recipe "vagrantfun::create_databases"

    ###
    ### Application Startup scripts
    ###

  end
  # for some shell provisioning. It's the simplest way I've found for appilcation setup
  config.vm.provision :shell, :path => "sample.sh"
end
