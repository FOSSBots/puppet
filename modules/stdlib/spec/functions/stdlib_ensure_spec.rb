require 'spec_helper'

describe 'stdlib::ensure' do
  context 'work with service resource' do
    it { is_expected.to run.with_params('present', 'service').and_return('running') }
    it { is_expected.to run.with_params(true, 'service').and_return('running') }
    it { is_expected.to run.with_params('absent', 'service').and_return('stopped') }
    it { is_expected.to run.with_params(false, 'service').and_return('stopped') }
  end
  ['directory', 'link', 'mounted', 'file'].each do |resource|
    context "work with #{resource} resource" do
      it { is_expected.to run.with_params('present', resource).and_return(resource) }
      it { is_expected.to run.with_params(true, resource).and_return(resource) }
      it { is_expected.to run.with_params('absent', resource).and_return('absent') }
      it { is_expected.to run.with_params(false, resource).and_return('absent') }
    end
  end
end
