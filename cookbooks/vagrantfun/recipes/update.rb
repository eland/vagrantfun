#
# Cookbook Name:: vagrantfun
# Recipe:: update
#

execute "apt-get update"

gem_package "chef" do
  action :install
  version "11.4.0"
end