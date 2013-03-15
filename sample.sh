#!/bin/sh

echo 'alias rdev="RAILS_ENV=development bundle exec"' >> /home/vagrant/.profile
su vagrant -l
cd /vagrant && cp config/database.yml.vagrant config/database.yml
su vagrant -l -c 'cd /vagrant && bash -i bundle'
