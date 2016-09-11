module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class TripCalculator
    NO_ROUTE = -1
    # Matches A-B , AA-B-CC, Foo-Bar-A , X-Y-Z-B
    ROUTE_REGEX = /^([A-Za-z]+)(-[A-Za-z]+)*(-[A-Za-z]+)$/
    # Matches A-B , AA-B, Foo-Bar
    TRIP_REGEX = /^([A-Za-z]+)-([A-Za-z]+)$/

    def self.number_of_trips(network, trip = '', max_stops = 0)
      return NO_ROUTE unless trip_input_valid?(trip, max_stops)
      trip = trip.split('-')
      from = network.stations[trip[0]]
      to = network.stations[trip[1]]
      @x = 0
      get_routes(from, to, max_stops, 0)
      @x
    end

    def self.get_routes(from_station, to_station, max_stops, travelled)
      from_station.connections.each do |_, c|
        travelled += 1
        if (to_station == c.station) && (travelled <= max_stops)
          @x += 1
        elsif travelled < max_stops
          get_routes(c.station, to_station, max_stops, travelled)
        end
        travelled -= 1
      end
    end

    def self.route_distance(network, route = '')
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

    def self.initialize_route_distance_vars(network, route)
      r = route_array route
      {
        route: r,
        station: network.stations[r.shift],
        distance: 0
      }
    end

    def self.trip_input_valid?(trip, max_stops)
      !trip.empty? && (trip =~ TRIP_REGEX) && max_stops.positive?
    end

    public_class_method :route_distance, :number_of_trips

    private_class_method :route_array, :network_and_route_valid?
    private_class_method :initialize_route_distance_vars, :get_routes
    private_class_method :add_distance_move_to_next_station, :trip_input_valid?
  end
end
