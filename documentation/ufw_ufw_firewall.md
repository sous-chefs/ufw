# ufw_ufw_firewall

Manage Uncomplicated Firewall (UFW) on Debian and Ubuntu hosts.

## Actions

| Action | Description |
|--------|-------------|
| `:create` | Installs UFW, enables the firewall, and applies the resolved rule set (default) |
| `:delete` | Disables UFW, resets its rules, and purges the package |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `firewall_name` | String | `name property` | Logical firewall name passed to the `firewall` cookbook resources |
| `rules` | Array, Hash | `{}` | Explicit firewall rules to apply |
| `allow_ssh` | true, false | `true` | Opens TCP port 22 before applying custom rules |
| `data_bag_name` | String, nil | `nil` | Data bag to scan for additional rules keyed by role or recipe name |
| `collect_recipe_rules` | true, false | `false` | Merges legacy `node['<recipe>']['firewall']['rules']` values into the final rule set |
| `securitylevel` | String, nil | `nil` | Enables SecurityLevel role validation before applying rules |

## Examples

### Basic usage

```ruby
ufw_firewall 'default' do
  rules(
    [
      { 'http' => { 'port' => '80' } },
      { 'https' => { 'port' => '443' } },
    ]
  )
  action :create
end
```

### Merge in data bag rules

```ruby
ufw_firewall 'default' do
  data_bag_name 'firewall'
  action :create
end
```

### Remove UFW and reset the firewall

```ruby
ufw_firewall 'default' do
  action :delete
end
```
