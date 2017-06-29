#
# Author:: Matt Ray <matt@chef.io>
# Cookbook:: ufw
# Recipe:: databag
#
# Copyright:: 2011-2017, Chef Software, Inc.
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

raise 'ufw::databag and ufw::recipes were both found in the run list - only one may be used' if node.recipe?('ufw::recipes')

# flatten the run_list to just the names of the roles and recipes in order
def run_list_names(run_list)
  names = []
  run_list.each do |entry|
    Chef::Log.debug "ufw::databag:run_list_names+name: #{entry.name}"
    if entry.name.index('::') # cookbook::recipe
      names.push(entry.name.sub('::', '__'))
    else
      names.push(entry.name)
    end
    if entry.role?
      rol = search(:role, "name:#{entry.name}")[0]
      names.concat(run_list_names(rol.run_list))
    end
  end
  Chef::Log.debug "ufw::databag:run_list_names+names: #{names}"
  names
end

rlist = run_list_names(node.run_list)
rlist.uniq!
Chef::Log.debug "ufw::databag:rlist: #{rlist}"

fw_db = data_bag('firewall')
Chef::Log.debug "ufw::databag:firewall:#{fw_db}"

desired_rules = []
rlist.each do |entry|
  Chef::Log.debug "ufw::databag: \"#{entry}\""
  next unless fw_db.member?(entry)

  item = data_bag_item('firewall', entry)
  rules = item['rules']
  desired_rules.concat(rules) unless rules.nil?
end
node.normal['firewall']['rules'] = desired_rules.uniq

# now go apply the rules
include_recipe 'ufw::default'
