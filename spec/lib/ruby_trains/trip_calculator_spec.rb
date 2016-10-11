require 'spec_helper'
require 'ruby_trains/trip_calculator'
require 'ruby_trains/trip_calculators/shortest_route'

module RubyTrains
  # This test class exists only because I want to revise Rspec mocking / stubs
  # Idealy I would just keep these as high level tests to ensure happy/sad paths
  describe TripCalculator do
    describe '#execute_route_dist_calc' do
      context 'Given valid input and no calculation error' do
        let(:test_network) { 'AB1 BC2' }
        let(:parsed_network) { %w(AB1 BC2) }
        let(:parsed_trip) { %w(A B) }
        let(:test_trip) { 'A-B' }
        let(:network) { TripCalculators::ShortestRoute.new parsed_trip }

        before do
          allow(Validator).to receive(:parse_network).and_return parsed_network
          allow(Validator).to receive(:parse_trip).and_return parsed_trip
          allow(TripCalculators::ShortestRoute).to receive(:new).and_return network
          allow(network).to receive(:calculate).and_return 99
        end

        it 'parses the input' do
          expect(Validator).to receive(:parse_network).with test_network
          expect(Validator).to receive(:parse_trip).with test_trip
          TripCalculator.execute_route_dist_calc test_network, test_trip
        end

        it 'calculates and returns a result' do
          # don't care what the result is in this test
          expect(network).to receive(:calculate).with parsed_trip
          result = TripCalculator.execute_route_dist_calc test_network, test_trip
          expect(result).to be_truthy
        end
      end

      context 'Given a network parsing error' do
        before { allow(Validator).to receive(:parse_network).and_raise('boom') }

        it 'raises the input error' do
          expect { TripCalculator.execute_route_dist_calc('foobar', 'A-B') }
            .to raise_error('boom')
        end
      end
      context 'Given invalid trip input' do
        before { allow(Validator).to receive(:parse_trip).and_raise('Pow!') }

        it 'raises the input error' do
          expect { TripCalculator.execute_route_dist_calc('AB1', 'fooBar') }
            .to raise_error('Pow!')
        end
      end
      context 'Given a calculation error' do
        let(:n) { TripCalculators::ShortestRoute.new %w(AB1 BC2) }

        before do
          allow(Validator).to receive(:parse_network).and_return %w(AB1 BC2)
          allow(Validator).to receive(:parse_trip).and_return %w(A B)
          allow(TripCalculators::ShortestRoute).to receive(:new).and_return n
          allow(n).to receive(:calculate).and_raise('Zomgs!')
        end

        it 'raises the calc error' do
          expect { TripCalculator.execute_route_dist_calc('balh', 'fooBar') }
            .to raise_error('Zomgs!')
        end
      end
    end
  end
end
