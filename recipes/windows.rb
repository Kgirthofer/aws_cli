#
# Cookbook Name:: radian_aws_cli
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
directory 'C:\Temp\aws-cli' do
  group 'administrators'
  mode '0777'
  action :create
  provider
end

remote_file 'aws cli' do
  source 'https://s3.amazonaws.com/aws-cli/AWSCLI64.msi'
  path 'C:\Temp\aws-cli\AWSCLI64.msi'
  action :create
end

#  execute 'install cli' do
windows_package 'AWS Command Line Interface' do
  options '/qb /norestart /L*v c:\Temp\aws-cli\install.log'
  source 'C:\Temp\aws-cli\AWSCLI64.msi'
  version '1.7.39'
  action :install
end
