name             'ufw'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Installs and configures Uncomplicated Firewall (ufw)'
version          '3.2.14'
depends          'firewall', '>= 2.0'

supports 'ubuntu'

source_url 'https://github.com/chef-cookbooks/ufw'
issues_url 'https://github.com/chef-cookbooks/ufw/issues'
chef_version '>= 12.15'
