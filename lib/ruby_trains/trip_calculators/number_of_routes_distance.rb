module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class NumberOfRoutesDistance
      def self.calculate(network, trip, max_distance)
        calc_vars = initialize_calulation_vars(network, trip, max_distance)
        how_many_paths(calc_vars[:start], calc_vars, 0)
        calc_vars[:result]
      end

      def self.how_many_paths(current, calc_vars, current_dist)
        current.connections.each do |_, c|
          next unless (current_dist + c.distance) < calc_vars[:max_distance]
          add_result_if_reached_destination calc_vars, c
          how_many_paths(c.station, calc_vars, (current_dist + c.distance))
        end
      end

      def self.add_result_if_reached_destination(calc_vars, connection)
        calc_vars[:result] += 1 if connection.station == calc_vars[:finish]
      end

      def self.initialize_calulation_vars(network, trip, max_distance)
        trip = trip.split('-')
        {
          start: network.stations[trip[0]],
          finish: network.stations[trip[1]],
          max_distance: max_distance,
          result: 0
        }
      end

      public_class_method :calculate

      private_class_method :initialize_calulation_vars, :how_many_paths
    end
  end
end
