require 'spec_helper'
require 'ruby_trains/connection'
require 'ruby_trains/station'

describe RubyTrains::Connection do

  describe '#new' do

    context 'Given an new station with no connections' do
      let(:new_station) { RubyTrains::Station.new 'a' }
      let(:distance) { 5 }
      subject { RubyTrains::Connection.new new_station, distance }

      context 'When we create a new connection' do
        it 'assigns the correct station as the destination' do
          expect(subject.station).to eq new_station
        end
        it 'assignes the correct distance' do
          expect(subject.distance).to eq distance
        end
      end

    end
  end
end
