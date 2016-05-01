#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#

#
# Configure your parameters to these attributes
#

default["percona_cluster"]["wsrep_cluster_addresses"] = []
default["percona_cluster"]["wsrep_node_address"] = ""
default["percona_cluster"]["wsrep_cluster_name"] = "my_cluster"
default["percona_cluster"]["wsrep_sst_auth"] = "sstuser:s3cret"
default["percona_cluster"]["root_password"] = "root_percona"
