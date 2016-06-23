default[:cwlogs][:logfiles] = {
  'chef' => '/var/chef/runs/*/*.log',
  'cloudwatch' => '/var/log/awslogs.log',
  'cron' => '/var/log/cron',
  'syslog' => '/var/log/messages',
  'ssm' => '/var/log/amazon/ssm/amazon-ssm-agent.log',
  'opsworks' => '/var/log/aws/opsworks/opsworks-agent.statistics.log'
}
