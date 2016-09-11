module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class TripCalculator
    NO_ROUTE = -1
    # Matches A-B , AA-B-CC, Foo-Bar-A , X-Y-Z-B
    ROUTE_REGEX = /^([A-Za-z]+)(-[A-Za-z]+)*(-[A-Za-z]+)$/
    # Matches A-B , AA-B, Foo-Bar
    TRIP_REGEX = /^([A-Za-z]+)-([A-Za-z]+)$/
    INITIAL_TRAVELLED_DISTANCE = 0

    def self.number_of_trips(network, trip, max_stops)
      return NO_ROUTE unless trip_input_valid?(trip, max_stops)
      calc_vars = initialize_number_of_trips_vars(network, trip, max_stops)
      get_routes(calc_vars, INITIAL_TRAVELLED_DISTANCE)
      calc_vars[:number_of_routes]
    end

    def self.get_routes(calc_vars, travelled_stops)
      calc_vars[:from_station].connections.each do |_, c|
        travelled_stops += 1

        if at_dest_and_under_max_stops?(calc_vars, c, travelled_stops)
          calc_vars[:number_of_routes] += 1
        elsif travelled_stops < calc_vars[:max_stops]
          calc_vars[:from_station] = c.station
          get_routes(calc_vars, travelled_stops)
        end

        travelled_stops -= 1
      end
    end

    def self.route_distance(network, route)
      return NO_ROUTE unless network_and_route_valid?(network, route)

      calc_vars = initialize_route_distance_vars(network, route)

      calc_vars[:route].each do |stop|
        return NO_ROUTE unless calc_vars[:station].connections.include?(stop)
        add_distance_move_to_next_station(network, calc_vars, stop)
      end

      calc_vars[:distance]
    end

    def self.add_distance_move_to_next_station(network, calc_vars, stop)
      calc_vars[:distance] += calc_vars[:station].connections[stop].distance
      calc_vars[:station] = network.stations[stop]
    end

    def self.route_array(route)
      route.split '-'
    end

    def self.network_and_route_valid?(network, route)
      !route.empty? && (route =~ ROUTE_REGEX) && !network.stations.empty?
    end

    def self.at_dest_and_under_max_stops?(calc_vars, connection, travelled)
      (calc_vars[:to_station] == connection.station) &&
        (travelled <= calc_vars[:max_stops])
    end

    def self.initialize_route_distance_vars(network, route)
      r = route_array route
      {
        route: r,
        station: network.stations[r.shift],
        distance: 0
      }
    end

    def self.initialize_number_of_trips_vars(network, trip, max_stops)
      trip = trip.split('-')
      {
        from_station: network.stations[trip[0]],
        to_station: network.stations[trip[1]],
        number_of_routes: 0,
        max_stops: max_stops
      }
    end

    def self.trip_input_valid?(trip, max_stops)
      !trip.empty? &&
        (trip =~ TRIP_REGEX) &&
        max_stops.positive?
    end

    public_class_method :route_distance, :number_of_trips

    private_class_method :route_array, :network_and_route_valid?
    private_class_method :initialize_route_distance_vars, :get_routes
    private_class_method :add_distance_move_to_next_station, :trip_input_valid?
    private_class_method :initialize_number_of_trips_vars
    private_class_method :at_dest_and_under_max_stops?
  end
end
