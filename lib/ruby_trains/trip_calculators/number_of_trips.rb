module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class NumberOfTrips
      ERROR = -1
      # Matches A-B , AA-B, Foo-Bar
      TRIP_REGEX = /^([A-Za-z]+)-([A-Za-z]+)$/
      INITIAL_TRAVELLED_DISTANCE = 0

      def self.calculate(network, trip, max_stops, exact)
        return ERROR unless trip_input_valid?(trip, max_stops)
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
        trip = trip.split('-')
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

      def self.trip_input_valid?(trip, max_stops)
        !trip.empty? &&
          (trip =~ TRIP_REGEX) &&
          max_stops.positive?
      end

      public_class_method :calculate

      private_class_method :trip_input_valid?, :at_dest_and_in_stop_limit?
      private_class_method :initialize_calulation_vars, :get_trips
    end
  end
end
