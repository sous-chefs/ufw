# frozen_string_literal: true

def ufw_status_output
  command('ufw status').stdout
end
