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

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  ###
  ### Port forwarding (APIs may need different ports)
  ###

  #for Rails
  config.vm.forward_port 3000, 3000

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "base.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #

  config.vm.customize ["modifyvm", :id, "--memory", 1536]

  config.vm.provision :chef_solo do |prechef|
    #If using a recipe_url, include it here too
    prechef.add_recipe "vagrantfun::update"
  end

  config.vm.provision :chef_solo do |chef|
    # chef.roles_path = "./roles"
    chef.cookbooks_path = "./cookbooks"
    # chef.data_bags_path = "./data_bags"
    # chef.add_recipe "users::sysadmins"
    # chef.add_recipe "vim"
    # chef.recipe_url = 'http://example.com/file.tar.gz' # put a tarball of the cookbooks here

    #for updated package lists
    # chef.add_recipe "vagrantfun::update"

    chef.json = { 
     #:omnibus_updater => {
     #  :version => '11.4.0'
     #},

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
        # "run_list" => ["recipe[postgresql::server]"]
        # :hba_file => "/etc/postgresql/9.2/main/pg_hba.conf"
      }
    }


    chef.add_recipe "vagrantfun::add_repos"
    # chef.add_recipe "postgresql"
    # chef.add_recipe "postgresql::client"
    chef.add_recipe "postgresql::server"
    # chef.add_recipe "postgresql::contrib"
    chef.add_recipe "postgresql::ruby"

    # chef.add_recipe "mysql::server"
    # chef.add_recipe "mysql::ruby"
    chef.add_recipe "vagrantfun::create_databases"

    # chef.add_recipe "java"

    #for installing any version of ruby

    # chef.add_recipe "ruby_build"
    # chef.add_recipe "rbenv::system"
    
    ###
    ### Application Startup scripts
    ###

    # chef.add_recipe "vagrantfun::rails"
 
  end


  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
