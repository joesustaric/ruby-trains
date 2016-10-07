require 'clamp'

module RubyTrains
  # Doco
  class CLI < Clamp::Command
    option '--loud', :flag, 'say it loud'
    option ['-n', '--iterations'], 'N', 'say it N times', default: 1 do |s|
      Integer(s)
    end

    parameter 'NAME ...', 'who to say hello to', attribute_name: :words

    def execute
      the_name = words.join(' ')
      the_name.upcase! if loud?
      iterations.times do
        puts 'the_name'
      end
    end
  end
end
