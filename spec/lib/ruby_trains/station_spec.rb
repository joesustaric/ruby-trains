require 'spec_helper'
require 'ruby_trains/station'

describe RubyTrains::Station do

  describe '#new' do

    context 'Given a valid single character station name' do

      let(:valid_station_name) { 'a' }
      subject { RubyTrains::Station.new valid_station_name }

      context 'When we create a new station' do
        it 'assigns the correct name' do
          expect(subject.name).to eq valid_station_name
        end
        it 'initalises connections to nothing' do
          expect(subject.connections.size).to eq 0
        end
      end

    end

    context 'Given a invalid names' do
      context 'When we create a new station' do
      end
    end

  end

end
