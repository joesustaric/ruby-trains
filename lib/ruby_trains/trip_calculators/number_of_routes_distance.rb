module RubyTrains
  module TripCalculators
    # NumberOfRoutesDistance
    # This will calculate how many paths there are between two stations,
    # that have a distance < the max_distance.
    class NumberOfRoutesDistance
      def initialize(network)
        @network = network
      end

      def calculate(trip, max_distance)
        calc_vars = initialize_calulation_vars(trip, max_distance)
        how_many_paths(calc_vars[:start], calc_vars, 0)
        calc_vars[:result]
      end

      def how_many_paths(current, calc_vars, current_dist)
        current.connections.each do |_, c|
          next unless dist_less_than_max?(calc_vars, current_dist + c.distance)
          add_result_if_reached_destination calc_vars, c
          how_many_paths(c.station, calc_vars, (current_dist + c.distance))
        end
      end

      def add_result_if_reached_destination(calc_vars, connection)
        calc_vars[:result] += 1 if connection.station == calc_vars[:finish]
      end

      def initialize_calulation_vars(trip, max_distance)
        {
          start: @network.stations[trip[0]],
          finish: @network.stations[trip[1]],
          max_distance: max_distance,
          result: 0
        }
      end

      def dist_less_than_max?(calc_vars, distance)
        distance < calc_vars[:max_distance]
      end

      public :calculate

      private :initialize_calulation_vars, :how_many_paths
      private :dist_less_than_max?
    end
  end
end
