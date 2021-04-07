require_relative '../../../../rake_modules/spec_helper'

describe 'systemd::unit' do
  on_supported_os(WMFConfig.test_on).each do |os, facts|
    context "On #{os}" do
      let(:title) { 'dummyservice' }
      let(:facts) { facts.merge({initsystem: 'systemd'}) }
      let(:params) do
        {
          ensure: 'present',
          content: 'dummy'
        }
      end

      context 'when initsystem is unknown' do
        let(:facts) { super().merge({ :initsystem => 'unknown' }) }
        it { is_expected.to compile.and_raise_error(/You can only use systemd resources on systems with systemd/) }
      end

      context 'when the corresponding service is defined (implicit name)' do
        let(:pre_condition) { "service { 'foobar': ensure => running, provider => 'systemd'}" }
        let(:title) { 'foobar' }
        it { is_expected.to compile }
        it do
          is_expected.to contain_exec('systemd daemon-reload for foobar.service')
                           .that_comes_before('Service[foobar]')
        end
        context 'when managing the service restarts' do
          let(:params) { super().merge(restart: true) }

          it { is_expected.to compile }
          it do
            is_expected.to contain_exec('systemd daemon-reload for foobar.service')
                             .that_notifies('Service[foobar]')
          end
        end
      end

      context 'when using dummy parameters and a name without type' do
        it { is_expected.to compile }

        describe 'then the systemd service' do
          it 'should define a unit file in the system directory' do
            is_expected.to contain_file('/lib/systemd/system/dummyservice.service')
                             .with_content('dummy')
                             .that_notifies(
                               "Exec[systemd daemon-reload for dummyservice.service]"
                             )
          end

          it 'should contain a systemctl-reload exec' do
            is_expected.to contain_exec('systemd daemon-reload for dummyservice.service')
                             .with_refreshonly(true)
          end
        end
      end

      context 'when the title includes the unit type and is an override' do
        let(:params) { super().merge(override: true) }
        let(:title) { 'usbstick.device' }

        it { is_expected.to compile }
        it 'should define the parent directory of the override file' do
          is_expected.to contain_file('/etc/systemd/system/usbstick.device.d')
                           .with_ensure('directory')
                           .with_owner('root')
                           .with_group('root')
                           .with_mode('0555')
        end
        it 'should define the systemd override file' do
          is_expected.to contain_file('/etc/systemd/system/usbstick.device.d/puppet-override.conf')
                           .with_ensure('present')
                           .with_mode('0444')
                           .with_owner('root')
                           .with_group('root')
        end
        it 'should contain a systemctl-reload exec' do
          is_expected.to contain_exec('systemd daemon-reload for usbstick.device')
                           .with_refreshonly(true)
        end
      end
    end
  end
end
