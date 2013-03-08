#
# Cookbook Name:: vagrantfun
# Recipe:: update
#

gem_package "chef" do
  action :install
  version "11.4.0"
end
