require 'spec_helper'
describe 'zoneminder' do
  context 'with default values for all parameters' do
    it { should contain_class('zoneminder') }
  end
end
