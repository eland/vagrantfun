#
# Cookbook Name:: vagrantfun
# Recipe:: create_databases
#
# Requires the Database cookbook and respective database cookbooks (e.g. mysql)

# unless node['mysql'].nil?
unless node['mysql']['dbs'].nil?
  mysql_connection_info = {:host => "localhost",
                           :username => "root",
                           :password => node['mysql']['server_root_password']}

  node['mysql']['dbs'].each do |database|
    
    mysql_database database[:name] do
      connection mysql_connection_info
      action :create
    end
    
    mysql_database_user database[:user] do
      connection mysql_connection_info
      database_name database[:name]
      password database[:user_pass]
      action :create
    end

    mysql_database_user database[:user] do
      connection mysql_connection_info
      database_name database[:name]
      password database[:user_pass]
      action :grant
    end
  end
end

unless node['postgresql']['dbs'].nil?
  # package "libpq5"
  # package "libpq-dev"
  postgresql_connection_info = {:host => "localhost",
                               :username => "postgres",
                               :password => node['postgresql']['password']['postgres']}

  node['postgresql']['dbs'].each do |database|
    
    postgresql_database database[:name] do
      connection postgresql_connection_info
      action :create
    end

    postgresql_database_user database[:user] do
      connection postgresql_connection_info
      database_name database[:name]
      password database[:user_pass]
      action :create
    end
    
    postgresql_database_user database[:user] do
      connection postgresql_connection_info
      database_name database[:name]
      password database[:user_pass]
      action :grant
    end
  end
end