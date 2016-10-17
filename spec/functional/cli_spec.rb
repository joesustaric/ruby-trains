require 'spec_helper'
require 'ruby_trains/cli'

describe 'CLI' do
  include OutputCapture

  context 'testing getting the code coverage working' do
    it 'does another thing' do
      ARGV = ['joe'].freeze
      RubyTrains::CLI.run
      expect(stdout).to include 'hi joe'
    end
  end

end
