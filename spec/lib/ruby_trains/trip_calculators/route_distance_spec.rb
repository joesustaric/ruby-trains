require 'spec_helper'
require 'ruby_trains/trip_calculators/route_distance'

module RubyTrains
  module TripCalculators
    describe RouteDistance do

      describe '#calculate' do

        context 'Given a garbage trip input and a non empty network' do
          let(:simple_network) { Network.new %w(AB1 BC2) }
          let(:empty_trip) { 'asdva28hfnwico43oie' }

          context 'When we calculate the route distance' do
            let(:expected) { -1 }

            it 'returns ERROR' do
              result = RouteDistance.calculate simple_network, empty_trip
              expect(result).to eq expected
            end
          end
        end

        context 'Given a blank trip and a non empty network' do
          let(:simple_network) { Network.new %w(AB1 BC2) }
          let(:empty_trip) { '' }

          context 'When we calculate the route distance' do
            let(:expected) { -1 }

            it 'returns ERROR' do
              result = RouteDistance.calculate simple_network, empty_trip
              expect(result).to eq expected
            end
          end
        end

        context 'Given a non empty trip and an empty network' do
          let(:simple_network) { Network.new }
          let(:trip) { 'A-B-C' }

          context 'When we calculate the route distance' do
            let(:expected) { -1 }

            it 'returns ERROR' do
              result = RouteDistance.calculate simple_network, trip
              expect(result).to eq expected
            end
          end
        end

        context 'Given a simple network' do
          let(:simple_network) { Network.new %w(AB1 BC2) }

          context 'When we calculate a simple route distance' do
            let(:expected) { 3 }
            let(:test_trip) { 'A-B-C' }

            it 'returns the correct distance' do
              result = RouteDistance.calculate(simple_network, test_trip)
              expect(result).to eq expected
            end

          end
        end

        context 'Given a complex network' do
          let(:input) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }
          let(:network) { Network.new input }

          context 'When we calculate a simple route distance' do
            let(:expected) { 5 }
            let(:test_route) { 'A-B' }

            it 'returns the correct distance' do
              expect(RouteDistance.calculate(network, test_route)).to eq expected
            end
          end

          context 'When we calculate a more complicated route distance' do
            let(:expected) { 22 }
            let(:test_route) { 'A-E-B-C-D' }

            it 'returns the correct distance' do
              expect(RouteDistance.calculate(network, test_route)).to eq expected
            end

          end

        end
      end

    end
  end
end
