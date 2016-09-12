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

        context 'Given a more complicated network' do
          let(:input) { 'AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7' }
          let(:network) { Network.new input }

          context 'When we ask for the shortest path between 2 diff stations' do
            let(:trip) { 'A-C' }
            let(:expected) { 9 }

            it 'returns the sum of the shortest route' do
              expect(ShortestRoute.calculate(network, trip)).to eq expected
            end
          end

          context 'When we ask for the shortest path between same station' do
            let(:trip) { 'B-B' }
            let(:expected) { 9 }

            it 'returns the sum of the shortest route' do
              expect(ShortestRoute.calculate(network, trip)).to eq expected
            end
          end
        end

      end
    end
  end
end
