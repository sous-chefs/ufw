# frozen_string_literal: true

require_relative '../../spec_helper'

control 'ufw-package-01' do
  impact 1.0
  title 'The ufw package is installed'

  describe package('ufw') do
    it { should be_installed }
  end
end

control 'ufw-service-01' do
  impact 1.0
  title 'The ufw service is enabled'

  describe service('ufw') do
    it { should be_enabled }
  end
end

control 'ufw-status-01' do
  impact 1.0
  title 'The configured ufw rules are active'

  describe command('ufw status') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/^Status: active/) }
    its('stdout') { should match(%r{22/tcp\s+ALLOW}) }
    its('stdout') { should match(%r{8080/tcp\s+ALLOW}) }
    its('stdout') { should match(%r{8081/udp\s+DENY}) }
  end
end
