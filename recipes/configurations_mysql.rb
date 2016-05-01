#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Configure MySQL for security and Make Percona user to MySQL
#


# Update MySQL
execute "Update MySQL" do
  user "root"
  command "mysql_upgrade -u root"
  only_if "mysqladmin --user=root --password='' version"
end

root_password = node["percona_cluster"]["root_password"]

# Configure password of root user if it is blank
execute "Update MySQL root password if password=''" do
  command "mysqladmin --user=root --password='' password '#{root_password}'"
  only_if "mysqladmin --user=root --password='' version"
  sensitive true
end

# Delete anonymous users on MySQL
execute "mysql_secure_cinfiguration" do
  command <<-EOH
    mysql -u root -p#{root_password} -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -p#{root_password} -e "DROP DATABASE test;"
    mysql -u root -p#{root_password} -e "FLUSH PRIVILEGES;"
  EOH
  action :run
end

# Make this Percona user on MySQL
sstuser = node["percona_cluster"]["wsrep_sst_auth"]
border_no = sstuser.index(":")
sstuser_size = sstuser.length
sstuser_name = sstuser[ 0, border_no - 1 ]
sstuser_pass = sstuser[ border_no + 1, sstuser_size ]
execute "mysql_add_user: " + sstuser_name do
  command <<-EOH
    mysql -u root -p#{root_password} -e "GRANT RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* to '#{sstuser_name}'@'localhost' IDENTIFIED BY '#{sstuser_pass}';"
    mysql -u root -p#{root_password} -e "FLUSH PRIVILEGES;"
  EOH
  action :run
end
