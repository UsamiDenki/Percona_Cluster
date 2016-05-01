#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Check your parameters of attributes and platform
#


if node[:platform_family] != "rhel"
  msg = 'This library support only Red Hat or CentOS distribution!!'
  Chef::Log.error(msg)
  raise msg
end

cluster_ips = node["percona_cluster"]["wsrep_cluster_addresses"]
node_ip = node["percona_cluster"]["wsrep_node_address"]

if cluster_ips.length < 1
  msg = '"Wsrep_cluster_addresses" IPs are empty!!'
  Chef::Log.error(msg)
  raise msg
end

if node_ip == ''
  msg = '"Wsrep_node_address" is empty!!'
  Chef::Log.error(msg)
  raise msg
end

if !cluster_ips.include?(node_ip)
  msg = '"Wsrep_cluster_address" do not include this node address: ' + node_ip
  Chef::Log.error(msg)
  raise msg
end
