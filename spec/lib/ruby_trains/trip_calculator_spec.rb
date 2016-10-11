require 'spec_helper'
require 'ruby_trains/trip_calculator'
require 'ruby_trains/trip_calculators/shortest_route'

module RubyTrains
  # This test class exists only because I want to revise Rspec mocking
  # Idealy I would just keep these as high level tests to ensure happy/sad paths
  describe TripCalculator do
    describe '#execute_route_dist_calc' do
      context 'Given valid input and no calculation error' do
        let(:parsed_network) { %w(AB1) }
        let(:parsed_trip) { %w(A B) }
        let(:test_network) { 'AB1' }
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
          expect(network).to receive(:calculate).with parsed_trip
          result = TripCalculator.execute_route_dist_calc test_network, test_trip
          expect(result).to eq 99
        end

        it 'calculates the route distance' do
        end
      end

      context 'Given invalid network input' do

        it 'raises an input error' do
        end
      end
      context 'Given invalid trip input' do

        it 'raises an input error' do
        end
      end
      context 'Given a calculation error' do

        it 'raises the calc error' do
        end
      end
    end
  end
end
