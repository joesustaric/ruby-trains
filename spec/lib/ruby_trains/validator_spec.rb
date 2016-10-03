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
      context 'When given a simple trip' do
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

    describe '#parse_route' do
      context 'When given a simple route' do
        let(:input) { 'A-B ' }
        let(:result) { %w(A B) }

        it { expect(Validator.parse_route(input)).to eq result }
      end

      context 'When given a simple multiple route' do
        let(:input) { 'A-B-C ' }
        let(:result) { %w(A B C) }

        it { expect(Validator.parse_route(input)).to eq result }
      end

      context 'When given a multinamed multiple route' do
        let(:input) { 'Foo-Bar-Z ' }
        let(:result) { %w(Foo Bar Z) }

        it { expect(Validator.parse_route(input)).to eq result }
      end

      context 'When given a longer multinamed multiple route' do
        let(:input) { 'Foo-Bar-Z-Y-Joe-Huh-Waa-X ' }
        let(:result) { %w(Foo Bar Z Y Joe Huh Waa X) }

        it { expect(Validator.parse_route(input)).to eq result }
      end

      context 'When given no input' do
        it { expect(Validator.parse_route('')).to eq [] }
      end

      context 'When given garbage input' do
        it { expect(Validator.parse_route('asd..fvadA-B-Csva?sdf')).to eq [] }
      end

    end
  end
end
