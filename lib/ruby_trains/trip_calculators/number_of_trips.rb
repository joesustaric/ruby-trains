module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class NumberOfTrips
      NO_ROUTE = -1
      # Matches A-B , AA-B, Foo-Bar
      TRIP_REGEX = /^([A-Za-z]+)-([A-Za-z]+)$/
      INITIAL_TRAVELLED_DISTANCE = 0

      def self.number_of_trips(network, trip, max_stops)
        return NO_ROUTE unless trip_input_valid?(trip, max_stops)
        calc_vars = initialize_number_of_trips_vars(network, trip, max_stops)
        get_routes(calc_vars, INITIAL_TRAVELLED_DISTANCE)
        calc_vars[:number_of_routes]
      end

      def self.get_routes(calc_vars, travelled_stops)
        calc_vars[:from_station].connections.each do |_, c|
          travelled_stops += 1

          if at_dest_and_under_max_stops?(calc_vars, c, travelled_stops)
            calc_vars[:number_of_routes] += 1
          elsif travelled_stops < calc_vars[:max_stops]
            calc_vars[:from_station] = c.station
            get_routes(calc_vars, travelled_stops)
          end

          travelled_stops -= 1
        end
      end

      def self.initialize_number_of_trips_vars(network, trip, max_stops)
        trip = trip.split('-')
        {
          from_station: network.stations[trip[0]],
          to_station: network.stations[trip[1]],
          number_of_routes: 0,
          max_stops: max_stops
        }
      end

      def self.at_dest_and_under_max_stops?(calc_vars, connection, travelled)
        (calc_vars[:to_station] == connection.station) &&
          (travelled <= calc_vars[:max_stops])
      end

      def self.trip_input_valid?(trip, max_stops)
        !trip.empty? &&
          (trip =~ TRIP_REGEX) &&
          max_stops.positive?
      end
    end
  end
end
