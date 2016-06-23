#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

stack = search('aws_opsworks_stack').first

package = value_for_platform_family(
  'rhel' => {
    'url' => "https://amazon-ssm-#{stack['region']}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm",
    'pkg' => 'amazon-ssm-agent.rpm'
  },
  'debian' => {
    'url' => "https://amazon-ssm-#{stack['region']}.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb",
    'pkg' => 'amazon-ssm-agent.deb'
  }
)

install_path = "/tmp/#{package['pkg']}"

remote_file install_path do
  source package['url']
  action :create
end

if node[:platform_family].include?('debian')
  dpkg_package 'ssm' do
    source install_path
  end
else
  package 'ssm' do
    source install_path
  end
end
