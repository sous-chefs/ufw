# frozen_string_literal: true

ufw_firewall 'default' do
  rules(
    [
      { 'web' => { 'port' => '8080' } },
      { 'deny-udp' => { 'port' => '8081', 'protocol' => 'udp', 'action' => 'deny' } },
    ]
  )
  action :create
end
