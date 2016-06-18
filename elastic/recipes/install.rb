#
# Cookbook Name:: elastic
# Recipe:: install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# get information about instance
instance = search("aws_opsworks_instance", "self:true").first
layer_id = instance['layer_ids'].first
stack    = search("aws_opsworks_stack").first

# get information about cluster nodes
cluster_nodes = search("aws_opsworks_instance", "layer_ids:#{layer_id}")
cluster_config = {
  'cluster.name' => node['elasticsearch']['cluster_name'],
  'cloud.aws.region' => stack['region'],
  'discovery.type' => 'ec2',
  'discovery.ec2.host_type' => 'private_ip',
  'discovery.ec2.ping_timeout' => '30s',
  'discovery.zen.ping.multicast.enabled' => 'false',
  'plugin.mandatory' => 'cloud-aws',
  'network.publish_host' => instance['private_ip']
  #'network.publish_host' => '_ec2:privateIp_'
}

# gather information about cluster
# if !cluster_nodes.nil?
#   cluster_config['discovery.zen.ping.unicast.hosts'] = '["' + cluster_nodes.map{|i| i['private_ip']}.sort.uniq.join('", "') + '"]'
# end

Chef::Log.info("********** The instance layers are '#{instance['layer_ids']}' **********")
Chef::Log.info("********** Cluster configuration: '#{cluster_config.inspect}' **********")

include_recipe 'java'
include_recipe 'chef-sugar'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch' do
  type node['elasticsearch']['install_type'].to_sym # since TK can't symbol.
end
elasticsearch_plugin 'cloud-aws'
elasticsearch_plugin 'lmenezes/elasticsearch-kopf/2.0'
elasticsearch_configure 'elasticsearch' do
  configuration(cluster_config)
end
elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end
