module RubyTrains
  module TripCalculators
    # NumberOfTrips
    # This calculates the number of trips between two stations.
    # The exact flag when true will calcualte the number of trips where the
    # number of stops = max_stops.
    # When false it will be < or = max_stops.
    class NumberOfTrips
      INITIAL_TRAVELLED_HOPS = 0
      FROM_STATION_TRIP_INDEX = 0
      TO_STATION_TRIP_INDEX = 1
      A_HOP = 1

      def initialize(network)
        @number_of_routes = 0
        @network = network
      end

      def calculate(trip, max_stops, exact_flag = false)
        set_ivars(trip, max_stops, exact_flag)
        current_station = @network.stations[@trip[FROM_STATION_TRIP_INDEX]]
        get_trips(current_station, INITIAL_TRAVELLED_HOPS)
        @number_of_routes
      end

      def get_trips(current_station, travelled)
        current_station.connections.each do |_, c|
          travelled += A_HOP

          if at_dest_and_in_stop_limit?(c, travelled)
            @number_of_routes += A_HOP
          elsif travelled < @max_stops
            get_trips(c.station, travelled)
          end

          travelled -= A_HOP
        end
      end

      def set_ivars(trip, max_stops, exact_flag)
        @trip = trip
        @calc_for_exact_dist = exact_flag
        @max_stops = max_stops
      end

      def to_station
        @network.stations[@trip[TO_STATION_TRIP_INDEX]]
      end

      def at_dest_and_in_stop_limit?(connection, travelled)
        stop_limit = (travelled <= @max_stops)
        stop_limit = (travelled == @max_stops) if @calc_for_exact_dist
        (to_station == connection.station) && stop_limit
      end

      public :calculate

      private :at_dest_and_in_stop_limit?, :set_ivars, :get_trips, :to_station
    end
  end
end
