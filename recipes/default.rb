#
# Cookbook Name:: percona_cluster
# Recipe:: default
#
# Copyright 2016, Kenichi Usami
#
# All rights reserved - Do Not Redistribute
#


include_recipe "percona_cluster::inspections"
include_recipe "percona_cluster::deletions"
include_recipe "percona_cluster::installations"
include_recipe "percona_cluster::configurations_percona"
include_recipe "percona_cluster::configurations_mysql"


