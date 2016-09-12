module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class RouteDistance
      ERROR = -1
      # Matches A-B , AA-B-CC, Foo-Bar-A , X-Y-Z-B
      ROUTE_REGEX = /^([A-Za-z]+)(-[A-Za-z]+)*(-[A-Za-z]+)$/

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

      def self.route_array(route)
        route.split '-'
      end

      def self.network_and_route_valid?(network, route)
        !route.empty? && (route =~ ROUTE_REGEX) && !network.stations.empty?
      end

      def self.initialize_calc_vars(network, route)
        r = route_array route
        {
          route: r,
          station: network.stations[r.shift],
          distance: 0
        }
      end

      public_class_method :calculate

      private_class_method :route_array, :network_and_route_valid?
      private_class_method :initialize_calc_vars
      private_class_method :add_distance_move_to_next_station
    end
  end
end
