#
# Cookbook Name:: php_app
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

data_dir = value_for_platform(
  "centos" => { "default" => "/srv/www/shared" },
  "ubuntu" => { "default" => "/srv/www/data" },
  "default" => "/var/www/html"
)

app = search("aws_opsworks_app").first
Chef::Log.info("********** The app's URL is '#{app['app_source']['url']}' **********")
Chef::Log.info("********** The app's revision is '#{app['app_source']['revision']}' **********")

git data_dir do
  repository app['app_source']['url']
  revision app['app_source']['revision']
  action :sync
end

service "httpd" do
  action :restart
end
