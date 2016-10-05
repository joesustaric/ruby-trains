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

      def initialize(network)
        @number_of_routes = 0
        @network = network
      end

      def calculate(trip, max_stops, exact_flag = false)
        @calc_for_exact_dis = exact_flag
        calc_vars = initialize_calulation_vars(trip, max_stops)
        get_trips(calc_vars, INITIAL_TRAVELLED_DISTANCE)
        @number_of_routes
      end

      def get_trips(calc_vars, travelled)
        calc_vars[:from_station].connections.each do |_, c|
          travelled += 1

          if at_dest_and_in_stop_limit?(calc_vars, c, travelled)
            @number_of_routes += 1
          elsif travelled < calc_vars[:max_stops]
            calc_vars[:from_station] = c.station
            get_trips(calc_vars, travelled)
          end

          travelled -= 1
        end
      end

      def initialize_calulation_vars(trip, max_stops)
        {
          from_station: @network.stations[trip[0]],
          to_station: @network.stations[trip[1]],
          max_stops: max_stops
        }
      end

      def at_dest_and_in_stop_limit?(calc_vars, connection, travelled)
        stop_limit = (travelled <= calc_vars[:max_stops])
        stop_limit = (travelled == calc_vars[:max_stops]) if @calc_for_exact_dis
        (calc_vars[:to_station] == connection.station) && stop_limit
      end

      public :calculate

      private :at_dest_and_in_stop_limit?, :initialize_calulation_vars
      private :get_trips
    end
  end
end
