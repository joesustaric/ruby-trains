require 'spec_helper'
require 'ruby_trains/trip_calculators/number_of_routes_distance'

module RubyTrains
  module TripCalculators
    describe NumberOfRoutesDistance do

      describe '#calculate' do

        context 'Given a basic network ' do
          let(:network) { Network.new %w(AB1 BC2) }
          let(:subject) { NumberOfRoutesDistance.new network }

          context 'When we calculate number of trips between 2 different stations'\
                  ' with a max distance < limit' do
            let(:trip) { %w(A C) }
            let(:max_dist) { 4 }
            let(:expected) { 1 }

            it 'returns the correct number' do
              expect(subject.calculate(trip, max_dist)).to eq expected
            end
          end
        end

        context 'Given a simple network with multiple routes' do
          let(:network) { Network.new %w(AB1 BC2 AD4 DC3 AC2) }
          let(:subject) { NumberOfRoutesDistance.new network }

          context 'When we calculate 2 diff stations & max stops < limit' do
            let(:trip) { %w(A C) }
            let(:max_dist) { 4 }
            let(:expected) { 2 }

            it 'returns the correct number' do
              expect(subject.calculate(trip, max_dist)).to eq expected
            end

          end
        end

        context 'Given a more complex network' do
          let(:input) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }
          let(:network) { Network.new input }
          let(:subject) { NumberOfRoutesDistance.new network }

          context 'When we calculate number of trips between the same station'\
                  ' with a max stops < limit' do
            let(:trip) { %w(C C) }
            let(:max_dist) { 30 }
            let(:expected) { 7 }

            it 'returns the correct number' do
              expect(subject.calculate(trip, max_dist)).to eq expected
            end
          end
        end
      end
    end
  end
end
