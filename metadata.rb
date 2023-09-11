name             'ufw'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Installs and configures Uncomplicated Firewall (ufw)'
version          '4.0.3'
source_url       'https://github.com/sous-chefs/ufw'
issues_url       'https://github.com/sous-chefs/ufw/issues'
chef_version     '>= 15.3'

supports 'ubuntu'
supports 'debian'

depends 'firewall', '>= 2.0'
