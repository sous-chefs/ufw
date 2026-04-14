# frozen_string_literal: true

provides :ufw_firewall
unified_mode true

property :firewall_name, String, name_property: true
property :rules, [Array, Hash], default: {}
property :allow_ssh, [true, false], default: true
property :data_bag_name, [String, nil], desired_state: false
property :collect_recipe_rules, [true, false], default: false, desired_state: false
property :securitylevel, [String, nil]

action_class do
  include UfwCookbook::Helpers
  include FirewallCookbook::Helpers
  include FirewallCookbook::Helpers::Ufw

  def resolved_rules
    merged_rules(
      new_resource.rules,
      new_resource.collect_recipe_rules ? recipe_rules_from_node(node) : nil,
      new_resource.data_bag_name ? data_bag_rules(node, new_resource.data_bag_name) : nil
    )
  end

  def declare_firewall_rule(rule_name, params)
    firewall_rule rule_name do
      firewall_name(params['name'] || new_resource.firewall_name)
      command rule_command(params)
      protocol rule_protocol(params) if params['protocol']
      direction params['direction'].to_sym if params['direction']
      interface params['interface'] if params['interface']
      logging params['logging'].to_sym if params['logging']
      port rule_port(params) if params['port'] || params['port_range']
      source params['source'] if params['source']
      destination params['destination'] if params['destination']
      dest_port rule_dest_port(params) if params['dest_port']
      position params['position'].to_i if params['position']
      notify_firewall false
      action :create
    end
  end

  def desired_rules_file(rule_resources)
    build_rule_file(
      rule_resources.each_with_object({}) do |rule_resource, rules|
        rules[build_rule(rule_resource)] = rule_resource.position
      end
    )
  end

  def apply_rules_command(rule_resources)
    commands = ['ufw --force reset']
    commands.concat(rule_resources.map { |rule_resource| build_rule(rule_resource) })
    commands << 'ufw --force enable'
    commands.join(' && ')
  end
end

action :create do
  validate_security_level!(node) if new_resource.securitylevel

  with_run_context :root do
    firewall new_resource.firewall_name do
      action :install
    end

    rule_resources = []

    if new_resource.allow_ssh
      rule_resources << declare_firewall_rule('ssh', { 'port' => '22' })
    end

    resolved_rules.each do |rule_name, params|
      rule_resources << declare_firewall_rule(rule_name, params)
    end

    file "managed #{new_resource.firewall_name} ufw rules" do
      path ufw_rules_filename
      content desired_rules_file(rule_resources)
      notifies :run, "execute[apply #{new_resource.firewall_name} ufw rules]", :immediately
    end

    execute "apply #{new_resource.firewall_name} ufw rules" do
      command lazy { apply_rules_command(rule_resources) }
      environment('PATH' => '/usr/sbin:/usr/bin:/sbin:/bin')
      action :nothing
    end
  end
end

action :delete do
  firewall new_resource.firewall_name do
    action :disable
  end

  execute "reset #{new_resource.firewall_name} ufw rules" do
    command 'ufw --force reset'
    environment('PATH' => '/usr/sbin:/usr/bin:/sbin:/bin')
    only_if 'command -v ufw >/dev/null 2>&1'
  end

  apt_package 'ufw' do
    action :purge
  end
end
