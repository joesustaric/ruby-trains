require 'spec_helper'
require 'ruby_trains/network'

describe RubyTrains::Network do

  describe '#new' do

    context 'Given no network input' do

      context 'When we create a new network' do
        subject { RubyTrains::Network.new }

        it 'creates an empty network' do
          expect(subject.stations.size).to eq 0
        end
      end
    end

    context 'Given a single input (1 station 1 connection)' do
      let(:input) { 'AB1' }

      context 'When we create a new network' do
        subject { RubyTrains::Network.new input }

        it 'creates the two stations' do
          expect(subject.stations.size).to eq 2
        end

        it 'adds the correct connection to station A' do
          connections = subject.stations['A'].connections
          expect(connections.size).to eq 1
        end
      end
    end
  end
end
