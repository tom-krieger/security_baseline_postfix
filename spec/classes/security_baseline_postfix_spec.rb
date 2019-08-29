require 'spec_helper'

describe 'security_baseline_postfix' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'enforce' => true,
          'message' => 'selinux',
          'loglevel' => 'warning',
          'config_data' => {
            'inet_interfaces' => 'loopback-only',
          }
        } 
      end

      it { is_expected.to compile }
    end
  end
end
