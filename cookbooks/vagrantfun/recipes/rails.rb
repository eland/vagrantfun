execute "apt-get install -y -q libpq-dev"

execute "bundle" do
  command "su vagrant -l -c 'cd /vagrant && bash -i bundle install'"
end

execute "migrate" do
  command "su vagrant -l -c 'cd /vagrant && bash -i rake db:migrate'"
end

#execute "start rails" do
#  command "su vagrant -l -c 'cd /vagrant && bash -i bundle exec rails s'"
#end
