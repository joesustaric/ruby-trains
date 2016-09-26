require 'spec_helper'
require 'ruby_trains/trip_calculators/number_of_trips'

module RubyTrains
  module TripCalculators
    describe NumberOfTrips do

      describe '#calculate' do

        context 'Given a basic network ' do
          let(:network) { Network.new %w(AB1 BC2) }

          context 'When we calculate number of trips between 2 different stations'\
                  ' with a max stops <= limit' do
            let(:trip) { 'A-C' }
            let(:max_stops) { 2 }
            let(:expected) { 1 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops, false)
              expect(result).to eq expected
            end

          end

          context 'When we try to calculate a garbage trip' do
            let(:trip) { 'FooBar3095uijreglkn' }
            let(:max_stops) { 2 }
            let(:expected) { -1 }

            it 'returns ERROR' do
              result = NumberOfTrips.calculate(network, trip, max_stops, false)
              expect(result).to eq expected
            end
          end
        end

        context 'Given a simple network with multiple routes' do
          let(:network) { Network.new %w(AB1 BC2 AD4 DC3) }

          context 'When we calculate 2 diff stations & max stops <= limit' do
            let(:trip) { 'A-C' }
            let(:max_stops) { 2 }
            let(:expected) { 2 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops, false)
              expect(result).to eq expected
            end

          end
        end

        context 'Given a more complex network' do
          let(:input) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }
          let(:network) { Network.new input }

          context 'When we ask for number of trips between the same station'\
                  ' with a max stops <= limit' do
            let(:trip) { 'C-C' }
            let(:max_stops) { 3 }
            let(:expected) { 2 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops, false)
              expect(result).to eq expected
            end
          end

          context 'When we ask for number of trips between different stations'\
                  ' with a max stops == limit' do
            let(:trip) { 'A-C' }
            let(:max_stops) { 4 }
            let(:expected) { 3 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops, true)
              expect(result).to eq expected
            end
          end
        end

      end

    end
  end
end
