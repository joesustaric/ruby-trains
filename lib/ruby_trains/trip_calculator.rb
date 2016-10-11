require 'ruby_trains/trip_calculators/shortest_route'
require 'ruby_trains/trip_calculators/route_distance'
require 'ruby_trains/trip_calculators/number_of_trips'
require 'ruby_trains/trip_calculators/number_of_routes_distance'

module RubyTrains
  # This class deals with parsing the input then doing the calculation with
  # the relative trip calculator.
  class TripCalculator
    def self.execute_route_dist_calc(network, trip)
      n = Validator.parse_network network
      t = Validator.parse_trip trip
      calc = TripCalculators::ShortestRoute.new n
      calc.calculate t
    end
  end
end
