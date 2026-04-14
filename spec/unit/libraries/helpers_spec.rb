# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../libraries/helpers' unless defined?(UfwCookbook::Helpers)

describe UfwCookbook::Helpers do
  subject(:helper_host) do
    Class.new do
      include UfwCookbook::Helpers
    end.new
  end

  describe '#normalized_rules' do
    it 'normalizes array-form rules into a hash keyed by rule name' do
      rules = helper_host.normalized_rules(
        [
          { 'http' => { port: '80' } },
          { https: { 'port' => '443' } },
        ]
      )

      expect(rules).to eq(
        'http' => { 'port' => '80' },
        'https' => { 'port' => '443' }
      )
    end
  end

  describe '#rule_command' do
    it 'maps nil and create to allow for firewall_rule compatibility' do
      expect(helper_host.rule_command({})).to eq(:allow)
      expect(helper_host.rule_command('action' => 'create')).to eq(:allow)
      expect(helper_host.rule_command('action' => 'deny')).to eq(:deny)
    end
  end

  describe '#recipe_rules_from_node' do
    it 'collects cookbook and recipe scoped firewall rules from the expanded run list' do
      node = {
        'apache2' => { 'firewall' => { 'rules' => [{ 'https' => { 'port' => '443' } }] } },
        'apache2::mod_ssl' => { 'firewall' => { 'rules' => [{ 'tls' => { 'port' => '8443' } }] } },
      }
      expanded_node = instance_double('expanded node', recipes: ['apache2::mod_ssl'])

      allow(node).to receive(:expand!).and_return(expanded_node)

      expect(helper_host.recipe_rules_from_node(node)).to eq(
        'https' => { 'port' => '443' },
        'tls' => { 'port' => '8443' }
      )
    end
  end
end
