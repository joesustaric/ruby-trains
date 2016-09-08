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

    context 'Given a single input (2 stations 1 connection)' do
      let(:input) { 'AB1' }

      context 'When we create a new network' do
        subject { RubyTrains::Network.new input }

        it 'creates the two stations' do
          expect(subject.stations.size).to eq 2
        end

        it 'adds the correct connection to station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 1
        end

        it 'adds no connections from B' do
          a_connections = subject.stations['B'].connections
          expect(a_connections.size).to eq 0
        end
      end
    end

    context 'Given 2 stations with 1 connection each' do
      let(:input) { 'AB1 BC2' }

      context 'When we create a network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 3
        end

        it 'adds the correct connection to station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 1
        end

        it 'adds the correct connection to station B' do
          b_connections = subject.stations['B'].connections
          expect(b_connections.size).to eq 1
        end

        it 'adds no connections from C' do
          c_connections = subject.stations['C'].connections
          expect(c_connections.size).to eq 0
        end

      end
    end

    context 'Given a station with multiple connections' do
      let(:input) { 'AB1 BC2 AC3' }

      context 'When we create a network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 3
        end

        it 'adds the correct connection to station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 2
        end

        it 'adds the correct connection to station B' do
          b_connections = subject.stations['B'].connections
          expect(b_connections.size).to eq 1
        end

        it 'adds no connections from C' do
          c_connections = subject.stations['C'].connections
          expect(c_connections.size).to eq 0
        end

      end
    end
  end

end
