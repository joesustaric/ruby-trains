require 'spec_helper'
require 'ruby_trains/my_class'

describe RubyTrains::MyClass do
  describe '#say_hello' do
    it 'says Hello' do
      expect(subject.say_hello).to eq('Hello World')
    end
  end
end
