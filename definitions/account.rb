# encoding: UTF-8
#
# Cookbook Name: accounts
# Definition: account
#
# Copyright 2009, Alexander van Zoest
#
# define :account, uid: nil,
#                   comment: nil,
#                   group: node['accounts']['default']['group'],
#                   ssh: node['accounts']['default']['do_ssh'],
#                   sudo: node['accounts']['default']['do_sudo'] do
define :account, account_type: 'user',
                 uid: nil,
                 comment: nil,
                 group: 'users',
                 ssh: false,
                 configs: false,
                 sudo: false,
                 :action => "create" do
  home_dir = params[:home] || "#{node['accounts']['dir']}/#{params[:name]}"

  user params[:name] do
    comment params[:comment] if params[:comment]
    password params[:password] if params[:password]
    uid params[:uid] if params[:uid]
    gid params[:gid] || params[:group]
    shell params[:shell] || node['accounts']['default']['shell']
    home home_dir
    action params[:action]
  end

  directory home_dir do
    recursive true
    owner params[:name]
    group params[:gid] || params[:group]
    mode 0711
    if params[:action] == "create"
      action "create"
    elsif params[:action] == "remove"
      action "delete"
    end
  end

  if params[:ssh] and params[:action] == "create"
    remote_directory "#{home_dir}/.ssh" do
      cookbook node['accounts']['cookbook']
      source "#{params[:account_type]}s/#{params[:name]}/ssh"
      files_backup node['accounts']['default']['file_backup']
      files_owner params[:name]
      files_group params[:gid] || params[:group]
      files_mode 0600
      owner params[:name]
      group params[:gid] || params[:group]
      mode '0700'
    end
  end

  if params[:configs] and params[:action] == "create"
    remote_directory "#{home_dir}/" do
      cookbook node['accounts']['cookbook']
      source "#{params[:account_type]}s/#{params[:name]}/configs"
      files_backup node['accounts']['default']['file_backup']
      files_owner params[:name]
      files_group params[:gid] || params[:group]
      files_mode 0600
      owner params[:name]
      group params[:gid] || params[:group]
      mode '0700'
    end
  end

  if params[:sudo] and params[:action] == "create"
    unless node['accounts']['sudo']['groups'].include?(params[:group])
      unless node['accounts']['sudo']['users'].include?(params[:name])
        a = Array.new(node['accounts']['sudo']['users'])
        a.push(params[:name])
        node.set['accounts']['sudo']['users'] = a
      end
    end
  end
end
