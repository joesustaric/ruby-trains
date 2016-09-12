require 'spec_helper'
require 'ruby_trains/trip_calculators/shortest_route'

module RubyTrains
  module TripCalculators
    describe ShortestRoute do

      describe '#calculate' do

        context 'Given a basic network' do
          let(:network) { Network.new 'AB1 BC2' }

          context 'When we ask for the shortest path between 2 stations' do
            let(:trip) { 'A-C' }
            let(:expected) { 3 }

            it 'returns the sum of the shortest route' do
              expect(ShortestRoute.calculate(network, trip)).to eq expected
            end
          end

        end

        context 'Given a simple network with multiple routes to destination' do
          let(:network) { Network.new 'AB1 BC2 AD1 DC1' }

          context 'When we ask for the shortest path between 2 stations' do
            let(:trip) { 'A-C' }
            let(:expected) { 2 }

            it 'returns the sum of the shortest route' do
              expect(ShortestRoute.calculate(network, trip)).to eq expected
            end
          end

        end
      end
    end
  end
end
