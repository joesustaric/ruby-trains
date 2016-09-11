require 'spec_helper'
require 'ruby_trains/connection'
require 'ruby_trains/station'

module RubyTrains
  describe Connection do

    describe '#new' do

      context 'Given an new station with no connections' do
        let(:new_station) { Station.new 'a' }
        let(:distance) { 5 }

        context 'When we create a new connection' do
          subject { Connection.new new_station, distance }

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
end
