require 'set'

module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class ShortestRoute
      INFINITY = 999_999_999 # Not infinity but a large enough number

      def self.calculate(network, trip)
        calc_vars = initialize_calculation_vars(network, trip)
        alter_vars_if_start_and_finish_equal calc_vars
        # The steps here make up dijkstra's shortest path algorithm
        while not_reached_destination? calc_vars
          calc_node_weights calc_vars
          determine_next_station calc_vars
          add_current_to_visited calc_vars
        end
        return_destinations_weight calc_vars
      end

      def self.calc_node_weights(calc_vars)
        # for each connection
        # add the weight of the current node + the dist to the connection (x)
        # if it is lower than the weight of that connection then make it the new
        # connection value.
        current_node_weight = get_current_stations_weight calc_vars

        # On trips where start == finish we need to makr the first trip node
        # weight as 0 to ensure the first iteration calcs the weights correctly
        # then this should not happen afterwards.

        w_graph = calc_vars[:weighted_graph]
        calc_vars[:current].connections.each do |_, c|
          old_w = w_graph[c.station.name]
          new_w = current_node_weight + c.distance
          w_graph[c.station.name] = new_w unless new_w >= old_w
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
        trip = trip.split('-')
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
