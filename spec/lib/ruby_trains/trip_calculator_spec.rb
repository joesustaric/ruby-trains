require 'spec_helper'
require 'ruby_trains/trip_calculator'

module RubyTrains
  describe TripCalculator do

    describe '#route_distance' do

      context 'Given a garbage trip input and a non empty network' do
        let(:simple_network) { Network.new 'AB1 BC2' }
        let(:empty_trip) { 'asdva28hfnwico43oie' }

        context 'When we ask from the route distance' do
          let(:expected) { -1 }

          it 'returns -1' do
            result = TripCalculator.route_distance simple_network, empty_trip
            expect(result).to eq expected
          end
        end
      end

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

    describe '#number_of_trips' do

      context 'Given a basic network' do
        let(:network) { Network.new 'AB1 BC2' }

        context 'When we ask for number of trips between 2 different stations' do
          let(:trip) { 'A-C' }
          let(:max_stops) { 2 }
          let(:expected) { 1 }

          it 'returns the correct number' do
            result = TripCalculator.number_of_trips(network, trip, max_stops)
            expect(result).to eq expected
          end

        end

        context 'When we give it a garbage trip' do
          let(:trip) { 'FooBar3095uijreglkn' }
          let(:max_stops) { 2 }
          let(:expected) { -1 }

          it 'returns NO_ROUTE' do
            result = TripCalculator.number_of_trips(network, trip, max_stops)
            expect(result).to eq expected
          end
        end
      end

      context 'Given a simple network with multiple routes' do
        let(:network) { Network.new 'AB1 BC2 AD4 DC3' }

        context 'When we ask for # trips, with 2 diff stations & max stops=1' do
          let(:trip) { 'A-C' }
          let(:max_stops) { 2 }
          let(:expected) { 2 }

          it 'returns the correct number' do
            result = TripCalculator.number_of_trips(network, trip, max_stops)
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
