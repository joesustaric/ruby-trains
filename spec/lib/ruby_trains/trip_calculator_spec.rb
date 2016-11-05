require 'spec_helper'
require 'ruby_trains/trip_calculator'
require 'ruby_trains/trip_calculators/shortest_route'

module RubyTrains
  # This test class exists only because I want to revise Rspec mocking / stubs
  # Idealy I would just keep these as high level tests to ensure happy/sad paths
  describe TripCalculator do

    describe '#new' do
      context 'Given a test network' do
        let(:test_network) { 'AB1 BC2' }
        let(:parsed_network) { %w(AB1 BC2) }
        before do
          allow(Validator).to receive(:parse_network).and_return parsed_network
        end

        it 'prases the network' do
          expect(Validator).to receive(:parse_network).with test_network
          TripCalculator.new test_network
        end
      end

      context 'Given a network parsing error' do
        before { allow(Validator).to receive(:parse_network).and_raise('boom') }

        it 'raises the input error' do
          expect { TripCalculator.new('anything') }.to raise_error('boom')
        end
      end
    end

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

        subject { TripCalculator.new test_network }

        it 'returns the calculated result' do
          expect(subject.execute_route_dist_calc(test_trip)).to be 99
        end
      end

      context 'Given invalid trip input' do
        let(:test_network) { 'AB1 BC2' }
        let(:parsed_network) { %w(AB1 BC2) }
        before do
          allow(Validator).to receive(:parse_network).and_return parsed_network
          allow(Validator).to receive(:parse_trip).and_raise('Pow!')
        end
        subject { TripCalculator.new test_network }

        it 'raises the input error' do
          expect { subject.execute_route_dist_calc('fooBar') }
            .to raise_error('Pow!')
        end
      end
      context 'Given a calculation error' do
        let(:test_network) { 'AB1 BC2' }
        let(:n) { TripCalculators::ShortestRoute.new %w(AB1 BC2) }

        before do
          allow(Validator).to receive(:parse_network).and_return test_network
          allow(Validator).to receive(:parse_trip).and_return %w(A B)
          allow(TripCalculators::ShortestRoute).to receive(:new).and_return n
          allow(n).to receive(:calculate).and_raise('Zomgs!')
        end
        subject { TripCalculator.new test_network }

        it 'raises the calc error' do
          expect { subject.execute_route_dist_calc('fooBar') }
            .to raise_error('Zomgs!')
        end
      end
    end
  end
end
