# frozen_string_literal: true

name              'ufw'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Provides the ufw_firewall resource for managing Uncomplicated Firewall rules'
version           '4.0.10'
source_url        'https://github.com/sous-chefs/ufw'
issues_url        'https://github.com/sous-chefs/ufw/issues'
chef_version      '>= 15.3'

supports 'debian', '>= 12.0'
supports 'ubuntu', '>= 22.04'

depends 'firewall', '>= 2.0'
