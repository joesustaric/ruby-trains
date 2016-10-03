module RubyTrains
  module TripCalculators
    # NumberOfTrips
    # This calculates the number of trips between two stations.
    # The exact flag when true will calcualte the number of trips where the
    # number of stops = max_stops.
    # When false it will be < or = max_stops.
    class NumberOfTrips
      ERROR = -1
      INITIAL_TRAVELLED_DISTANCE = 0

      def self.calculate(network, trip, max_stops, exact)
        calc_vars = initialize_calulation_vars(network, trip, max_stops, exact)
        get_trips(calc_vars, INITIAL_TRAVELLED_DISTANCE)
        calc_vars[:number_of_routes]
      end

      def self.get_trips(calc_vars, travelled)
        calc_vars[:from_station].connections.each do |_, c|
          travelled += 1

          if at_dest_and_in_stop_limit?(calc_vars, c, travelled)
            calc_vars[:number_of_routes] += 1
          elsif travelled < calc_vars[:max_stops]
            calc_vars[:from_station] = c.station
            get_trips(calc_vars, travelled)
          end

          travelled -= 1
        end
      end

      def self.initialize_calulation_vars(network, trip, max_stops, exact)
        {
          from_station: network.stations[trip[0]],
          to_station: network.stations[trip[1]],
          number_of_routes: 0,
          max_stops: max_stops,
          exact: exact
        }
      end

      def self.at_dest_and_in_stop_limit?(calc_vars, connection, travelled)
        stop_limit = (travelled <= calc_vars[:max_stops])
        stop_limit = (travelled == calc_vars[:max_stops]) if calc_vars[:exact]
        (calc_vars[:to_station] == connection.station) && stop_limit
      end

      public_class_method :calculate

      private_class_method :at_dest_and_in_stop_limit?
      private_class_method :initialize_calulation_vars, :get_trips
    end
  end
end
