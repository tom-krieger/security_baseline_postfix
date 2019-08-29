# frozen_string_literal: true

# mta_service.rb
# Check if mta services is enabled

Facter.add('srv_mta') do
  confine :osfamily => 'Linux'
  setcode do
    Facter::Core::Execution.exec('netstat -an | grep LIST | grep ":25[[:space:]]"')
  end
end
  