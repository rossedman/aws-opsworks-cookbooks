#
# Cookbook Name:: base
# Recipe:: firewall
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['firewall']['ipv6_enabled'] = false

include_recipe 'firewall::default'

firewall_rule 'ssh' do
  protocol :tcp
  port     22
  command  :allow
  source   '10.0.128.0/16'
end

firewall_rule 'http' do
  protocol  :tcp
  port      [80, 443]
  command   :allow
  source    '10.0.128.0/16'
end
