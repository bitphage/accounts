# encoding: UTF-8
#
# Cookbook Name: accounts
# Definition: agroup
#
# Copyright 2009, Alexander van Zoest
#
define :agroup, gid: nil, sudo: false do

  # http://wiki.opscode.com/display/chef/Resources#Resources-Group
  group params[:name] do
    gid params[:gid]
  end

  node.set[:accounts][:sudo][:groups] |= [params[:name]] if params[:sudo]
end
