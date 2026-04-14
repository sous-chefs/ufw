# frozen_string_literal: true

module UfwCookbook
  module Helpers
    SECURITY_LEVEL_ROLE_PATTERN = /SecurityLevel-(Red|Green|Yellow)/.freeze unless const_defined?(:SECURITY_LEVEL_ROLE_PATTERN)

    def merged_rules(*rule_sets)
      rule_sets.compact.reduce({}) do |combined, raw_rules|
        combined.merge(normalized_rules(raw_rules))
      end
    end

    def normalized_rules(raw_rules)
      case raw_rules
      when Array
        raw_rules.each_with_object({}) do |rule_mash, rules|
          next unless rule_mash.respond_to?(:each)

          rule_mash.each do |rule_name, params|
            rules[rule_name.to_s] = stringify_keys(params || {})
          end
        end
      when Hash
        raw_rules.each_with_object({}) do |(rule_name, params), rules|
          rules[rule_name.to_s] = stringify_keys(params || {})
        end
      else
        {}
      end
    end

    def recipe_rules_from_node(node)
      expanded_node = node.expand!

      expanded_node.recipes.each_with_object({}) do |recipe, rules|
        cookbook = recipe.split('::').first

        if recipe != cookbook
          rules.merge!(normalized_rules(nested_rules(node, cookbook)))
        end

        rules.merge!(normalized_rules(nested_rules(node, recipe)))
      end
    end

    def data_bag_rules(node, data_bag_name)
      data_bag_entries = Chef::DataBag.load(data_bag_name)
      run_list_entries(node).each_with_object({}) do |entry, rules|
        next unless data_bag_entries.key?(entry)

        item = data_bag_item(data_bag_name, entry)
        rules.merge!(normalized_rules(item['rules']))
      end
    rescue Net::HTTPClientException
      {}
    end

    def run_list_entries(node)
      expanded_node = node.expand!
      role_entries = expanded_node.roles
      recipe_entries = expanded_node.recipes.map { |recipe| recipe.tr(':', '_') }

      (Array(role_entries) + recipe_entries).uniq
    end

    def validate_security_level!(node)
      count = node.expand!.roles.count { |role| role.match?(SECURITY_LEVEL_ROLE_PATTERN) }
      return if count <= 1

      raise Chef::Exceptions::AmbiguousRunlistSpecification,
            "conflicting SecurityLevel-'color' roles, only 1 may be applied."
    end

    def rule_command(params)
      action = params['action']
      return :allow if action.nil? || action == 'create'

      action.to_sym
    end

    def rule_protocol(params)
      params['protocol']&.to_sym
    end

    def rule_port(params)
      return params['port'].to_i if params['port']
      return unless params['port_range']

      raise 'ufw: port_range was specified to firewall_rule without protocol' unless params['protocol']

      range_bounds = params['port_range'].split('..').map(&:to_i)
      range_bounds.first..range_bounds.last
    end

    def rule_dest_port(params)
      params['dest_port']&.to_i
    end

    def stringify_keys(value)
      return value.transform_keys(&:to_s) if value.is_a?(Hash)

      value
    end

    def nested_rules(node, key)
      collection = node[key]
      return unless collection

      firewall_config = collection['firewall']
      return unless firewall_config

      firewall_config['rules']
    end
  end
end
