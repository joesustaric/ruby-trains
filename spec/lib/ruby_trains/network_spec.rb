require 'spec_helper'
require 'ruby_trains/network'

describe RubyTrains::Network do

  describe '#new' do

    context 'Given no network input' do

      context 'When we create the new network' do
        subject { RubyTrains::Network.new }

        it 'creates an empty network' do
          expect(subject.stations.size).to eq 0
        end
      end
    end

    context 'Given a single input (2 stations 1 connection)' do
      let(:input) { 'AB1' }

      context 'When we create the new network' do
        subject { RubyTrains::Network.new input }

        it 'creates the two stations' do
          expect(subject.stations.size).to eq 2
        end

        it 'adds the correct connection from station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 1
          expect(a_connections['B'].distance).to eq 1
        end

        it 'adds no connections from B' do
          a_connections = subject.stations['B'].connections
          expect(a_connections.size).to eq 0
        end
      end
    end

    context 'Given 2 stations with 1 connection each' do
      let(:input) { 'AB1 BC2' }

      context 'When we create the network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 3
        end

        it 'adds the correct connection from station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 1
          expect(a_connections['B'].distance).to eq 1
        end

        it 'adds the correct connection from station B' do
          b_connections = subject.stations['B'].connections
          expect(b_connections.size).to eq 1
          expect(b_connections['C'].distance).to eq 2
        end

        it 'adds no connections from C' do
          c_connections = subject.stations['C'].connections
          expect(c_connections.size).to eq 0
        end

      end
    end

    context 'Given a station with multiple connections' do
      let(:input) { 'AB1 BC2 AC3' }

      context 'When we create th network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 3
        end

        it 'adds the correct connections from station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 2
          expect(a_connections['B'].distance).to eq 1
          expect(a_connections['C'].distance).to eq 3
        end

        it 'adds the correct connection to station B' do
          b_connections = subject.stations['B'].connections
          expect(b_connections.size).to eq 1
          expect(b_connections['C'].distance).to eq 2
        end

        it 'adds no connections from C' do
          c_connections = subject.stations['C'].connections
          expect(c_connections.size).to eq 0
        end

      end
    end

    context 'Given more stations with more connections (complex)' do
      let(:input) { 'AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7' }

      context 'When we create the network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 5
        end

        it 'adds the correct connections from station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 3
          expect(a_connections['B'].distance).to eq 5
          expect(a_connections['D'].distance).to eq 5
          expect(a_connections['E'].distance).to eq 7
        end

        it 'adds the correct connection to station B' do
          b_connections = subject.stations['B'].connections
          expect(b_connections.size).to eq 1
          expect(b_connections['C'].distance).to eq 4
        end

        it 'adds no connections from C' do
          c_connections = subject.stations['C'].connections
          expect(c_connections.size).to eq 2
          expect(c_connections['D'].distance).to eq 8
          expect(c_connections['E'].distance).to eq 2
        end

        it 'adds the correct connection to station D' do
          d_connections = subject.stations['D'].connections
          expect(d_connections.size).to eq 2
          expect(d_connections['E'].distance).to eq 6
          expect(d_connections['C'].distance).to eq 8
        end

        it 'adds the correct connection to station D' do
          e_connections = subject.stations['E'].connections
          expect(e_connections.size).to eq 1
          expect(e_connections['B'].distance).to eq 3
        end

      end
    end

    context 'Given garbage input' do
      let(:input) { 'bl f f44ah blah24235 blah soethnigkdf ;jdf ' }

      context 'When we create the network' do
        subject { RubyTrains::Network.new input }

        it 'ignores all the garbage' do
          expect(subject.stations.size).to eq 0
        end

      end
    end

    context 'Given some garbage and some valid input' do
      let(:input) { 'asd AB1 BCsdf2 BC23 233n3nfl' }

      context 'When we create the network' do
        subject { RubyTrains::Network.new input }

        it 'creates all the correct stations' do
          expect(subject.stations.size).to eq 3
        end

        it 'adds the correct connection from station A' do
          a_connections = subject.stations['A'].connections
          expect(a_connections.size).to eq 1
        end

        it 'adds the correct connection from station B' do
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
