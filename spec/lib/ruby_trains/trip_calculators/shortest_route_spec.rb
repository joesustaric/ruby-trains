require 'spec_helper'
require 'ruby_trains/trip_calculators/shortest_route'

module RubyTrains
  module TripCalculators
    describe ShortestRoute do

      describe '#calculate' do

        context 'Given a basic network' do
          let(:network) { Network.new %w(AB1 BC2) }
          let(:subject) { ShortestRoute.new network }

          context 'When we ask for the shortest path between 2 stations' do
            let(:trip) { %w(A C) }
            let(:expected) { 3 }

            it 'returns the sum of the shortest route' do
              expect(subject.calculate(trip)).to eq expected
            end
          end

        end

        context 'Given a simple network with multiple routes to destination' do
          let(:network) { Network.new %w(AB1 BC2 AD1 DC1) }
          let(:subject) { ShortestRoute.new network }

          context 'When we ask for the shortest path between 2 stations' do
            let(:trip) { %w(A C) }
            let(:expected) { 2 }

            it 'returns the sum of the shortest route' do
              expect(subject.calculate(trip)).to eq expected
            end
          end

        end

        context 'Given a more complicated network' do
          let(:input) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }
          let(:network) { Network.new input }
          let(:subject) { ShortestRoute.new network }

          context 'When we ask for the shortest path between 2 diff stations' do
            let(:trip) { %w(A C) }
            let(:expected) { 9 }

            it 'returns the sum of the shortest route' do
              expect(subject.calculate(trip)).to eq expected
            end
          end

          context 'When we ask for the shortest path between same station' do
            let(:trip) { %w(B B) }
            let(:expected) { 9 }

            it 'returns the sum of the shortest route' do
              expect(subject.calculate(trip)).to eq expected
            end
          end
        end

        context 'Given a network with a station that cannot be travelled to' do
          context 'When we ask for the shortest distance between two ' \
                  'stations that cannot be reached' do
            it 'throws some kind of error' do
            end
          end
        end

      end
    end
  end
end
