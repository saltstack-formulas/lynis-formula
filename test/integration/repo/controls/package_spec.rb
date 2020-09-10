# frozen_string_literal: true

control 'Lynis package' do
  title 'should be installed'

  describe package('lynis') do
    it { should be_installed }
  end
end
