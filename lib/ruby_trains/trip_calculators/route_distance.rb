module RubyTrains
  module TripCalculators
    # RouteDistance
    # This calcualtes the distance of a given route for a network.
    # eg A-B-C-D
    class RouteDistance
      ERROR = -1

      def self.calculate(network, route)
        return ERROR unless network_and_route_valid?(network, route)

        calc_vars = initialize_calc_vars(network, route)

        calc_vars[:route].each do |stop|
          return ERROR unless calc_vars[:station].connections.include?(stop)
          add_distance_move_to_next_station(network, calc_vars, stop)
        end
        calc_vars[:distance]
      end

      def self.add_distance_move_to_next_station(network, calc_vars, stop)
        calc_vars[:distance] += calc_vars[:station].connections[stop].distance
        calc_vars[:station] = network.stations[stop]
      end

      def self.network_and_route_valid?(network, route)
        !route.empty? && !network.stations.empty?
      end

      def self.initialize_calc_vars(network, route)
        {
          route: route,
          station: network.stations[route.shift],
          distance: 0
        }
      end

      public_class_method :calculate

      private_class_method :network_and_route_valid?, :initialize_calc_vars
      private_class_method :add_distance_move_to_next_station
    end
  end
end
