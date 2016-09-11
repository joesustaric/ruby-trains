require 'spec_helper'
require 'ruby_trains/trip_calculators/number_of_trips'

module RubyTrains
  module TripCalculators
    describe NumberOfTrips do

      describe '#number_of_trips' do

        context 'Given a basic network' do
          let(:network) { Network.new 'AB1 BC2' }

          context 'When we calculate number of trips between 2 different stations' do
            let(:trip) { 'A-C' }
            let(:max_stops) { 2 }
            let(:expected) { 1 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops)
              expect(result).to eq expected
            end

          end

          context 'When we try to calculate a garbage trip' do
            let(:trip) { 'FooBar3095uijreglkn' }
            let(:max_stops) { 2 }
            let(:expected) { -1 }

            it 'returns NO_ROUTE' do
              result = NumberOfTrips.calculate(network, trip, max_stops)
              expect(result).to eq expected
            end
          end
        end

        context 'Given a simple network with multiple routes' do
          let(:network) { Network.new 'AB1 BC2 AD4 DC3' }

          context 'When we calculate with 2 diff stations & max stops=1' do
            let(:trip) { 'A-C' }
            let(:max_stops) { 2 }
            let(:expected) { 2 }

            it 'returns the correct number' do
              result = NumberOfTrips.calculate(network, trip, max_stops)
              expect(result).to eq expected
            end

          end
        end

        # context 'Given a more complex network' do
        #
        #   context 'When we ask for number of trips between 2 different stations' do
        #
        #     it 'returns the correct number' do
        #
        #     end
        #   end
        # end

      end

    end
  end
end
