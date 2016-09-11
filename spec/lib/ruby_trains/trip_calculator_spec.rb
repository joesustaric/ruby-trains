require 'spec_helper'
require 'ruby_trains/trip_calculator'

module RubyTrains
  describe TripCalculator do

    describe '#route_distance' do

      context 'Given a blank trip and a non empty network' do
        let(:simple_network) { Network.new 'AB1 BC2' }
        let(:empty_trip) { '' }

        context 'When we ask from the route distance' do
          let(:expected) { -1 }

          it 'returns -1' do
            result = TripCalculator.route_distance simple_network, empty_trip
            expect(result).to eq expected
          end
        end
      end

      context 'Given a non empty trip and an empty network' do
        let(:simple_network) { Network.new }
        let(:trip) { 'A-B-C' }

        context 'When we ask from the route distance' do
          let(:expected) { -1 }

          it 'returns -1' do
            result = TripCalculator.route_distance simple_network, trip
            expect(result).to eq expected
          end
        end
      end

      context 'Given a simple network' do
        let(:simple_network) { Network.new 'AB1 BC2' }

        context 'When we ask for a simple trip distance' do
          let(:expected) { 3 }
          let(:test_trip) { 'A-B-C' }

          it 'returns the correct distance' do
            result = TripCalculator.route_distance(simple_network, test_trip)
            expect(result).to eq expected
          end

        end
      end

      context 'Given a complex network' do
        let(:input) { 'AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7' }
        let(:network) { Network.new input }

        context 'When we ask for a simple journey distance' do
          let(:expected) { 5 }
          let(:test_route) { 'A-B' }

          it 'returns the correct distance' do
            expect(TripCalculator.route_distance(network, test_route)).to eq expected
          end
        end

        context 'When we ask for a more complicated journey distance' do
          let(:expected) { 22 }
          let(:test_route) { 'A-E-B-C-D' }

          it 'returns the correct distance' do
            expect(TripCalculator.route_distance(network, test_route)).to eq expected
          end

        end

      end
    end

  end
end
