require 'spec_helper'
require 'ruby_trains/station'

module RubyTrains
  describe Station do

    describe '#new' do

      context 'Given a valid single character station name' do
        let(:valid_station_name) { 'a' }

        context 'When we create a new station' do
          subject { Station.new valid_station_name }

          it 'assigns the correct name' do
            expect(subject.name).to eq valid_station_name
          end
          it 'initalises connections to nothing' do
            expect(subject.connections.size).to eq 0
          end
        end

      end
    end

    describe '#add_connection' do

      subject { Station.new 'foo' }

      context 'Given a connection' do
        let(:station) { Station.new 'bar' }
        let(:connection) { Connection.new station, 5 }

        context 'When we add it to the station' do
          before { subject.add_connection connection }

          it 'adds the connection' do
            expect(subject.connections.size).to eq 1
            expect(subject.connections[station.name]).to eq connection
          end
        end
      end
    end
  end
end
