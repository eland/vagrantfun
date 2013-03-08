#
# Cookbook Name:: vagrantfun
# Recipe:: add_repos
#

apt_repository "postgresql" do
  uri "http://apt.postgresql.org/pub/repos/apt/"
  distribution 'precise-pgdg'
  components ['main']
  key "http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc"
end