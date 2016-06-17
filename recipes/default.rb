#
# Cookbook Name:: delphic_aws
# Recipe:: default
#
# Copyright (C) 2016 Karl Girthofer
#
# All rights reserved - Do Not Redistribute
#

zip_path = File.join(Chef::Config[:file_cache_path], 'awscli-bundle.zip')

package 'unzip' do
  action :install
end

remote_file 'aws cli' do
  source 'https://s3.amazonaws.com/DevOps-Software/awscli-bundle.zip'
  path zip_path
  action :create
  notifies :create, 'directory[/tmp/aws-cli]', :immediately
  notifies :create, 'remote_file[cp aws cli]', :immediately
  notifies :run,    'execute[unzip cli]',      :immediately
  notifies :run,    'execute[install cli]',    :immediately
end

directory '/tmp/aws-cli' do
  owner 'root'
  group 'root'
  mode '0755'
  action :nothing
end

# this will trigger unzip, which in turn will trigger install
remote_file 'cp aws cli' do
  source "file:///#{zip_path}"
  path '/tmp/aws-cli/awscli-bundle.zip'
  action :nothing
end

execute 'unzip cli' do
  cwd '/tmp/aws-cli'
  command 'unzip -o awscli-bundle.zip'
  action :nothing
end

execute 'install cli' do
  cwd '/tmp/aws-cli/awscli-bundle'
  command './install -i /usr/local/aws -b /usr/local/bin/aws'
  action :nothing
end

## need to delete this once we're done.
directory 'aws build delete' do
  path '/tmp/aws-cli'
  recursive true
  action :delete
end

include_recipe 'delphic_aws::audit' if respond_to? :control_group
