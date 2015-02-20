accounts Cookbook
=================
[![Build Status](https://secure.travis-ci.org/onehealth-cookbooks/accounts.png?branch=master)](http://travis-ci.org/onehealth-cookbooks/accounts)

This cookbook combines system account management for different services under a single interface.
It currently manages users, groups and the associate ssh and sudo settings.

It provides the following definitions:
- account
- agroup

It uses the cookbook files directory for all the files used for each account (ssh, etc.), which could be a symlink, 
git submodule or however you would like to manage that data.

Requirements
============

# Usage

```ruby
include_recipe "accounts"

# optionally set node[:accounts][:cookbook] to the cookbook that contains the config files

account "role" do
  uid "700"
  account_type "role"
  comment "Role Account"
  ssh false
  sudo true
end
  
agroup "users" do
  gid "100"
  sudo true
end
```

Attributes
==========

Below are the attributes that you can set to influence how the cookbook behaves.

* `node[:accounts][:dir]` - Home Directory for accounts, default `/home`
* `node[:accounts][:cookbook]` - Cookbook to grab the actual account settings from, default `accounts`
* `node[:accounts][:default][:shell]` - Default Account Shell if none specified
* `node[:accounts][:default][:group]` - Default Account Group if none specified
* `node[:accounts][:default][:do_ssh]` - Boolean to copy over the `authorized_keys` file from `files/default/{roles,users}/<account>/ssh/`
* `node[:accounts][:default][:do_sudo]` - Boolean to enable `sudo` access for the account

License and Authors
===================

* Author:: Sander van Zoest <svanzoest@onehealth.com>

* Copyright:: 2009 Alexander van Zoest
* Copyright:: 2010-2014, OneHealth Solutions, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
