Vagrantfun
==========

Purpose
---------
The goal is to have a Vagrantfile that one can comment in/out a few things, pop it into an existing github
repostory, run `vagrant up` and be most of the way to a fully functioning development environment, saving the
headaches of setting up for each separate project. It makes things such as rvm less necessary as well.

Setup
---------
Put the Vagrantfile into your project. Either also put the cookbooks into the project or `tar cfz` them into
a tarball, upload to something like dropbox or aws, and then put the url in the two specified places in the
Vagrantfile.

Look through the Vagrantfile and comment in/out what you need in the chef provisioning section.

Make sure to install [virtualbox](https://www.virtualbox.org/wiki/Downloads) and [vagrant](http://www.vagrantup.com/).

After that, simply run `vagrant up` to build the machine. With MRI Ruby and a database, this should take roughly 12 minutes once the base box is downloaded.

Use
---------
Type `vagrant up` to get started. You'll have to choose an option for internet connectivity at one point.

Once the box is built, you have several commands available to you.

`vagrant ssh` will put you into the machine. Type `cd /vagrant` and you'll see your project's files.
From here, you can type commands such as `bundle install` and `bundle exec rake db:migrate` like you're used to.
When you're done with what you need to do in the box, type `exit` to go back to your own machine.

If you're done for the day, you can type `vagrant suspend` to stop the machine in its current state and `vagrant resume` to start it again.

If you want to shut down the VM, use `vagrant halt`. Type `vagrant up` to start it again.

To remove the machine type `vagrant destroy`
