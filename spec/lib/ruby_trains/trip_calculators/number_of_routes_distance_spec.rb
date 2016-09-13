require 'spec_helper'
require 'ruby_trains/trip_calculators/number_of_routes_distance'

module RubyTrains
  module TripCalculators
    describe NumberOfRoutesDistance do

      describe '#calculate' do

        context 'Given a basic network ' do
          let(:network) { Network.new 'AB1 BC2' }

          context 'When we calculate number of trips between 2 different stations'\
                  ' with a max distance < limit' do
            let(:trip) { 'A-C' }
            let(:max_dist) { 3 }
            let(:expected) { 1 }

            it 'returns the correct number' do
              result = NumberOfRoutesDistance.calculate(network, trip, max_dist)
              expect(result).to eq expected
            end

          end

        end
      end
    end
  end
end
