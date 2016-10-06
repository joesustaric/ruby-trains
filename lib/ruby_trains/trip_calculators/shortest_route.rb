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
        calc_vars = initialize_calculation_vars(trip)
        # The steps here make up dijkstra's shortest path algorithm
        while not_reached_destination? calc_vars
          calc_node_weights calc_vars
          determine_next_station calc_vars
          add_current_to_visited calc_vars
        end
        return_destinations_weight calc_vars
      end

      def calc_node_weights(calc_vars)
        # for each connection from the current node dd the weight a of
        # the current node + the dist to all it's connections.
        # If that new value it is lower than the weight of that current
        # value then make it the new weight for that node.
        current_node_weight = get_current_stations_weight calc_vars

        w_graph = calc_vars[:weighted_graph]
        calc_vars[:current].connections.each do |_, c|
          old_weight = w_graph[c.station.name]
          new_weight = current_node_weight + c.distance
          w_graph[c.station.name] = new_weight unless new_weight >= old_weight
        end
      end

      def determine_next_station(calc_vars)
        next_shortest_dist = INFINITY
        next_station = nil
        w_graph = calc_vars[:weighted_graph]

        calc_vars[:current].connections.each do |_, c|
          if w_graph[c.station.name] <= next_shortest_dist
            next_station = c.station
            next_shortest_dist = c.distance
          end
        end
        calc_vars[:current] = next_station
      end

      def initialize_calculation_vars(trip)
        calc_vars = {
          current: @start_station,
          finish: @network.stations[trip[1]],
          visited: Set.new,
          weighted_graph: create_weighted_graph
        }
        alter_vars_if_start_and_finish_equal calc_vars
      end

      def extract_ivars(trip)
        @start_station = @network.stations[trip[0]]
      end

      def create_weighted_graph
        w_graph = {}
        @network.stations.each { |_, s| w_graph[s.name] = INFINITY }
        w_graph[@start_station.name] = 0
        w_graph
      end

      def not_reached_destination?(calc_vars)
        !calc_vars[:visited].include?(calc_vars[:finish])
      end

      def get_current_stations_weight(calc_vars)
        # Need to return 0 if we are calculating a shortest path
        # between the same sation i.e A-A
        # This is because we need to weigh this nodes value as INFINITY
        # as it is also the destination.
        return 0 if current_and_finish_same? calc_vars
        calc_vars[:weighted_graph][calc_vars[:current].name]
      end

      def current_and_finish_same?(calc_vars)
        calc_vars[:current] == calc_vars[:finish]
      end

      def add_current_to_visited(calc_vars)
        calc_vars[:visited] << calc_vars[:current]
      end

      def return_destinations_weight(calc_vars)
        calc_vars[:weighted_graph][calc_vars[:finish].name]
      end

      def alter_vars_if_start_and_finish_equal(calc_vars)
        if current_and_finish_same? calc_vars
          calc_vars[:weighted_graph][@start_station.name] = INFINITY
        end
        calc_vars
      end

      public :calculate

      private :initialize_calculation_vars, :create_weighted_graph
      private :not_reached_destination?, :add_current_to_visited
      private :calc_node_weights, :get_current_stations_weight
      private :determine_next_station, :current_and_finish_same?
      private :alter_vars_if_start_and_finish_equal, :extract_ivars
    end
  end
end
