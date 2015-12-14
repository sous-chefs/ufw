name             'ufw'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache 2.0'
description      'Installs and configures Uncomplicated Firewall (ufw)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
depends          'firewall', '>= 2.0'

supports 'ubuntu'

source_url 'https://github.com/chef-cookbooks/ufw' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/ufw/issues' if respond_to?(:issues_url)

attribute 'firewall/rules',
  display_name: 'List of firewall rules for the node.',
  description: 'List of firewall rules for the node. Possibly set by node, roles or data bags.',
  type: 'array'

attribute 'firewall/securitylevel',
  display_name: 'Security level of the node.',
  description: 'Security level of the node, may be set by node, roles or environment.'
