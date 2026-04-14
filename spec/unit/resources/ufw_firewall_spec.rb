# frozen_string_literal: true

require 'spec_helper'

describe 'ufw_firewall' do
  step_into :ufw_firewall
  platform 'ubuntu', '24.04'
  default_attributes['firewall'] = { 'solution' => 'ufw' }

  context 'with explicit rules' do
    recipe do
      ufw_firewall 'default' do
        rules(
          [
            { 'http' => { 'port' => '80' } },
            { 'dns' => { 'port' => '53', 'protocol' => 'udp', 'action' => 'deny' } },
          ]
        )
      end
    end

    it { is_expected.to install_firewall('default') }
    it { is_expected.to create_firewall_rule('ssh').with(firewall_name: 'default', port: 22) }
    it { is_expected.to create_firewall_rule('http').with(firewall_name: 'default', command: :allow, port: 80) }
    it { is_expected.to create_firewall_rule('dns').with(firewall_name: 'default', command: :deny, port: 53, protocol: :udp) }
  end

  context 'with action :delete' do
    before do
      stub_command('command -v ufw >/dev/null 2>&1').and_return(true)
    end

    recipe do
      ufw_firewall 'default' do
        action :delete
      end
    end

    it { is_expected.to disable_firewall('default') }
    it { is_expected.to run_execute('reset default ufw rules') }
    it { is_expected.to purge_apt_package('ufw') }
  end
end
