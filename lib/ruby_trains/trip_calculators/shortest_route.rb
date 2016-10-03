require 'set'

module RubyTrains
  module TripCalculators
    # ShortestRoute
    # This calculates the length of the shortest path between two stations.
    class ShortestRoute
      INFINITY = 999_999_999 # Not infinity but a large enough number

      def self.calculate(network, trip)
        calc_vars = initialize_calculation_vars(network, trip)
        # The steps here make up dijkstra's shortest path algorithm
        while not_reached_destination? calc_vars
          calc_node_weights calc_vars
          determine_next_station calc_vars
          add_current_to_visited calc_vars
        end
        return_destinations_weight calc_vars
      end

      def self.calc_node_weights(calc_vars)
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

      def self.determine_next_station(calc_vars)
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

      def self.initialize_calculation_vars(network, trip)
        start = network.stations[trip[0]]
        calc_vars = {
          start: start,
          current: start,
          finish: network.stations[trip[1]],
          visited: Set.new,
          weighted_graph: create_weighted_graph(network, start)
        }
        alter_vars_if_start_and_finish_equal calc_vars
      end

      def self.create_weighted_graph(network, start_station)
        w_graph = {}
        network.stations.each { |_, s| w_graph[s.name] = INFINITY }
        w_graph[start_station.name] = 0
        w_graph
      end

      def self.not_reached_destination?(calc_vars)
        !calc_vars[:visited].include?(calc_vars[:finish])
      end

      def self.get_current_stations_weight(calc_vars)
        # Need to return 0 if we are calculating a shortest path
        # between the same sation i.e A-A
        # This is because we need to weigh this nodes value as INFINITY
        # as it is also the destination.
        return 0 if current_and_finish_same? calc_vars
        calc_vars[:weighted_graph][calc_vars[:current].name]
      end

      def self.current_and_finish_same?(calc_vars)
        calc_vars[:current] == calc_vars[:finish]
      end

      def self.add_current_to_visited(calc_vars)
        calc_vars[:visited] << calc_vars[:current]
      end

      def self.return_destinations_weight(calc_vars)
        calc_vars[:weighted_graph][calc_vars[:finish].name]
      end

      def self.alter_vars_if_start_and_finish_equal(calc_vars)
        if current_and_finish_same? calc_vars
          calc_vars[:weighted_graph][calc_vars[:start].name] = INFINITY
        end
        calc_vars
      end

      public_class_method :calculate

      private_class_method :initialize_calculation_vars, :create_weighted_graph
      private_class_method :not_reached_destination?, :add_current_to_visited
      private_class_method :calc_node_weights, :get_current_stations_weight
      private_class_method :determine_next_station, :current_and_finish_same?
      private_class_method :alter_vars_if_start_and_finish_equal
    end
  end
end
