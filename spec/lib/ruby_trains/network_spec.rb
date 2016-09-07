require 'spec_helper'
require 'ruby_trains/network'

describe RubyTrains::Network do

  describe '#new' do

    context 'Given no network input' do
      subject { RubyTrains::Network.new }

      context 'When we create a new network' do
        it 'creates an empty network' do
          expect(subject.stations.size).to eq 0
        end
      end
    end

  end
end
