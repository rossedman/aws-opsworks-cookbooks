#
# Cookbook Name:: aws-cloudwatch
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

stack = search('aws_opsworks_stack').first

directory '/opt/aws/cloudwatch' do
  recursive true
end

remote_file '/opt/aws/cloudwatch/awslogs-agent-setup.py' do
  source 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
  mode '0755'
end

execute 'Install CloudWatch Logs agent' do
  command "/opt/aws/cloudwatch/awslogs-agent-setup.py -n -r #{stack['region']} -c /tmp/cwlogs.cfg"
  not_if { system 'pgrep -f aws-logs-agent-setup' }
end
