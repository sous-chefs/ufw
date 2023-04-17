#
# Author:: Matt Ray <matt@chef.io>
# Cookbook:: ufw
# Recipe:: default
#
# Copyright:: 2011-2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

firewall 'default' do
  action :install
end

# leave this on by default
firewall_rule 'ssh' do
  port 22
  action :create
  only_if { node['firewall']['allow_ssh'] }
end

# handle rules specified as array or as hash
rules = {}
if node['firewall']['rules'].is_a?(Array)
  node['firewall']['rules'].each do |rule_mash|
    rule_mash.each_key do |rule|
      rules[rule] = rule_mash[rule]
    end
  end
elsif node['firewall']['rules'].is_a?(Hash)
  rules = node['firewall']['rules']
end

rules.each_key do |rule|
  Chef::Log.debug "ufw:rule:name \"#{rule}\""
  params = rules[rule]
  Chef::Log.debug "ufw:rule:parameters \"#{params}\""
  Chef::Log.debug "ufw:rule:name #{params['name']}" if params['name']
  Chef::Log.debug "ufw:rule:protocol #{params['protocol']}" if params['protocol']
  Chef::Log.debug "ufw:rule:direction #{params['direction']}" if params['direction']
  Chef::Log.debug "ufw:rule:interface #{params['interface']}" if params['interface']
  Chef::Log.debug "ufw:rule:logging #{params['logging']}" if params['logging']
  Chef::Log.debug "ufw:rule:port #{params['port']}" if params['port']
  Chef::Log.debug "ufw:rule:port_range #{params['port_range']}" if params['port_range']
  Chef::Log.debug "ufw:rule:source #{params['source']}" if params['source']
  Chef::Log.debug "ufw:rule:destination #{params['destination']}" if params['destination']
  Chef::Log.debug "ufw:rule:dest_port #{params['dest_port']}" if params['dest_port']
  Chef::Log.debug "ufw:rule:position #{params['position']}" if params['position']
  act = params['action']
  act ||= 'create'
  raise 'ufw: port_range was specified to firewall_rule without protocol' if params['port_range'] && !params['protocol']
  Chef::Log.debug "ufw:rule:action :#{act}"
  firewall_rule rule do
    firewall_name params['name'] if params['name']
    protocol params['protocol'].to_sym if params['protocol']
    direction params['direction'].to_sym if params['direction']
    interface params['interface'] if params['interface']
    logging params['logging'].to_sym if params['logging']
    port params['port'].to_i if params['port']
    if params['port_range']
      ends = params['port_range'].split('..').map { |d| Integer(d) }
      port ends[0]..ends[1]
    end
    source params['source'] if params['source']
    destination params['destination'] if params['destination']
    dest_port params['dest_port'].to_i if params['dest_port']
    position params['position'].to_i if params['position']
    action act
  end
end
