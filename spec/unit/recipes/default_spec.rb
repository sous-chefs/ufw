require 'spec_helper'

describe 'ufw::default' do
  context 'rules attribute is Array' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node, _server|
        node.normal['firewall']['rules'] = [
          { 'http'  => { 'port' => '80'  } },
          { 'https' => { 'port' => '443' } },
        ]
      end.converge(described_recipe)
    end

    it 'calls firewall rule for each ' do
      expect(chef_run).to create_firewall_rule('http').with(
        port: 80,
        protocol: :tcp
      )
      expect(chef_run).to create_firewall_rule('https').with(
        port: 443,
        protocol: :tcp
      )
    end
  end

  context 'rules attribute is Hash' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node, _server|
        node.normal['firewall']['rules']   = { 'http'  => { 'port' => '80'  } }
        node.override['firewall']['rules'] = { 'https' => { 'port' => '443' } }
      end.converge(described_recipe)
    end

    it 'calls firewall rule for each ' do
      expect(chef_run).to create_firewall_rule('http').with(
        port: 80,
        protocol: :tcp
      )
      expect(chef_run).to create_firewall_rule('https').with(
        port: 443,
        protocol: :tcp
      )
    end
  end
end
