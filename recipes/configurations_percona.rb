#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Configure MySQL for this Percona-XtraDB-Cluster-56 and boot
#


# Configure /etc/my.cnf
wsrep_cluster_addresses = node["percona_cluster"]["wsrep_cluster_addresses"]
wsrep_node_address = node["percona_cluster"]["wsrep_node_address"]
wsrep_node_no = wsrep_cluster_addresses.index(wsrep_node_address) + 1
wsrep_cluster_addresses = "gcomm://#{wsrep_cluster_addresses.join(',')}"

template "my.cnf" do
  source "my.cnf.erb"
  path   "/etc/my.cnf"
  owner "root"
  group "root"
  mode "0644"
  sensitive true
  action :create
  variables({
              wsrep_cluster_addresses: wsrep_cluster_addresses,
              wsrep_cluster_name: node["percona_cluster"]["wsrep_cluster_name"],
              wsrep_node_no: wsrep_node_no,
              wsrep_node_address: wsrep_node_address,
              wsrep_sst_auth: node["percona_cluster"]["wsrep_sst_auth"]
            })
end


# Boot Percona-XtraDB-Cluster-56
service "mysql" do
  supports :restart => true, :status => true, :reload => true
  action :nothing
end

rpv = node[:platform_version].to_i
if wsrep_node_no == 1
  execute "mysql_restart with systemctl mysql@bootstrap" do
    user "root"
    action :run
    if rpv > 6
      command <<-EOH
      systemctl restart mysql@bootstrap.service
      EOH
    else
      command <<-EOH
      service mysql bootstrap-pxc
      EOH
    end
  end
else
  execute "mysql_restart with service" do
    user "root"
    notifies :restart, "service[mysql]"
  end
end
