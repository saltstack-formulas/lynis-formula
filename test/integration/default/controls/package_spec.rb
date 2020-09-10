# frozen_string_literal: true

control 'Lynis git sources' do
  title 'should be installed'

  describe directory('/usr/local/lynis') do
    it { should exist }
  end
end
