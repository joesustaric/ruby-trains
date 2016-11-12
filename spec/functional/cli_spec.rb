require 'spec_helper'
require 'ruby_trains/cli'

describe 'CLI' do
  include OutputCapture

  context 'Given a test network' do
    it 'returns the shortest route from A - C' do
      ARGV = ['-s A-C', 'AB5', 'BC4', 'CD8', 'DC8', 'DE6',
              'AD5', 'CE2', 'EB3', 'AE7'].freeze
      RubyTrains::CLI.run
      expect(stdout).to include '9'
    end
  end

end
