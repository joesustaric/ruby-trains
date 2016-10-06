module RubyTrains
  module TripCalculators
    # NumberOfRoutesDistance
    # This will calculate how many paths there are between two stations,
    # that have a distance < the max_distance.
    class NumberOfRoutesDistance
      STARTING_PATH_NUMBER = 0
      A_PATH = 1

      def initialize(network)
        @network = network
        @result = 0
      end

      def calculate(trip, max_distance)
        set_ivars(trip, max_distance)
        how_many_paths(@start_station, STARTING_PATH_NUMBER)
        @result
      end

      def how_many_paths(current, current_dist)
        current.connections.each do |_, c|
          next unless dist_less_than_max?(current_dist + c.distance)
          add_result_if_reached_destination c
          how_many_paths(c.station, (current_dist + c.distance))
        end
      end

      def add_result_if_reached_destination(connection)
        @result += A_PATH if connection.station == @finish_station
      end

      def set_ivars(trip, max_distance)
        @start_station = @network.stations[trip[0]]
        @finish_station = @network.stations[trip[1]]
        @max_distance = max_distance
      end

      def dist_less_than_max?(distance)
        distance < @max_distance
      end

      public :calculate

      private :set_ivars, :how_many_paths, :dist_less_than_max?
    end
  end
end
