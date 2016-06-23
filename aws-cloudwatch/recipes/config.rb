#
# Cookbook Name:: aws-cloudwatch
# Recipe:: config
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

stack = search('aws_opsworks_stack').first
instance = search("aws_opsworks_instance", "self:true").first

template '/tmp/cwlogs.cfg' do
  cookbook 'aws-cloudwatch'
  source 'cwlogs.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables({
    'instance_id' => instance['ec2_instance_id'],
    'hostname'    => instance['hostname'],
    'stack_name'  => stack['name'],
    'region'      => stack['region'],
    'logfiles'    => node[:cwlogs][:logfiles]
  })
end
