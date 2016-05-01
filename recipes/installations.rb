#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Install Percona-XtraDB-Cluster-56 and the yum Repository
#


execute "Percona yum Repository" do
  not_if { File.exists?("/etc/yum.repos.d/percona-release.repo") }
  command <<-EOH
    yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
  EOH
  action :run
end

include_recipe "yum-epel"
package "Percona-XtraDB-Cluster-56" do
  action :install
end
