require 'set'

module RubyTrains
  module TripCalculators
    # ShortestRoute
    # This calculates the length of the shortest path between two stations.
    class ShortestRoute
      INFINITY = 999_999_999 # Not infinity but a large enough number

      def initialize(network)
        @network = network
      end

      def calculate(trip)
        extract_ivars trip
        # The steps here make up dijkstra's shortest path algorithm
        while not_reached_destination?
          calc_node_weights
          determine_next_station
          add_current_to_visited
        end
        return_destinations_weight
      end

      def calc_node_weights
        # for each connection from the current node dd the weight a of
        # the current node + the dist to all it's connections.
        # If that new value it is lower than the weight of that current
        # value then make it the new weight for that node.

        @current_station.connections.each do |_, c|
          old_weight = @w_graph[c.station.name]
          new_weight = current_stations_weight + c.distance
          @w_graph[c.station.name] = new_weight unless new_weight >= old_weight
        end
      end

      def determine_next_station
        next_shortest_dist = INFINITY
        next_station = nil
        w_graph = @w_graph

        @current_station.connections.each do |_, c|
          if w_graph[c.station.name] <= next_shortest_dist
            next_station = c.station
            next_shortest_dist = c.distance
          end
        end
        @current_station = next_station
      end

      def extract_ivars(trip)
        @start_station = @network.stations[trip[0]]
        @current_station = @start_station
        @finish_station = @network.stations[trip[1]]
        @visited_stations = Set.new
        create_weighted_graph
        alter_ivars_if_start_and_finish_equal
      end

      def alter_ivars_if_start_and_finish_equal
        @w_graph[@start_station.name] = INFINITY if current_and_finish_same?
      end

      def create_weighted_graph
        @w_graph = {}
        @network.stations.each { |_, s| @w_graph[s.name] = INFINITY }
        @w_graph[@start_station.name] = 0
      end

      def not_reached_destination?
        !@visited_stations.include?(@finish_station)
      end

      def current_stations_weight
        # Need to return 0 if we are calculating a shortest path
        # between the same sation i.e A-A
        # This is because we need to weigh this nodes value as INFINITY
        # as it is also the destination.
        return 0 if current_and_finish_same?
        @w_graph[@current_station.name]
      end

      def current_and_finish_same?
        @current_station == @finish_station
      end

      def add_current_to_visited
        @visited_stations << @current_station
      end

      def return_destinations_weight
        @w_graph[@finish_station.name]
      end

      public :calculate

      private :create_weighted_graph, :determine_next_station
      private :not_reached_destination?, :add_current_to_visited
      private :calc_node_weights, :current_stations_weight, :extract_ivars
      private :alter_ivars_if_start_and_finish_equal, :current_and_finish_same?
    end
  end
end
