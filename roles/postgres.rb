name 'postgres'
description 'postgres'

default_attributes({
 :postgresql => {
  :version => "9.2",
  :users => [
   {
    :username => "test",
    :password => "password",
    :superuser => true,
    :createdb => true,
    :login => true  
   }  
  ],
  :hba_file => "/etc/postgresql/9.2/main/pg_hba.conf"
  }
})

run_list(*%w[
  postgresql
  postgresql::client
  postgresql::server
  postgresql::contrib
  postgresql::postgis
])
