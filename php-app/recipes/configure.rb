#
# Cookbook Name:: php_app
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package ["git", "php56"]

service "httpd" do
  action [:restart, :enable]
end
