require 'spec_helper'
require 'ruby_trains/validator'

module RubyTrains
  describe Validator do

    describe '#parse_network' do
      context 'When given a simple network input' do
        let(:input) { ' AB5 ' }
        let(:result) { %w(AB5) }

        it { expect(Validator.parse_network(input)).to eq result }
      end

      context 'When given more complex netowrk input' do
        let(:input) { 'AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7' }
        let(:result) { %w(AB5 BC4 CD8 DC8 DE6 AD5 CE2 EB3 AE7) }

        it { expect(Validator.parse_network(input)).to eq result }
      end
      context 'When given some valid input then garbage' do
        let(:input) { 'AB1 BC3 sdhchdb cbdhbc chdb asdfhasd HV3' }
        let(:result) { %w(AB1 BC3) }

        it { expect(Validator.parse_network(input)).to eq result }
      end
      context 'When given garbage / random input' do
        let(:input) { 'sd jn sAB4jfdh akjsdhf ' }

        it { expect(Validator.parse_network(input)).to eq [] }
      end
      context 'When given no input' do
        let(:input) { '' }

        it { expect(Validator.parse_network(input)).to eq [] }
      end
    end

    describe '#parse_trip' do
      context 'When given a simple route' do
        let(:input) { 'A-B ' }
        let(:result) { %w(A B) }

        it { expect(Validator.parse_trip(input)).to eq result }
      end

      context 'When given no input' do
        let(:input) { '' }

        it { expect(Validator.parse_trip(input)).to eq [] }
      end
      context 'When given incomplete input' do
        let(:input) { 'C-' }

        it { expect(Validator.parse_trip(input)).to eq [] }
      end
    end
  end
end
