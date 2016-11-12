require 'clamp'

module RubyTrains
  # Doco
  class CLI < Clamp::Command
    # option '--loud', :flag, 'say it loud'
    option ['-s', '--shortest-route'], 'TRIP', 'return the shortest route' \
      ' between two stations'

    parameter 'NETWORK ...', 'the train network', attribute_name: :network

    def execute
      net = network.inject('') { |a, e| a + ' ' + e }
      @calc = TripCalculator.new net
      puts @calc.execute_route_dist_calc shortest_route
    end
  end
end
