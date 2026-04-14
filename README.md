# ufw Cookbook

The `ufw` cookbook provides a single custom resource, `ufw_firewall`, for managing
Uncomplicated Firewall on Debian and Ubuntu with the `firewall` cookbook's UFW provider.

## Requirements

### Platforms

- Debian 12+
- Ubuntu 22.04+

### Chef

- Chef 15.3+

### Cookbooks

- `firewall` 2.0+

## Resource

### ufw_firewall

`ufw_firewall` installs and enables UFW, optionally opens SSH, and applies the provided rule set.
It can also merge in rules discovered from a data bag or from legacy recipe-level firewall
attributes during migration.

```ruby
ufw_firewall 'default' do
  allow_ssh true
  rules(
    [
      { 'http' => { 'port' => '80' } },
      { 'https' => { 'port' => '443' } },
      {
        'block-admin' => {
          'port' => '8443',
          'source' => '192.0.2.10',
          'action' => 'deny',
        },
      },
    ]
  )
  action :create
end
```

### Data bag-backed rules

```ruby
ufw_firewall 'default' do
  data_bag_name 'firewall'
  action :create
end
```

### Collect rules from other cookbooks' recipe attributes

```ruby
ufw_firewall 'default' do
  collect_recipe_rules true
  action :create
end
```

### Remove UFW and reset the firewall

```ruby
ufw_firewall 'default' do
  action :delete
end
```

See [`documentation/ufw_ufw_firewall.md`](documentation/ufw_ufw_firewall.md) for the full
resource API.

## License & Authors

**Author:** Cookbook Engineering Team ([cookbooks@chef.io](mailto:cookbooks@chef.io))

**Copyright:** 2011-2014, Chef Software, Inc.

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
