# encoding: UTF-8
#
# Cookbook Name:: accounts
# Recipe:: default
#
# Copyright 2009, Alexander van Zoest
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Default depenendencies that need to be installed for accounts to function.

if platform_family?('debian', 'rhel')
  # install ruby shadow to enable password changes on particular Linux families
  # @see https://tickets.opscode.com/browse/CHEF-4402
  chef_gem 'ruby-shadow' do
    action :install
  end
end

package 'sudo' do
  action :upgrade
end

template '/etc/sudoers' do
  cookbook node[:accounts][:cookbook]
  source 'sudoers.erb'
  mode 0440
  owner 'root'
  group 'root'
  variables(
    sudoers_groups: node[:accounts][:sudo][:groups],
    sudoers_users: node[:accounts][:sudo][:users]
  )
end
