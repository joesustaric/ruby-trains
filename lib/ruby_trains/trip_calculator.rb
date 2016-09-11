module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class TripCalculator
    NO_ROUTE = -1

    def self.route_distance(network, trip = '')
      return NO_ROUTE if network_or_trip_empty?(network, trip)

      trip = trip_array trip
      station = network.stations[trip.shift]
      distance = 0
      trip.each do |stop|
        return NO_ROUTE unless station.connections.include? stop
        distance += station.connections[stop].distance
        station = network.stations[stop]
      end
      distance
    end

    def self.trip_array(trip)
      trip.split '-'
    end

    def self.network_or_trip_empty?(network, trip)
      trip.empty? || network.stations.empty?
    end

    public_class_method :route_distance
    private_class_method :trip_array, :network_or_trip_empty?
  end
end
