module RubyTrains
  module TripCalculators
    # RouteDistance
    # This calcualtes the distance of a given route for a network.
    # eg A-B-C-D
    class RouteDistance
      C_ERROR = 'connection error'.freeze

      def initialize(network)
        @distance = 0
        @network = network
      end

      def calculate(route)
        @station = @network.stations[route.shift]
        route.each do |stop|
          raise C_ERROR unless @station.connections.include?(stop)
          add_distance_move_to_next_station(stop)
        end
        @distance
      end

      def add_distance_move_to_next_station(stop)
        @distance += @station.connections[stop].distance
        @station = @network.stations[stop]
      end

      public :calculate

      private :add_distance_move_to_next_station
    end
  end
end
