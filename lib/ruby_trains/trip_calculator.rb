module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class TripCalculator
    NO_ROUTE = -1
    # Matches A-B , AA-B-CC, Foo-Bar-A , X-Y-Z-B
    TRIP_REGEX = /^([A-Za-z]+)(-[A-Za-z]+)*(-[A-Za-z]+)$/

    def self.route_distance(network, trip = '')
      return NO_ROUTE unless network_and_trip_valid?(network, trip)

      calc_vars = initialize_route_distance_vars(network, trip)

      calc_vars[:trip].each do |stop|
        return NO_ROUTE unless calc_vars[:station].connections.include? stop
        add_distance_move_to_next_station network, calc_vars, stop
      end

      calc_vars[:distance]
    end

    def self.add_distance_move_to_next_station(network, calc_vars, stop)
      calc_vars[:distance] += calc_vars[:station].connections[stop].distance
      calc_vars[:station] = network.stations[stop]
    end

    def self.trip_array(trip)
      trip.split '-'
    end

    def self.network_and_trip_valid?(network, trip)
      !trip.empty? && (trip =~ TRIP_REGEX) && !network.stations.empty?
    end

    def self.initialize_route_distance_vars(network, trip)
      t = trip_array trip
      {
        trip: t,
        station: network.stations[t.shift],
        distance: 0
      }
    end

    public_class_method :route_distance
    private_class_method :trip_array, :network_and_trip_valid?
    private_class_method :initialize_route_distance_vars
    private_class_method :add_distance_move_to_next_station
  end
end
