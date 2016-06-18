#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# harden os
include_recipe 'os-hardening::default'

# create firewall
firewall 'default' do
  action    :install
end

firewall_rule 'ssh' do
  protocol :tcp
  port     22
  command  :allow
  source   '10.0.128.0/16'
end

firewall_rule 'http' do
  protocol  :tcp
  port      [80,443]
  command   :allow
  source    '10.0.128.0/16'
end
