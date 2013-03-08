# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-12.04.1"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://dl.dropbox.com/u/4031118/Vagrant/ubuntu-12.04.1-server-i686-virtual.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  config.vm.network :bridged

  ###
  ### Port forwarding (APIs may need different ports)
  ###

  #Standard Rails port
  config.vm.forward_port 3000, 3000

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # Note that the folder you run 'vagrant up' in is automatically
  # set to /vagrant in the VM.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"


  # Change the memory to what's needed
  config.vm.customize ["modifyvm", :id, "--memory", 1536]


  #
  # Chef Provisioning
  #

  config.vm.provision :chef_solo do |prechef|
    # If using a recipe_url for the cookbooks, include it here too
    # prechef.recipe_url = 

    prechef.add_recipe "vagrantfun::update_chef"

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
    # chef.roles_path = "./roles"
    # chef.data_bags_path = "./data_bags"
    # chef.add_recipe "users::sysadmins"
    # chef.add_recipe "vim"

    # Choose one of the following:
    chef.cookbooks_path = "./cookbooks"
    # chef.recipe_url = 'http://example.com/file.tar.gz' # put a tarball of the cookbooks here



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
      
      # 'mysql' => {
      #   "bind_address" => "3306",
      #   "server_root_password" => "redLemurs",
      #   "server_repl_password" => "redLemurs",
      #   "server_debian_password" => "redLemurs",
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
      # },

      :postgresql => {
        :version => "9.2",
        'config' => {
          'ssl' => false
        },
        'password' => {
          'postgres' => "redLemurs"
          },
        "dbs" => [
          {
            :name => 'test',
            :user => 'test',
            :user_pass => 'password'
          },
          {
            :name => 'development',
            :user => 'test',
            :user_pass => 'password'
          }
        ]
      }
    }


    #
    # RECIPES: without these nothing happens.
    #

    # For installing Ruby (version specified in chef.json above)
    # chef.add_recipe "ruby_build"
    # chef.add_recipe "rbenv::system"

    # For Java
    # chef.add_recipe "java"
    
    # For Postgres
    chef.add_recipe "vagrantfun::add_repos"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::ruby"

    # For MySQL
    # chef.add_recipe "mysql::server"
    # chef.add_recipe "mysql::ruby"

    # For automatiaclly creating databases/users as specified in the 'dbs' hashes in the chef.json above
    chef.add_recipe "vagrantfun::create_databases"

    ###
    ### Application Startup scripts
    ###

    # chef.add_recipe "vagrantfun::rails"
 
  end
end
