require 'ruby_trains/trip_calculators/shortest_route'
require 'ruby_trains/trip_calculators/route_distance'
require 'ruby_trains/trip_calculators/number_of_trips'
require 'ruby_trains/trip_calculators/number_of_routes_distance'

module RubyTrains
  # This class deals with parsing the input then doing the calculation with
  # the relative trip calculator.
  class TripCalculator
    def initialize(network)
      @network = Validator.parse_network network
    end

    def execute_route_dist_calc(trip)
      t = Validator.parse_trip trip
      calc = TripCalculators::ShortestRoute.new @network
      calc.calculate t
    end
  end
end
