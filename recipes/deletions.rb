#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Delete not necessary packages
#


package "Percona-Server*" do
  action :remove
  #only_if "yum list installed | grep -q  Percona-Server*"
end

package "mysql-libs" do
  action :remove
  not_if "yum list installed | grep -q *mysql-libs*"
end
