require 'spec_helper'
require 'ruby_trains/trip_calculators/route_distance'

module RubyTrains
  module TripCalculators
    describe RouteDistance do

      describe '#calculate' do

        context 'Given a simple network' do
          let(:simple_network) { Network.new %w(AB1 BC2) }
          let(:subject) { RouteDistance.new simple_network }

          context 'When we calculate a simple route distance' do
            let(:expected) { 3 }
            let(:test_route) { %w(A B C) }

            it 'returns the correct distance' do
              expect(subject.calculate(test_route)).to eq expected
            end

          end
        end

        context 'Given a complex network' do
          let(:input) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }
          let(:network) { Network.new input }
          let(:subject) { RouteDistance.new network }

          context 'When we calculate a simple route distance' do
            let(:expected) { 5 }
            let(:test_route) { %w(A B) }

            it 'returns the correct distance' do
              expect(subject.calculate(test_route)).to eq expected
            end
          end

          context 'When we try to calculate a route that does not exist' do
            let(:test_route) { %w(A C) }
            let(:expected) { 'connection error' }

            it 'raises a connection error' do
              expect { subject.calculate(test_route) }.to raise_error expected
            end
          end

          context 'When we calculate a more complicated route distance' do
            let(:expected) { 22 }
            let(:test_route) { %w(A E B C D) }

            it 'returns the correct distance' do
              expect(subject.calculate(test_route)).to eq expected
            end

          end

        end
      end

    end
  end
end
