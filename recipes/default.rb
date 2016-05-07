#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#


include_recipe "Percona_Cluster::inspections"
include_recipe "Percona_Cluster::deletions"
include_recipe "Percona_Cluster::installations"
include_recipe "Percona_Cluster::configurations_percona"
include_recipe "Percona_Cluster::configurations_mysql"


