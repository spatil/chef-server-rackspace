#
# Cookbook Name:: apt
# Recipe:: cacher-ng
#
# Copyright 2008-2013, Opscode, Inc.
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

# install rvm api gem during chef compile phase
gem_package 'rvm' do
  action :nothing
end.run_action(:install)

require 'rubygems'
Gem.clear_paths
require 'rvm'
create_rvm_shell_chef_wrapper
create_rvm_chef_user_environment

template "/etc/apt-cacher-ng/acng.conf" do
  source "acng.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[apt-cacher-ng]", :immediately
end

class Chef::Recipe
  # mix in recipe helpers
  include Chef::RVM::RecipeHelpers
  include Chef::RVM::StringHelpers
end
