require 'spec_helper'
require 'ruby_trains/cli'

describe 'CLI' do

  context 'testing executing command line' do

    it 'does something' do
      r = `bin/ruby-trains joe`
      expect(r).to include 'hi joe'
    end
  end

end
